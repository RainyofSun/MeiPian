//
//  MPBaseTabBarCustomView.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MPTabBarDelegate <NSObject>

- (void)touchMPTabBarItem:(NSInteger)senderTag;

@end

@interface MPBaseTabBarCustomView : UIView

/** mpTabBarrDelegate */
@property (nonatomic,weak) id<MPTabBarDelegate> mpTabBarrDelegate;

- (instancetype)initWithTitleSource:(NSArray <NSString *>*)titles;
- (instancetype)initWithTitleSource:(NSArray <NSString *>*)titles normalImgSources:(NSArray <NSString *>*)normalImgs selectedImgSources:(NSArray <NSString *>*)selectedImgs;

- (void)setupItems;
- (void)setNormalItemTextColor:(UIColor *)normalColor selectedTextColor:(UIColor *)selectedColor;
- (void)setTabBarItemBedgeNum:(NSInteger)bedgeNum itemSelectedIndex:(NSInteger)selectedIndex;
- (void)changeTabBarItemsStatus:(NSInteger)senderTag;

@end
