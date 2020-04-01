//
//  NSObject+Observer.h
//  MeiPian
//
//  Created by 刘冉 on 2019/8/23.
//  Copyright © 2019 MP_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Observer)

- (void)MP_RemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;
- (void)MP_AddLEDObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end

NS_ASSUME_NONNULL_END
