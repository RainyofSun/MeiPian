//
//  MPBaseUserInfoModel.m
//  YiZhan
//
//  Created by YZ_BMAC on 2020/1/14.
//  Copyright © 2020 YZ_BMAC. All rights reserved.
//

#import "MPBaseUserInfoModel.h"

@implementation MPBaseUserInfoModel

- (instancetype)init {
    if (self = [super init]) {
        [self setDefaultData];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)resetData {
    [self setDefaultData];
}

#pragma mark - private methods
- (void)setDefaultData {
    self.userId = @"";
    self.phone = @"";
    self.userHeadImg = [UIImage imageNamed:@"ico-courier-default"];
    self.age = @(0);
    self.realName = @"";
    self.sex = @"";
    self.token = @"";
    self.isWork = @(NO);
}

@end
