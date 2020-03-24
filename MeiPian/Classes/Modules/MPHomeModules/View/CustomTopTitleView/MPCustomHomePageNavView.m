//
//  MPCustomHomePageNavView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/24.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPCustomHomePageNavView.h"

@interface MPCustomHomePageNavView ()

/** calenderBtn */
@property (nonatomic,strong) UIButton *calenderBtn;
/** searchBtn */
@property (nonatomic,strong) UIButton *searchBtn;

@end

@implementation MPCustomHomePageNavView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.calenderBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.calenderBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self withOffset:15];
    [self.calenderBtn autoSetDimensionsToSize:CGSizeMake(40, 40)];
    
    [self.searchBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.searchBtn autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self withOffset:-15];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - private methods
- (void)setupUI {
    
    self.backgroundColor = [UIColor yellowColor];
    
    [self.calenderBtn setTitle:@"18" forState:UIControlStateNormal];
    [self.searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];

    [self addSubview:self.calenderBtn];
    [self addSubview:self.searchBtn];
}

#pragma mark - lazy
- (UIButton *)calenderBtn {
    if (!_calenderBtn) {
        _calenderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _calenderBtn;
}

- (UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _searchBtn;
}

@end
