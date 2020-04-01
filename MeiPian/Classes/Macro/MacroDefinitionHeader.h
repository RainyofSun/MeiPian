//
//  MacroDefinitionHeader.h
//  MeiPian
//
//  Created by 刘冉 on 2019/8/17.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#ifndef MacroDefinitionHeader_h
#define MacroDefinitionHeader_h

// 系统判断
//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
// 大于 iOS 10的系统
#define ABOVE_IOS10 (([[[UIDevice currentDevice] systemVersion] floatValue] >=10.0) ? YES : NO)

#define ScreenWidth    [UIScreen mainScreen].bounds.size.width
#define ScreenHeight   [UIScreen mainScreen].bounds.size.height
#define SizeWidth(W)   (W*(ScreenWidth)/375)
#define SizeHeight(H)  (H*(ScreenHeight)/667)
/*状态栏高度*/
#define kStatusBarHeight (CGFloat)(IPHONEXAbove?(44.0):(20.0))
/*导航栏高度*/
#define kNavBarHeight (44)
/*状态栏和导航栏总高度*/
#define kNavBarAndStatusBarHeight (CGFloat)(IPHONEXAbove?(88.0):(64.0))
/*TabBar高度*/
#define kTabBarHeight (CGFloat)(IPHONEXAbove?(49.0 + 34.0):(49.0))
/*顶部安全区域远离高度*/
#define kTopBarSafeHeight (CGFloat)(IPHONEXAbove?(44.0):(0))
/*底部安全区域远离高度*/
#define kBottomSafeHeight (CGFloat)(IPHONEXAbove?(34.0):(0))
/*iPhoneX的状态栏高度差值*/
#define kTopBarDifHeight (CGFloat)(IPHONEXAbove?(24.0):(0))
/*导航条和Tabbar总高度*/
#define kNavAndTabHeight (kNavBarAndStatusBarHeight + kTabBarHeight)

#define KeyWindow           [[[UIApplication sharedApplication] delegate] window]

// 数据最大值
#define MAXDATA     10
// 动画时间
#define ALPHAANIMATIONTIME  0.6

// 设备判断
#define IS_IPHONE   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_PAD      (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IPHONEXAbove (([[NSString stringWithFormat:@"%.2f",ScreenHeight/ScreenWidth] floatValue])>([[NSString stringWithFormat:@"%.2f",16.0/9] floatValue]))

// 颜色
#define RGB(R,G,B)  [UIColor colorWithRed:(R * 1.0) / 255.0 green:(G * 1.0) / 255.0 blue:(B * 1.0) / 255.0 alpha:1.0]
#define RGBA(R,G,B,A)  [UIColor colorWithRed:(R * 1.0) / 255.0 green:(G * 1.0) / 255.0 blue:(B * 1.0) / 255.0 alpha:A]
#define HexColor(hexValue)  [UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 green:((float)(((hexValue) & 0xFF00) >> 8))/255.0 blue:((float)((hexValue) & 0xFF))/255.0 alpha:1.0]   //16进制颜色值，如：#000000 , 注意：在使用的时候hexValue写成：0x000000
#define HexAColor(hexValue,a)  [UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 green:((float)(((hexValue) & 0xFF00) >> 8))/255.0 blue:((float)((hexValue) & 0xFF))/255.0 alpha:a]
#define MAIN_BLUE_COLOR     RGB(48, 130, 255)
#define MAIN_BLACK_COLOR    RGB(31, 31, 31)
#define MAIN_GRAY_COLOR     RGB(147,157,166)
#define MAIN_LIGHT_GRAY_COLOR   RGB(237,239,245)

#define LEDTOSTVITHMEAGE(message,superView) \
if (message!=nil) {\
MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];\
hud.mode = MBProgressHUDModeText;\
hud.userInteractionEnabled= NO;\
hud.margin = 15.0f;\
hud.minSize = CGSizeMake(120, 50);\
hud.label.text = message;\
hud.label.numberOfLines = 0;\
hud.label.font = [UIFont systemFontOfSize:17];\
[hud hideAnimated:YES afterDelay:1.5f];\
}\

#define WeakSelf  __weak typeof(self) weakSelf = self
#define StrongSelf  __strong typeof(self) strongSelf = weakSelf

#ifdef DEBUG
#define FLOG(__FORMAT__, ...) NSLog((@"%s line %d $ " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define FLOG(__FORMAT__, ...)
#endif

#endif /* MacroDefinitionHeader_h */
