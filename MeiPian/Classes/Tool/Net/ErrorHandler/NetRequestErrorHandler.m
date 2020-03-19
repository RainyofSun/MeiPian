//
//  NetRequestErrorHandler.m
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/26.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import "NetRequestErrorHandler.h"

@implementation NetRequestErrorHandler

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+ (void)netRequestErrorHandler:(NSError *)error {
    [MBHUDToastManager hideAlert];
    [MBHUDToastManager showBriefAlert:error.localizedDescription];
}

@end
