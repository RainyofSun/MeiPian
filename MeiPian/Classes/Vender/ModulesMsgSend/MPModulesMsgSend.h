//
//  MPModulesMsgSend.h
//  MeiPian
//
//  Created by 刘冉 on 2019/8/28.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPModulesMsgSend : NSObject

/// VC 跳转之间跳转传值
+ (UIViewController *)sendMsg:(id _Nullable)msg vcName:(NSString  * _Nonnull)name;
/// 不同层级之间通信(无参数)
+ (void)sendCumtomMethodMsg:(id _Nullable)obj methodName:(SEL)imp;
/// 不同层级之间通信(有参数)
+ (void)sendCumtomMethodMsg:(id _Nullable)obj methodName:(SEL)imp params:(id)params;

@end

NS_ASSUME_NONNULL_END
