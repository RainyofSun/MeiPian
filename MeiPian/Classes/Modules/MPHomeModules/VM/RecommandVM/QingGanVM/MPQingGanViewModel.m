//
//  MPQingGanViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/3.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPQingGanViewModel.h"

@implementation MPQingGanViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)MPRecommandArticleInfo:(ReturnValueBlock)dataBlock requestType:(MPLoadingType)loadType articleType:(MPRecommandArticleType)type {
    [super MPRecommandArticleInfo:dataBlock requestType:loadType articleType:type];
}

@end
