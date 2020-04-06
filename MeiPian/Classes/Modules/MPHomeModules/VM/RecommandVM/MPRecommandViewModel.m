//
//  MPRecommandViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/1.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPRecommandViewModel.h"
#import "MPHomePageConfigModel.h"

@interface MPRecommandViewModel ()

/** topBarSource */
@property (nonatomic,strong) NSMutableArray <NSString *>*topBarSource;
/** subSourceModel */
@property (nonatomic,strong) NSArray <MPHomePageModel *>*subSourceModel;

@end

@implementation MPRecommandViewModel

- (instancetype)init{
    if (self = [super init]) {
        [self setDefaultData];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)MPRecommandArticleInfo:(ReturnValueBlock)dataBlock requestType:(MPLoadingType)loadType articleType:(MPRecommandArticleType)type {
    
}

// 获取数据头
- (NSString *)requestHeader:(NSInteger)page articleType:(MPRecommandArticleType)type {
    NSString *header = nil;
    switch (type) {
        case MPRecommandArticleType_All:
            header = @"all";
            break;
        case MPRecommandArticleType_JingXuan:
            header = @"JingXuan";
            break;
        case MPRecommandArticleType_SheYing:
            header = @"SheYing";
            break;
        case MPRecommandArticleType_QingGan:
            header = @"QingGan";
            break;
        case MPRecommandArticleType_WenXue:
            header = @"WenXue";
            break;
        case MPRecommandArticleType_LvXing:
            header = @"LvXing";
            break;
        default:
            break;
    }
    header = [header stringByAppendingFormat:@"%ld", (long)page];
    return header;
}

// 获取导航栏数据
- (NSArray<NSString *> *)subNavSource {
    return self.topBarSource;
}

#pragma mark - private methods
- (void)setDefaultData {
    WeakSelf;
       [MPLocalData MPGetLocalDataFileName:@"TopBar" localData:^(id  _Nonnull responseObject) {
           MPHomePageConfigModel *topBarModel = [MPHomePageConfigModel modelWithDictionary:(NSDictionary *)responseObject];
           [weakSelf combineTopBarData:topBarModel];
       } errorBlock:^(NSString * _Nullable errorInfo) {
           
       }];
}

- (void)combineTopBarData:(MPHomePageConfigModel *)configModel {
    self.subSourceModel = configModel.sub_channel;
    self.topBarSource = [NSMutableArray arrayWithCapacity:configModel.sub_channel.count];
    WeakSelf;
    [configModel.sub_channel enumerateObjectsUsingBlock:^(MPHomePageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf.topBarSource addObject:obj.tag_name];
    }];
}

@end
