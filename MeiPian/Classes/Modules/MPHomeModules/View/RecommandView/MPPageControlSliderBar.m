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
}

- (void)setupSliderbarItems:(NSArray<NSString *> *)titleSource {
    CGFloat itemW = CGRectGetWidth(self.btnContainerView.bounds)/titleSource.count;
    CGFloat itemH = CGRectGetHeight(self.bounds);
    for (NSInteger i = 0; i < titleSource.count; i ++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.tag = i;
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
}

// 重置状态
- (void)resetTopSliderItemStatus {
    for (UIButton *item in self.btnArray) {
        if (item.selected) {
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

@end
