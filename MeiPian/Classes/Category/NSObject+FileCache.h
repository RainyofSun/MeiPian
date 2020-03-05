//
//  NSObject+FileCache.h
//  YiZhan
//
//  Created by 刘冉 on 2020/2/9.
//  Copyright © 2020 YZ_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (FileCache)

/*
 自定义方法：获取缓存大小
 */
- (CGFloat)getCacheSize;

/*
 自定义方法，清除APP缓存
 */
- (void)clearCache;

@end

NS_ASSUME_NONNULL_END
