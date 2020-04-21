//
//  MPMineSliderBarView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineSliderBarView.h"

static CGFloat FontNum = 17;

@interface MPMineSliderBarView ()

/** containerView */
@property (nonatomic,strong) UIView *containerView;
/** btnSource */
@property (nonatomic,strong) NSMutableArray <UIButton *>*btnSource;
/** lineLayer */
@property (nonatomic,strong) CALayer *lineLayer;

@end

@implementation MPMineSliderBarView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.containerView autoCenterInSuperview];
    [self.containerView autoSetDimensionsToSize:CGSizeMake(CGRectGetWidth(self.bounds) * 0.8, CGRectGetHeight(self.bounds))];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadSliderBarTitleSource:(NSArray<NSString *> *)titleSource {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setupBtns:titleSource];
    });
}

- (void)switchSliderBarSlectedItem:(NSNumber *)senderTag {
    [self touchSliderBarItem:self.btnSource[senderTag.integerValue]];
}

- (void)touchSliderBarItem:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    [self resetBtnStatus];
    sender.titleLabel.font = [UIFont boldSystemFontOfSize:FontNum];
    sender.selected = !sender.selected;
    self.lineLayer.centerX = sender.centerX;
    [MPModulesMsgSend sendCumtomMethodMsg:self.superview.superview.superview methodName:@selector(resetScrollViewContentOffset:) params:[NSNumber numberWithInteger:sender.tag]];
}

#pragma mark - private methods
- (void)setupUI {
    self.lineLayer.backgroundColor = MAIN_BLUE_COLOR.CGColor;
    
    [self addSubview:self.containerView];
    [self.containerView.layer addSublayer:self.lineLayer];
}

- (void)setupBtns:(NSArray *)titleSource {
    if (self.btnSource.count) {
        return;
    }
    self.btnSource = [NSMutableArray arrayWithCapacity:titleSource.count];
    CGFloat btnW = CGRectGetWidth(self.bounds) * 0.8 /titleSource.count;
    for (NSInteger i = 0; i < titleSource.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titleSource[i] forState:UIControlStateNormal];
        [btn setTitleColor:MAIN_GRAY_COLOR forState:UIControlStateNormal];
        [btn setTitleColor:MAIN_BLACK_COLOR forState:UIControlStateSelected];
        btn.frame = CGRectMake(btnW * i, 0, btnW, CGRectGetHeight(self.bounds));
        btn.selected = (i == 0);
        btn.titleLabel.font = btn.selected ? [UIFont boldSystemFontOfSize:FontNum] : [UIFont systemFontOfSize:FontNum];
        [btn addTarget:self action:@selector(touchSliderBarItem:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self.containerView addSubview:btn];
        [self.btnSource addObject:btn];
    }
    self.lineLayer.frame = CGRectMake((btnW - 30)/2, CGRectGetHeight(self.bounds)-2, 30, 2);
}

// 重置按钮状态
- (void)resetBtnStatus {
    for (UIButton * btn in self.btnSource) {
        if (btn.selected) {
            btn.selected = NO;
            btn.titleLabel.font = [UIFont systemFontOfSize:FontNum];
            break;
        }
    }
}

#pragma mark - lazy
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (CALayer *)lineLayer {
    if (!_lineLayer) {
        _lineLayer = [CALayer layer];
    }
    return _lineLayer;
}

@end
