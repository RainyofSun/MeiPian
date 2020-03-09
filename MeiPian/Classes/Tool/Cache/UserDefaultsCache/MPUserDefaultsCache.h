//
//  MPUserDefaultsCache.h
//  XiaoYeMa
//
//  Created by MP_BMAC on 2019/11/8.
//  Copyright © 2019 MP_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPUserDefaultsCache : NSObject

+ (void)MPCacheValue:(id)value forKey:(NSString *)key;
+ (id)MPGetCacheValueForKey:(NSString *)key;
+ (BOOL)MPRemoveValueForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
