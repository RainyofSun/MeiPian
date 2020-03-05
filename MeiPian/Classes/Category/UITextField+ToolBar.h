//
//  UITextField+ToolBar.h
//  YiZhan
//
//  Created by YZ_BMAC on 2020/1/15.
//  Copyright © 2020 YZ_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (ToolBar)

/// 添加ToolBar
- (void)addCompleteToolBar:(id)target sel:(SEL)sel;

@end

NS_ASSUME_NONNULL_END
