//
//  UITextField+ToolBar.m
//  YiZhan
//
//  Created by YZ_BMAC on 2020/1/15.
//  Copyright © 2020 YZ_BMAC. All rights reserved.
//

#import "UITextField+ToolBar.h"

@implementation UITextField (ToolBar)

- (void)addCompleteToolBar:(id)target sel:(SEL)sel {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 40)];
    toolbar.tintColor = [UIColor systemBlueColor];
    toolbar.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:target action:sel];
    toolbar.items = @[space,bar];
    self.inputAccessoryView = toolbar;
}

@end
