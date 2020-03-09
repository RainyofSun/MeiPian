//
//  MPModulesMsgSend.m
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/28.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import "MPModulesMsgSend.h"

@implementation MPModulesMsgSend

+ (UIViewController *)sendMsg:(id)msg vcName:(nonnull NSString *)name{
    Class VC = NSClassFromString(name);
    if (VC) {
        UIViewController *obj = [[VC alloc] init];
        ((void (*)(id,SEL,id))objc_msgSend)(obj,@selector(modulesSendMsg:),msg);
        return obj;
    } else {
        UIViewController *obj = [[UIViewController alloc] init];
        obj.view.backgroundColor = [UIColor whiteColor];
        return obj;
    }
}

+ (void)sendCumtomMethodMsg:(id)obj methodName:(SEL)imp{
    [self sendCumtomMethodMsg:obj methodName:imp params:[NSNull class]];
}

+ (void)sendCumtomMethodMsg:(id)obj methodName:(SEL)imp params:(id)params {
    if (![obj isKindOfClass:[NSNull class]]) {
        if ([params isKindOfClass:[NSNull class]]) {
            ((void (*) (id, SEL)) (void *)objc_msgSend)(obj, imp);
        } else {
            ((void (*)(id,SEL,id))objc_msgSend)(obj,imp,params);
        }
    } else {
        NSLog(@"未找到消息执行者");
    }
}

@end
