//
//  MPRecommandViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/1.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPRecommandViewModel.h"

@implementation MPRecommandViewModel

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

@end
