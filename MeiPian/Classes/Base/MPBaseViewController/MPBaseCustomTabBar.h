//
//  MPBaseCustomTabBar.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MPCustomTabBarDelegate <NSObject>

@required;
/// 将要选择VC
- (BOOL)shouldSelectedViewController:(NSInteger)viewControllerIndex;
/// 确认选择VC
- (void)didSelectedViewController:(NSInteger)viewControllerIndex;

@end

@interface MPBaseCustomTabBar : UITabBar

/** tabBarDelegate */
@property (nonatomic,weak) id<MPCustomTabBarDelegate> tabBarDelegate;
/** selectedIndex */
@property (nonatomic,readonly) NSInteger selectedIndex;

- (instancetype)initWithTitleSource:(NSArray <NSString *>*)titles;
- (instancetype)initWithTitleSource:(NSArray <NSString *>*)titles normalImgSources:(NSArray <NSString *>*)normalImgs selectedImgSources:(NSArray <NSString *>*)selectedImgs;

- (void)setNormalItemTextColor:(UIColor *)normalColor selectedTextColor:(UIColor *)selectedColor;
- (void)setTabBarItemBedgeNum:(NSInteger)bedgeNum;

@end
