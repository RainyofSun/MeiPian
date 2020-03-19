//
//  BusinessRequestErrorHander.h
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/9/4.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BusinessRequestErrorHander : NSObject

+ (void)bussinessRequestHander:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
