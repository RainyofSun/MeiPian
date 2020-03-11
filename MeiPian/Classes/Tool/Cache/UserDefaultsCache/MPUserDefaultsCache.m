//
//  MPUserDefaultsCache.m
//  MeiPian
//
//  Created by MP_BMAC on 2019/11/8.
//  Copyright © 2019 MP_BMAC. All rights reserved.
//

#import "MPUserDefaultsCache.h"

@implementation MPUserDefaultsCache

+ (void)MPCacheValue:(id)value forKey:(NSString *)key {
    if (value && key.length) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        NSLog(@"存储数据不合法");
    }
}

+ (id)MPGetCacheValueForKey:(NSString *)key {
    if (key.length) {
        id value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        return value;
    } else {
        NSLog(@"key 不合法");
        return nil;
    }
}

+ (BOOL)MPRemoveValueForKey:(NSString *)key {
    BOOL remove = NO;
    if (key.length) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        remove = YES;
    } else {
        NSLog(@"key 不合法");
    }
    return remove;
}

@end
