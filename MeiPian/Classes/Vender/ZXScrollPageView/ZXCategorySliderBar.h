//
//  ZXCategorySliderBar.h
//  ZXCollectionSliderBar
//
//  Created by zhaoxu on 2017/4/18.
//  Copyright © 2017年 zhaoxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(ZXExtension)

@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;

@end


@protocol ZXCategorySliderBarDelegate <NSObject>

- (void)didSelectedIndex:(NSInteger)index;

@end

@interface ZXCategorySliderBar : UIView

@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, assign) NSInteger originIndex;
@property (nonatomic, weak) id<ZXCategorySliderBarDelegate> delegate;
@property (nonatomic, strong) UIView *indicateView;
@property (nonatomic, assign) BOOL isMoniteScroll;
@property (nonatomic, strong) UIScrollView *moniterScrollView;

@property (nonatomic, assign) CGFloat scrollViewLastContentOffset;

- (void)setSelectIndex:(NSInteger)index;

- (void)adjustIndicateViewX:(UIScrollView *)scrollView direction:(NSString *)direction;

/// 设置元素之间的间隔
- (instancetype)initWithFrame:(CGRect)frame itemInterval:(CGFloat)interval;

@end
