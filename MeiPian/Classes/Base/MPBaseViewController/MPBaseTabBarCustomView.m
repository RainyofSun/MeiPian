//
//  MPBaseTabBarCustomView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseTabBarCustomView.h"
#import "MPBaseTabBarItem.h"

@interface MPBaseTabBarCustomView ()

/** titles */
@property (nonatomic,strong) NSArray <NSString *>*titles;
/** normalImgs */
@property (nonatomic,strong) NSArray <NSString *>*normalImgs;
/** selectedImgs */
@property (nonatomic,strong) NSArray <NSString *>*selectedImgs;
/** itemSource */
@property (nonatomic,strong) NSMutableArray <MPBaseTabBarItem *>*itemSource;
/** normalColor */
@property (nonatomic,strong) UIColor *normalColor;
/** selectedColor */
@property (nonatomic,strong) UIColor *selectedColor;
/** emptyTitleIndex */
@property (nonatomic,assign) NSInteger emptyTitleIndex;
/** lineLayer */
@property (nonatomic,strong) CALayer *lineLayer;

@end

@implementation MPBaseTabBarCustomView

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (instancetype)initWithTitleSource:(NSArray<NSString *> *)titles {
    return [self initWithTitleSource:titles normalImgSources:nil selectedImgSources:nil];
}

- (instancetype)initWithTitleSource:(NSArray<NSString *> *)titles normalImgSources:(NSArray<NSString *> *)normalImgs selectedImgSources:(NSArray<NSString *> *)selectedImgs {
    if (self = [super init]) {
        _titles = titles;
        _itemSource = [NSMutableArray arrayWithCapacity:titles.count];
        if (normalImgs.count) {
            _normalImgs = normalImgs;
        }
        if (selectedImgs.count) {
            _selectedImgs = selectedImgs;
        }
    }
    return self;
}

- (void)setNormalItemTextColor:(UIColor *)normalColor selectedTextColor:(UIColor *)selectedColor {
    self.normalColor = normalColor;
    self.selectedColor = selectedColor;
}

- (void)setTabBarItemBedgeNum:(NSInteger)bedgeNum itemSelectedIndex:(NSInteger)selectedIndex {
    self.itemSource[selectedIndex].bedgeNum = bedgeNum;
}

- (void)touchCustomTabBarItem:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    if (sender.tag != self.emptyTitleIndex) {
        [self resetItemStatus];
        [self switchItemAnimationScale:sender.titleLabel];
        sender.selected = !sender.selected;
    }
    if (self.mpTabBarrDelegate != nil && [self.mpTabBarrDelegate respondsToSelector:@selector(touchMPTabBarItem:)]) {
        [self.mpTabBarrDelegate touchMPTabBarItem:sender.tag];
    }
}

- (void)setupItems {
    if (_itemSource.count) {
        return;
    }
    CGFloat itemW = CGRectGetWidth(self.bounds)/_titles.count;
    CGFloat itemH = CGRectGetHeight(self.bounds);
    for (NSInteger i = 0; i < _titles.count; i ++) {
        MPBaseTabBarItem *item = [MPBaseTabBarItem buttonWithType:UIButtonTypeCustom];
        item.tag = i;
        item.frame = CGRectMake(itemW * i, 0, itemW, itemH);
        item.selected = (i == 0);
        if (!_titles[i].length) {
            self.emptyTitleIndex = i;
        }
        i == 0 ? [self switchItemAnimationScale:item.titleLabel] : nil;
        [item setTitle:_titles[i] forState:UIControlStateNormal];
        if (_normalColor) {
            [item setTitleColor:_normalColor forState:UIControlStateNormal];
        } else {
            [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if (_selectedColor) {
            [item setTitleColor:_selectedColor forState:UIControlStateSelected];
        } else {
            [item setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        }
        if (_titles[i].length) {
            if (_normalImgs.count && i < _normalImgs.count) {
                [item setImage:[UIImage imageNamed:_normalImgs[i]] forState:UIControlStateNormal];
                [self changeBarItemTopImgBottomText:item];
            }
            if (_selectedImgs.count && i < _selectedImgs.count) {
                [item setImage:[UIImage imageNamed:_selectedImgs[i]] forState:UIControlStateSelected];
            }
        } else {
            [item setImage:[UIImage imageNamed:@"add_icon"] forState:UIControlStateNormal];
            [item setImage:[UIImage imageNamed:@"add_icon_press"] forState:UIControlStateHighlighted];
        }
        [item addTarget:self action:@selector(touchCustomTabBarItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        [_itemSource addObject:item];
    }
    self.lineLayer = [CALayer layer];
    self.lineLayer.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1].CGColor;
    self.lineLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 1);
    [self.layer addSublayer:self.lineLayer];
}

#pragma mark - private methods
// 修改图文位置
- (void)changeBarItemTopImgBottomText:(UIButton *)item {
    CGFloat interval = 1.0;
    CGSize imageSize = item.imageView.bounds.size;
    [item setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + interval, -(imageSize.width), 0, 0)];
    CGSize titleSize = item.titleLabel.bounds.size;
    [item setImageEdgeInsets:UIEdgeInsetsMake(0,0, titleSize.height + interval, -(titleSize.width))];
}

// 重置按钮状态
- (void)resetItemStatus {
    for (UIButton *item in _itemSource) {
        if (item.selected) {
            [self switchItemAnimationNormal:item.titleLabel];
            item.selected = NO;
            break;
        }
    }
}

// 切换动画 -- 放大
- (void)switchItemAnimationScale:(UIView *)item {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithFloat:1.];
    animation.toValue = [NSNumber numberWithFloat:1.1];
    animation.duration = .2;
    animation.repeatCount = 0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [item.layer addAnimation:animation forKey:@"zoom"];
}

// 切换动画 -- 正常
- (void)switchItemAnimationNormal:(UIView *)item {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithFloat:1.1];
    animation.toValue = [NSNumber numberWithFloat:1.];
    animation.duration = .2;
    animation.repeatCount = 0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [item.layer addAnimation:animation forKey:@"zoom"];
}

@end
