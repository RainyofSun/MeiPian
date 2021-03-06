//
//  MPBaseCustomTabBar.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseCustomTabBar.h"
#import "MPBaseTabBarCustomView.h"

@interface MPBaseCustomTabBar ()<MPTabBarDelegate>

/** customBarView */
@property (nonatomic,strong) MPBaseTabBarCustomView *customBarView;
/** isAllowSwitchVC */
@property (nonatomic,assign) BOOL isAllowSwitchVC;
/** selectedIndex */
@property (nonatomic,assign,readwrite) NSInteger selectedIndex;

@end

@implementation MPBaseCustomTabBar

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (instancetype)initWithTitleSource:(NSArray<NSString *> *)titles {
    return [self initWithTitleSource:titles normalImgSources:nil selectedImgSources:nil];
}

- (instancetype)initWithTitleSource:(NSArray<NSString *> *)titles normalImgSources:(NSArray<NSString *> *)normalImgs selectedImgSources:(NSArray<NSString *> *)selectedImgs {
    if (self = [super init]) {
        self.customBarView = [[MPBaseTabBarCustomView alloc] initWithTitleSource:titles normalImgSources:normalImgs selectedImgSources:selectedImgs];
        self.customBarView.mpTabBarrDelegate = self;
        [self addSubview:self.customBarView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.customBarView.frame = self.bounds;
    [self.customBarView setupItems];
    [self bringSubviewToFront:self.customBarView];
}

- (void)setNormalItemTextColor:(UIColor *)normalColor selectedTextColor:(UIColor *)selectedColor {
    [self.customBarView setNormalItemTextColor:normalColor selectedTextColor:selectedColor];
}

- (void)setTabBarItemBedgeNum:(NSInteger)bedgeNum itemSelectedIndex:(NSInteger)selectedIndex {
    [self.customBarView setTabBarItemBedgeNum:bedgeNum itemSelectedIndex:selectedIndex];
}

#pragma mark - MPTabBarDelegate
- (void)touchMPTabBarItem:(NSInteger)senderTag {
    self.selectedIndex = senderTag;
    if (self.tabBarDelegate != nil && [self.tabBarDelegate respondsToSelector:@selector(shouldSelectedViewController:)]) {
        self.isAllowSwitchVC = [self.tabBarDelegate shouldSelectedViewController:senderTag];
    }
}

#pragma mark - setter
- (void)setIsAllowSwitchVC:(BOOL)isAllowSwitchVC {
    _isAllowSwitchVC = isAllowSwitchVC;
    if (_isAllowSwitchVC) {
        [self.customBarView changeTabBarItemsStatus:self.selectedIndex];
        if (self.tabBarDelegate != nil && [self.tabBarDelegate respondsToSelector:@selector(didSelectedViewController:)]) {
            [self.tabBarDelegate didSelectedViewController:self.selectedIndex];
        }
    } else {
        NSLog(@"不允许切换");
    }
}

@end
