//
//  NSObject+Observer.h
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/23.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Observer)

- (void)YZ_RemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;
- (void)YZ_AddLEDObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end

NS_ASSUME_NONNULL_END
