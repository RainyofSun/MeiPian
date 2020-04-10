//
//  MPCustomSliderBarView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/9.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPCustomSliderBarView.h"

@interface MPCustomSliderBarView ()

/** scrollBar */
@property (nonatomic,strong) UIView *scrollBar;
/** backView */
@property (nonatomic,strong) UIView *backView;

@end

@implementation MPCustomSliderBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化设置
        [self initInfo];
        // 创建控件
        [self creatControl];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - 手势方法
- (void)handleTap:(UITapGestureRecognizer *)sender {
    // 点击滚动条返回
    if (sender.view == self.scrollBar) {
        return;
    }
    // 获取点击的位置
    CGFloat positionY = [sender locationInView:self].y;
    // 赋值
    [UIView animateWithDuration:_barMoveDuration animations:^{
        self.yPosition = positionY > self.yPosition ? positionY - self.barHeight : positionY;
    }];
    
    // 代理
    if (self.sliderBarDelegate != nil && [self.sliderBarDelegate respondsToSelector:@selector(scrollBarTouchAction:)]) {
        [self.sliderBarDelegate scrollBarTouchAction:self];
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)sender {
    // 获取偏移量
    CGFloat moveY = [sender translationInView:self].y;
    // 重置偏移量,避免下次获取到的是原基础的增量
    [sender setTranslation:CGPointZero inView:self];
    
    // 在顶部上滑或底部下滑直接返回
    if ((_yPosition <= 0 && moveY <=0) || (_yPosition >= self.bounds.size.height - _barHeight && moveY >= 0)) {
        return;
    }
    // 赋值
    self.yPosition += moveY;
    // 防止瞬间打偏移滑动影响显示效果
    if (_yPosition < 0) {
        self.yPosition = 0;
    }
    if (_yPosition > self.bounds.size.height - _barHeight && moveY  >= 0) {
        self.yPosition = self.bounds.size.height - _barHeight;
    }
    
    // 代理
    if (self.sliderBarDelegate != nil && [self.sliderBarDelegate respondsToSelector:@selector(scrollBarDidiScroll:)]) {
        [self.sliderBarDelegate scrollBarDidiScroll:self];
    }
}

#pragma mark - private methods
- (void)initInfo {
    _minBarHeight = 40.f;
    _barMoveDuration = 0.25f;
    _foreColor = [UIColor colorWithRed:143/255.0 green:143/255.0 blue:143/255.0 alpha:1];
    _backColor = [UIColor clearColor];
    self.sliderBarEnabled = NO;
    
    self.layer.cornerRadius = self.bounds.size.width / 2;
    self.clipsToBounds = YES;
    self.backgroundColor = _backColor;
}

- (void)creatControl {
    // 背景视图
    _backView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_backView];
    
    // 滚动条
    _scrollBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _scrollBar.backgroundColor = _foreColor;
    _scrollBar.layer.cornerRadius = self.bounds.size.width / 2;
    _scrollBar.clipsToBounds = YES;
    [self addSubview:_scrollBar];
}

- (void)addSwipeGesture {
    // 点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.backView addGestureRecognizer:tap];
    
    // 滑动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.scrollBar addGestureRecognizer:pan];
}

#pragma mark - setter
- (void)setSliderBarEnabled:(BOOL)sliderBarEnabled {
    _sliderBarEnabled = sliderBarEnabled;
    if (sliderBarEnabled) {
        // 添加手势
        [self addSwipeGesture];
    }
}

- (void)setForeColor:(UIColor *)foreColor {
    _foreColor = foreColor;
    self.scrollBar.backgroundColor = foreColor;
}

- (void)setBackColor:(UIColor *)backColor {
    _backColor = backColor;
    self.backgroundColor = backColor;
}

- (void)setBarHeight:(CGFloat)barHeight {
    _barHeight = barHeight > _minBarHeight ? barHeight : _minBarHeight;
    CGRect temFrame = self.scrollBar.frame;
    temFrame.size.height = _barHeight;
    self.scrollBar.frame = temFrame;
}

- (void)setYPosition:(CGFloat)yPosition {
    _yPosition = yPosition;
    CGRect tempFrame = self.scrollBar.frame;
    tempFrame.origin.y = yPosition;
    self.scrollBar.frame = tempFrame;
}

@end
