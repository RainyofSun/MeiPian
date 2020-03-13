//
//  MPUserInfoModel.m
//  YiZhan
//
//  Created by YZ_BMAC on 2020/1/14.
//  Copyright © 2020 YZ_BMAC. All rights reserved.
//

#import "MPUserInfoModel.h"

@implementation MPUserInfoModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.userHeadImg forKey:@"userHeadImg"];
    [aCoder encodeObject:self.age forKey:@"age"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.realName forKey:@"realName"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.isWork forKey:@"isWork"];
    [aCoder encodeObject:self.tokenTimesTamp forKey:@"tokenTimesTamp"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        if (self != nil) {
            self.phone = [aDecoder decodeObjectForKey:@"phone"];
            self.userHeadImg = [aDecoder decodeObjectForKey:@"userHeadImg"];
            self.age = [aDecoder decodeObjectForKey:@"age"];
            self.userId = [aDecoder decodeObjectForKey:@"userId"];
            self.realName = [aDecoder decodeObjectForKey:@"realName"];
            self.sex = [aDecoder decodeObjectForKey:@"sex"];
            self.token = [aDecoder decodeObjectForKey:@"token"];
            self.isWork = [aDecoder decodeObjectForKey:@"isWork"];
            self.tokenTimesTamp = [aDecoder decodeObjectForKey:@"tokenTimesTamp"];
        }
    }
    return self;
}

@end
