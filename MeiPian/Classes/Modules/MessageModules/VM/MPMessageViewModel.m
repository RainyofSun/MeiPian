//
//  MPMessageViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMessageViewModel.h"

@interface MPMessageViewModel ()

/** pushMsgSource */
@property (nonatomic,strong) NSMutableArray <MPPushMessageModel *>*pushMsgSource;
/** configModelSource */
@property (nonatomic,strong) NSMutableArray <MPMessageConfigModel *>*configModelSource;
/** msgModel */
@property (nonatomic,strong) MPMessageModel *msgModel;
/** bedgeNum */
@property (nonatomic,readwrite) NSInteger bedgeNum;
/** subUnreadCount */
@property (nonatomic,assign) NSInteger subUnreadCount;

@end

@implementation MPMessageViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 获取数据
- (void)MPMessageRequestInfo:(ReturnValueBlock)dataBlock loadType:(MPLoadingType)loadType {
    dispatch_group_t netGroup = dispatch_group_create();
    WeakSelf;
    
    dispatch_group_enter(netGroup);
    [MPLocalData MPGetLocalDataFileName:@"MessageListData" localData:^(id  _Nonnull responseObject) {
        weakSelf.pushMsgSource = [MPPushMessageModel modelArrayWithDictArray:(NSArray *)responseObject];
        dispatch_group_leave(netGroup);
    } errorBlock:^(NSString * _Nullable errorInfo) {
        dispatch_group_leave(netGroup);
    }];
    
    dispatch_group_enter(netGroup);
    [MPLocalData MPGetLocalDataFileName:@"MessageData" localData:^(id  _Nonnull responseObject) {
        weakSelf.msgModel = [MPMessageModel modelWithDictionary:(NSDictionary *)responseObject];
        dispatch_group_leave(netGroup);
    } errorBlock:^(NSString * _Nullable errorInfo) {
        dispatch_group_leave(netGroup);
    }];
    
    dispatch_group_notify(netGroup, dispatch_get_main_queue(), ^{
        if (dataBlock) {
            dataBlock([weakSelf combineSource]);
        }
    });
}

// 删除推送消息数据
- (NSArray <MPMessageConfigModel *>*)deletePushMsgInfo:(NSInteger)pushMsgIndex {
    MPMessageConfigModel *configModel = self.configModelSource.lastObject;
    self.subUnreadCount = self.pushMsgSource[pushMsgIndex].unread_count.integerValue;
    [self.pushMsgSource removeObjectAtIndex:pushMsgIndex];
    configModel.pushMsg = self.pushMsgSource;
    configModel.cellHeight = 75 * self.pushMsgSource.count + 8;
    return [self.configModelSource copy];
}

// 获取未读消息数目
- (NSNumber *)unreadMsgCount {
    return [NSNumber numberWithInteger:(self.bedgeNum -= self.subUnreadCount)];
}

#pragma mark - private methods
- (NSArray <MPMessageConfigModel *>*)combineSource {
    self.subUnreadCount = self.bedgeNum = 0;
    MPMessageConfigModel *configModel0 = [[MPMessageConfigModel alloc] init];
    configModel0.cellStyle = MsgCellStyle_MsgTypeCell;
    configModel0.cellHeight = 110;
    configModel0.msgModel = self.msgModel;
    
    for (MPPushMessageModel *pushModel in self.pushMsgSource) {
        pushModel.unreadNumW = [pushModel.unread_count.stringValue widthForFont:[UIFont systemFontOfSize:13]] + 10;
        pushModel.unreadNumW = pushModel.unreadNumW < 17 ? 17 : pushModel.unreadNumW;
        self.bedgeNum += pushModel.unread_count.integerValue;
    }
    
    MPMessageConfigModel *configModel1 = [[MPMessageConfigModel alloc] init];
    configModel1.cellStyle = MsgCellStyle_PushMsgcell;
    configModel1.cellHeight = 75 * self.pushMsgSource.count + 8;
    configModel1.pushMsg = self.pushMsgSource;
    self.configModelSource = [NSMutableArray arrayWithObjects:configModel0,configModel1, nil];
    return [self.configModelSource copy];
}

@end
