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

/**
 创建列表
 */
+ (MPBaseTableView *)setupListView;

/**
 自定义cell时用到
 */
- (void)registerClass:(NSString *)cellClassName forTableViewCellWithReuseIdentifier:(NSString *)identifier withNibFile:(BOOL)hasXibFile;

/**
 自定义cell时用到
 返回复用的cell
 */
- (__kindof UITableViewCell *)dequeueReusableTableViewCellWithIdentifier:(NSString *)identifier forIndex:(NSIndexPath *)index;

/**
 获取对应Index的Cell
 */
- (nullable __kindof UITableViewCell *)MPBaseTableViewCellForRowAtIndex:(NSIndexPath *)index;

@end

NS_ASSUME_NONNULL_END
