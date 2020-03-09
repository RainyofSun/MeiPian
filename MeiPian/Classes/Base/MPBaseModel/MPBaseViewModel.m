//
//  MPBaseViewModel.m
//  YiZhan
//
//  Created by YZ_BMAC on 2020/1/13.
//  Copyright © 2020 YZ_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"

@implementation MPBaseViewModel

- (void)dealloc {
    if (self.requestTaskArray.count) {
        [self.requestTaskArray removeAllObjects];
    }
    NSLog(@"DELLOC : BASEVM %@",NSStringFromClass(self.class));
}

#pragma mark - lazy
- (NSMutableArray<NSURLSessionDataTask *> *)requestTaskArray {
    if (!_requestTaskArray) {
        _requestTaskArray = [NSMutableArray array];
    }
    return _requestTaskArray;
}

@end
