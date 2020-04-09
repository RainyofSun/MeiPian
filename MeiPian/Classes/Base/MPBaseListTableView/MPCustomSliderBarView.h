//
//  MPCustomSliderBarView.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/9.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MPCustomSliderBarView;

@protocol MPCustomSliderBarDelegate <NSObject>

@optional;
/// 滚动条滑动事件
- (void)scrollBarDidiScroll:(MPCustomSliderBarView *)scrollBar;
/// 滚动条点击事件
- (void)scrollBarTouchAction:(MPCustomSliderBarView *)scrollBar;

@end

@interface MPCustomSliderBarView : UIView

/** 背景色 */
@property (nonatomic,strong) UIColor *backColor;
/** 前景色 */
@property (nonatomic,strong) UIColor *foreColor;
/** 滚动动画时长 */
@property (nonatomic,assign) CGFloat barMoveDuration;
/** 限制滚动条的最小高度 */
@property (nonatomic,assign) CGFloat minBarHeight;
/** 滚动条实际高度 */
@property (nonatomic,assign) CGFloat barHeight;
/** 滚动条Y向位置 */
@property (nonatomic,assign) CGFloat yPosition;
/** 是否开启交互 默认不开启 */
@property (nonatomic,assign) BOOL sliderBarEnabled;
/** sliderBarDelegate */
@property (nonatomic,weak) id<MPCustomSliderBarDelegate> sliderBarDelegate;

@end

NS_ASSUME_NONNULL_END
