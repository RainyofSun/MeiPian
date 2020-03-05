//
//  NSString+JSEscape.h
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/9/6.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JSEscape)

/**
 字符串转义
 @return 转义后的字符串
 */
- (NSString *)encodeWithEscape;

@end

NS_ASSUME_NONNULL_END
