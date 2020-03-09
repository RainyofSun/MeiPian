//
//  MPBaseH5MsgDelegate.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/9.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MPBaseH5MsgDelegate <NSObject>

/// H5传递消息到原生
- (void)H5PostMsgToNative:(WKScriptMessage *)msg SELName:(NSString *)sel_name;

@end

NS_ASSUME_NONNULL_END
