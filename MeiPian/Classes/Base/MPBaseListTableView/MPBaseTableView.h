//
//  MPBaseTableView.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPBaseTableViewDelegate.h"
#import "MPBaseTableViewDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPBaseTableView : UITableView

/** tableDelegate */
@property (nonatomic,weak) id<MPBaseTableViewDelegate> tableDalegate;
/** tableDataSource */
@property (nonatomic,weak) id<MPBaseTableViewDataSource> tableDataSource;
/** isCompleteRequest 数据访问结束,结束刷新状态 */
@property (nonatomic,assign) BOOL isCompleteRequest;
/** isOpenFooterRefresh 是否开启上拉加载 默认开启 */
@property (nonatomic,assign) BOOL isOpenFooterRefresh;
/** isOpenHeaderRefresh 是否开启下拉刷新 默认开启 设置关闭会移除刷新 */
@property (nonatomic,assign) BOOL isOpenHeaderRefresh;
/** isShowCustomSliderImgView 是否显示自定义的滚动条 默认不显示 必须在tableView已添加到父view上后设置 */
@property (nonatomic,assign) BOOL isShowCustomSliderImgView;
/** isOpenEdit 是否开启编辑模式 默认不开启 */
@property (nonatomic,assign) BOOL isOpenEdit;
/** sliderBarForeColor 滑动条前景色 */
@property (nonatomic,strong) UIColor *sliderBarForeColor;
/** sliderBarBackColor 滑动条背景色 */
@property (nonatomic,strong) UIColor *sliderBarBackColor;
/** sliderBarMinHeight 滑动条最小高度 默认40.f */
@property (nonatomic,assign) CGFloat sliderBarMinHeight;

/**
 创建列表
 */
+ (MPBaseTableView *)setupListView;

/**
 自定义cell时用到
 */
- (void)registerClass:(NSString *)cellClassName forTableViewCellWithReuseIdentifier:(NSString *)identifier withNibFile:(BOOL)hasXibFile;

/**
 自定义组头/组尾
 */
- (void)registerClass:(NSString *)headerFooterName forHeaderFooterViewReuseIdentifier:(NSString *)identifier withNibFile:(BOOL)hasXibFile isSectionHeader:(BOOL)sectionHeader;

/**
 自定义cell时用到
 返回复用的cell
 */
- (__kindof UITableViewCell *)dequeueReusableTableViewCellWithIdentifier:(NSString *)identifier forIndex:(NSIndexPath *)index;

/**
 获取对应的SectionHeader/SectionFooter
 返回复用的SectionHeader/SectionFooter
 */
- (nullable __kindof UITableViewHeaderFooterView *)dequeueCustomReusableHeaderFooterViewWithIdentifier:(NSString *)identifier;

/**
 获取对应Index的Cell
 */
- (nullable __kindof UITableViewCell *)MPBaseTableViewCellForRowAtIndex:(NSIndexPath *)index;

/**
 自定义Slider出现动画
 */
- (void)customSliderBarShowAlphaAnimation;
/**
 自定义Slider消失动画
 */
- (void)customSliderBarDisAlphaAnimation;

@end

NS_ASSUME_NONNULL_END
