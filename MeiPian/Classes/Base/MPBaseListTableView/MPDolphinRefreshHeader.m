//
//  MPDolphinRefreshHeader.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPDolphinRefreshHeader.h"

@interface MPDolphinRefreshHeader ()

/** animationImgView */
@property (nonatomic,strong) YYAnimatedImageView *animationImgView;

@end

@implementation MPDolphinRefreshHeader

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark -重写方法
- (void)prepare {
    [super prepare];
    self.stateLabel.hidden = self.lastUpdatedTimeLabel.hidden = self.gifView.hidden = YES;
    [self addSubview:self.animationImgView];
}

- (void)placeSubviews {
    [super placeSubviews];
    CGFloat itemW = 62;
    self.animationImgView.frame = CGRectMake(ScreenWidth/2 - itemW/2, CGRectGetHeight(self.bounds)/2 - itemW/2, itemW, itemW);
    self.animationImgView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
             /** 普通闲置状态 */
            //在这里设置子控件在普通闲置状态的界面展示
            self.animationImgView.image = [UIImage imageNamed:@"mp_refresh_normal"];
            break;
        case MJRefreshStatePulling:
            /** 松开就可以进行刷新的状态 */
            //在这里设置子控件在松开就可以进行刷新的状态的界面展示
            self.animationImgView.image = [UIImage imageNamed:@"mp_refresh_ready"];
            break;
        case MJRefreshStateRefreshing:
            /** 正在刷新中的状态 */
            //在这里设置子控件在正在刷新中的状态的界面展示
            self.animationImgView.image = [YYImage imageNamed:@"mp_refreshing"];
            break;
        case MJRefreshStateWillRefresh:
            /** 即将要刷新的状态 */
            break;
        case MJRefreshStateNoMoreData:
            /** 没有更多数据了 */
            break;
        default:
            break;
    }
}

#pragma mark - lazy
- (YYAnimatedImageView *)animationImgView {
    if (!_animationImgView) {
        _animationImgView = [[YYAnimatedImageView alloc] init];
    }
    return _animationImgView;
}

@end
