//
//  MPPageControlSliderBar.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPPageControlSliderBar.h"

@interface MPPageControlSliderBar ()

/** btnContainerView */
@property (nonatomic,strong) UIView *btnContainerView;
/** btnArray */
@property (nonatomic,strong) NSMutableArray <UIButton *>*btnArray;
/** lineLayer */
@property (nonatomic,strong) CALayer *lineLayer;

/** itemWidthArray */
@property (nonatomic,strong) NSMutableArray *itemWidthArray;
/** itemOriginXArray */
@property (nonatomic,strong) NSMutableArray *itemOriginXArray;
/** distance */
@property (nonatomic,assign) CGFloat distance;

@end

@implementation MPPageControlSliderBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)dealloc {
    for (UIButton *item in _btnArray) {
        [item removeFromSuperview];
    }
    [self.btnArray removeAllObjects];
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadSliderBarTitleSource:(NSArray<NSString *> *)titleSource {
    self.btnArray = [NSMutableArray arrayWithCapacity:titleSource.count];
    self.itemWidthArray = [NSMutableArray arrayWithCapacity:titleSource.count];
    self.itemOriginXArray = [NSMutableArray arrayWithCapacity:titleSource.count];
    [self setupSliderbarItems:titleSource];
}

- (void)lineAnimation:(NSInteger)senderTag {
    [self touchTopSliderBar:self.btnArray[senderTag]];
}

- (void)touchTopSliderBar:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    [self resetTopSliderItemStatus];
    [self switchItemAnimationScale:sender.titleLabel];
    [UIView animateWithDuration:0.3 animations:^{
        sender.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        self.lineLayer.centerX = sender.centerX;
    }];
    sender.titleLabel.alpha = 1;
    sender.selected = !sender.selected;
    [MPModulesMsgSend sendCumtomMethodMsg:self.superview methodName:@selector(switchTopSliderBarItem:) params:[NSNumber numberWithInteger:sender.tag]];
}

#pragma mark - private methods
- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.btnContainerView.backgroundColor = [UIColor whiteColor];
    self.btnContainerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds) * 0.67, CGRectGetHeight(self.bounds));
    self.btnContainerView.centerX = self.centerX;
    [self addSubview:self.btnContainerView];
    
    self.lineLayer.cornerRadius = 2.f;
    self.lineLayer.masksToBounds = YES;
    self.lineLayer.backgroundColor = RGB(38, 121, 255).CGColor;
    [self.btnContainerView.layer addSublayer:self.lineLayer];
}

- (void)setupSliderbarItems:(NSArray<NSString *> *)titleSource {
    CGFloat itemW = CGRectGetWidth(self.btnContainerView.bounds)/titleSource.count;
    CGFloat itemH = CGRectGetHeight(self.bounds);
    for (NSInteger i = 0; i < titleSource.count; i ++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.tag = i;
        i == 0 ? [self switchItemAnimationScale:item.titleLabel] : nil;
        i != 0 ? item.titleLabel.alpha = 0.8 : 1;
        item.selected = (i == 0);
        [item setTitle:titleSource[i] forState:UIControlStateNormal];
        [item setTitleColor:RGB(31, 31, 31) forState:UIControlStateNormal];
        item.selected ? item.titleLabel.font = [UIFont boldSystemFontOfSize:17] : nil;
        [item addTarget:self action:@selector(touchTopSliderBar:) forControlEvents:UIControlEventTouchUpInside];
        item.frame = CGRectMake(itemW * i, 0, itemW, itemH);
        [self.btnContainerView addSubview:item];
        [self.btnArray addObject:item];
    }
    CGFloat lineW = [titleSource.firstObject widthForFont:[UIFont boldSystemFontOfSize:17]] * 0.75;
    self.lineLayer.frame = CGRectMake(0, itemH - 5, lineW, 3);
    self.lineLayer.centerX = self.btnArray.firstObject.centerX;
    self.distance = itemW - lineW;
}

// 切换动画 -- 放大
- (void)switchItemAnimationScale:(UIView *)item {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithFloat:1.];
    animation.toValue = [NSNumber numberWithFloat:1.05];
    animation.duration = .2;
    animation.repeatCount = 0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [item.layer addAnimation:animation forKey:@"zoom"];
}

// 切换动画 -- 正常
- (void)switchItemAnimationNormal:(UIView *)item {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithFloat:1.05];
    animation.toValue = [NSNumber numberWithFloat:1.];
    animation.duration = .2;
    animation.repeatCount = 0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [item.layer addAnimation:animation forKey:@"zoom"];
}

// 重置状态
- (void)resetTopSliderItemStatus {
    for (UIButton *item in self.btnArray) {
        if (item.selected) {
            [self switchItemAnimationNormal:item.titleLabel];
            item.titleLabel.font = [UIFont systemFontOfSize:17];
            item.titleLabel.alpha = 0.8;
            item.selected = NO;
            break;
        }
    }
}

#pragma mark - lazy
- (UIView *)btnContainerView {
    if (!_btnContainerView) {
        _btnContainerView = [[UIView alloc] init];
    }
    return _btnContainerView;
}

- (CALayer *)lineLayer {
    if (!_lineLayer) {
        _lineLayer = [CALayer layer];
    }
    return _lineLayer;
}

@end
