//
//  MPMessagePageView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMessagePageView.h"
#import "MPMessageTypeTableViewCell.h"
#import "MPPushMessageTableViewCell.h"
#import "MPMessageViewModel.h"

static NSString *MessageTypeCell = @"MessageTypeCell";
static NSString *MessagePushCell = @"PushMessageCell";

@interface MPMessagePageView ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource>

/** listTableView */
@property (nonatomic,strong) MPBaseTableView *listTableView;
/** msgSource */
@property (nonatomic,strong) NSArray <MPMessageConfigModel *>*msgSource;
/** msgVM */
@property (nonatomic,strong) MPMessageViewModel *msgVM;
/** isLoadFirst */
@property (nonatomic,assign) BOOL isLoadFirst;

@end

@implementation MPMessagePageView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.listTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - MPBaseTableViewDelegate & MPBaseTableViewDataSource
- (NSInteger)MPNumberOfRowsInSection {
    return self.msgSource.count;
}

- (CGFloat)MPHeightForRowAtIndexPath:(NSIndexPath *)index {
    NSLog(@"skskkssk %f",self.msgSource[index.row].cellHeight);
    return self.msgSource[index.row].cellHeight;
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    MPMessageConfigModel *configModel = self.msgSource[index.row];
    switch (configModel.cellStyle) {
        case MsgCellStyle_MsgTypeCell:
        {
            MPMessageTypeTableViewCell *cell = [tableView dequeueReusableTableViewCellWithIdentifier:MessageTypeCell forIndex:index];
            [cell loadMessageTypeCellSource:configModel.msgModel.head_group_list];
            return cell;
        }
        case MsgCellStyle_PushMsgcell:
        {
            MPPushMessageTableViewCell *cell = [tableView dequeueReusableTableViewCellWithIdentifier:MessagePushCell forIndex:index];
            [cell loadPushMessageCellSource:configModel.pushMsg];
            return cell;
        }
        default:
            break;
    }
    return nil;
}

- (void)MPBaseTableView:(MPBaseTableView *)tableView didSelectedAtIndex:(NSIndexPath *)index {
    
}

- (void)MPBaseTableView:(MPBaseTableView *)tableView willDisplayCell:(UITableViewCell *)cell withRowAndIndex:(NSIndexPath *)index {
    MPMessageConfigModel *configModel = self.msgSource[index.row];
    switch (configModel.cellStyle) {
        case MsgCellStyle_MsgTypeCell:
        {
            MPMessageTypeTableViewCell *typeCell = (MPMessageTypeTableViewCell *)cell;
            [typeCell cellAlphaAnimation];
        }
            break;
        case MsgCellStyle_PushMsgcell:
        {
            MPPushMessageTableViewCell *pushCell = (MPPushMessageTableViewCell *)cell;
            [pushCell cellAlphaAnimation];
        }
            break;
        default:
            break;
    }
}

- (void)MPDropRefreshLoadMoreSource {
    [self requestMsgSource:(self.isLoadFirst ? MPLoadingType_Normal : MPLoadingType_Refresh)];
}

#pragma mark - private methods
- (void)setupUI {
    self.listTableView = [MPBaseTableView setupListView];
    self.listTableView.showsHorizontalScrollIndicator = NO;
    self.listTableView.isOpenFooterRefresh = NO;
    self.listTableView.tableDalegate = self;
    self.listTableView.tableDataSource = self;
    [self addSubview:self.listTableView];
    [self.listTableView registerClass:@"MPMessageTypeTableViewCell" forTableViewCellWithReuseIdentifier:MessageTypeCell withNibFile:YES];
    [self.listTableView registerClass:@"MPPushMessageTableViewCell" forTableViewCellWithReuseIdentifier:MessagePushCell withNibFile:NO];
    self.isLoadFirst = YES;
}

- (void)requestMsgSource:(MPLoadingType)loadType {
    WeakSelf;
    [self.msgVM MPMessageRequestInfo:^(id  _Nonnull returnValue) {
        weakSelf.msgSource = (NSArray <MPMessageConfigModel *>*)returnValue;
        weakSelf.listTableView.isCompleteRequest = YES;
        weakSelf.isLoadFirst = NO;
    } loadType:loadType];
}

#pragma mark - lazy
- (MPMessageViewModel *)msgVM {
    if (!_msgVM) {
        _msgVM = [[MPMessageViewModel alloc] init];
    }
    return _msgVM;
}

@end
