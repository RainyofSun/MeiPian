//
//  MPMineViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineViewModel.h"

@interface MPMineViewModel ()

/** infoModel */
@property (nonatomic,strong) MPMineInfoModel *infoModel;
/** articleModel */
@property (nonatomic,strong) MPMineArticleModel *articleModel;
/** configSource */
@property (nonatomic,strong) NSMutableArray <MPMineConfigModel *>*configSource;

@end

@implementation MPMineViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 请求个人数据
- (void)MPMineInfoRequest:(ReturnValueBlock)dataBlock {
    dispatch_group_t netGroup = dispatch_group_create();
    
    WeakSelf;
    dispatch_group_enter(netGroup);
    [MPLocalData MPGetLocalDataFileName:@"MineData" localData:^(id  _Nonnull responseObject) {
        weakSelf.articleModel = [MPMineArticleModel modelWithDictionary:(NSDictionary *)responseObject];
        dispatch_group_leave(netGroup);
    } errorBlock:^(NSString * _Nullable errorInfo) {
        dispatch_group_leave(netGroup);
    }];
    
    dispatch_group_enter(netGroup);
    [MPLocalData MPGetLocalDataFileName:@"MineInfo" localData:^(id  _Nonnull responseObject) {
        weakSelf.infoModel = [MPMineInfoModel modelWithDictionary:(NSDictionary *)responseObject];
        dispatch_group_leave(netGroup);
    } errorBlock:^(NSString * _Nullable errorInfo) {
        dispatch_group_leave(netGroup);
    }];
    
    dispatch_group_notify(netGroup, dispatch_get_main_queue(), ^{
        if (dataBlock) {
            dataBlock([weakSelf combineMineData]);
        }
    });
}

#pragma mark - private methods
- (NSArray <MPMineConfigModel *>*)combineMineData {
    MPMineConfigModel *model0 = [[MPMineConfigModel alloc] init];
    self.infoModel.attentionStr = [self mineInfoAttributeStringBuilder:[NSString stringWithFormat:@"%@ 关注",self.infoModel.follow_count]];
    self.infoModel.fansStr = [self mineInfoAttributeStringBuilder:[NSString stringWithFormat:@"%@ 粉丝",self.infoModel.follower_count]];
    self.infoModel.visitStr = [self mineInfoAttributeStringBuilder:[NSString stringWithFormat:@"%@ 阅读",self.infoModel.visit_count]];
    model0.infoModel = self.infoModel;
    model0.cellHeight = 220;
    model0.cellType = MineCellStyle_info;
    
    MPMineConfigModel *model1 = [[MPMineConfigModel alloc] init];
    model1.cellHeight = 600;
    model1.cellType = MineCellStyle_Article;
    model1.articleModel = self.articleModel;
    model1.sliderTitleSource = @[[NSString stringWithFormat:@"作品 %ld",self.articleModel.articles.count],@"作品集 0",@"收藏 0"];

    self.configSource = [NSMutableArray arrayWithObjects:model0,model1, nil];
    
    return [self.configSource copy];
}

// 富文本生成器
- (NSAttributedString *)mineInfoAttributeStringBuilder:(NSString *)normalStr {
    NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:normalStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:HexColor(0x9E9D9D)}];
    [mutableStr addAttributes:@{NSForegroundColorAttributeName:MAIN_BLACK_COLOR,NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} range:NSMakeRange(0, (normalStr.length - 2))];
    return [mutableStr copy];
}

@end
