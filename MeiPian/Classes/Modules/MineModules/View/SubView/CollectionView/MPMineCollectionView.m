//
//  MPMineCollectionView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/20.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineCollectionView.h"
#import "MPMineCollectionSliderBarView.h"

@interface MPMineCollectionView ()

/** mainScrollView */
@property (nonatomic,strong) UIScrollView *mainScrollView;
/** sliderBarView */
@property (nonatomic,strong) MPMineCollectionSliderBarView *sliderBarView;

@end

@implementation MPMineCollectionView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.sliderBarView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.sliderBarView autoSetDimension:ALDimensionHeight toSize:50];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - private methods
- (void)setupUI {
    [self addSubview:self.sliderBarView];
}

#pragma mark - lazy
- (MPMineCollectionSliderBarView *)sliderBarView {
    if (!_sliderBarView) {
        _sliderBarView = [[MPMineCollectionSliderBarView alloc] init];
    }
    return _sliderBarView;
}

@end
