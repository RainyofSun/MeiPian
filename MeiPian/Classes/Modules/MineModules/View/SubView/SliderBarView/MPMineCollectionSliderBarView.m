//
//  MPMineCollectionSliderBarView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/22.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineCollectionSliderBarView.h"

@interface MPMineCollectionSliderBarView ()

/** btnSource */
@property (nonatomic,strong) NSMutableArray <UIButton *>*btnSource;
/** titleSource */
@property (nonatomic,strong) NSArray <NSString *>*titleSource;
/** lineLayer */
@property (nonatomic,strong) CALayer *lineLayer;

@end

@implementation MPMineCollectionSliderBarView

- (instancetype)init {
    if (self = [super init]) {
        [self setDefaultSource];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupUI];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)clickSliderBarItem:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    [self resetItemStatus];
    sender.selected = !sender.selected;
    sender.backgroundColor = RGB(242, 244, 246);
}

#pragma mark - private methods
- (void)setupUI {
    if (self.btnSource.count) {
        return;
    }
    self.backgroundColor = [UIColor whiteColor];
    self.lineLayer.backgroundColor = RGB(239, 241, 244).CGColor;
    [self.layer addSublayer:self.lineLayer];
    self.btnSource = [NSMutableArray arrayWithCapacity:self.titleSource.count];
    CGFloat itemW = 0;
    CGFloat Padding = 10;
    CGFloat itemH = CGRectGetHeight(self.bounds) * 0.6;
    CGFloat itemY = CGRectGetHeight(self.bounds) * 0.2;
    for (NSInteger i = 0; i < self.titleSource.count; i ++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        [item setTitle:self.titleSource[i] forState:UIControlStateNormal];
        [item setTitleColor:MAIN_BLACK_COLOR forState:UIControlStateSelected];
        [item setTitleColor:RGB(135, 135, 136) forState:UIControlStateNormal];
        item.titleLabel.font = [UIFont systemFontOfSize:15];
        item.selected = (i == 0);
        item.backgroundColor = item.selected ? RGB(242, 244, 246) : [UIColor whiteColor];
        [item addTarget:self action:@selector(clickSliderBarItem:) forControlEvents:UIControlEventTouchUpInside];
        itemW = [item.currentTitle widthForFont:[UIFont systemFontOfSize:15]] + 30;
        if (i < 2) {
            item.frame = CGRectMake((itemW + Padding) * i + 15, itemY, itemW, itemH);
        } else {
            item.frame = CGRectMake(130 + 15, itemY, itemW, itemH);
        }
        item.layer.cornerRadius = itemH/2.3;
        item.clipsToBounds = YES;
        [self addSubview:item];
        [self.btnSource addObject:item];
    }
    self.lineLayer.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-1, CGRectGetWidth(self.bounds), 1);
}

- (void)setDefaultSource {
    self.titleSource = @[@"文章",@"话题",@"赞过的视频"];
}

- (void)resetItemStatus {
    for (UIButton *item in self.btnSource) {
        if (item.selected) {
            item.selected = NO;
            item.backgroundColor = [UIColor whiteColor];
            break;
        }
    }
}

#pragma mark - lazy
- (CALayer *)lineLayer {
    if (!_lineLayer) {
        _lineLayer = [CALayer layer];
    }
    return _lineLayer;
}

@end
