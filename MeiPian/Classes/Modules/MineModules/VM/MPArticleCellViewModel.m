//
//  MPArticleCellViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPArticleCellViewModel.h"

@implementation MPArticleCellViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (CGFloat)articlrViewH:(NSInteger)senderTag {
    return self.articleHeightSource[senderTag].floatValue;
}

@end
