//
//  MPBaseTableViewDataSource.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class MPBaseTableView;

@protocol MPBaseTableViewDataSource <NSObject>

@required;
/**
 要展示cell数

 @return 返回分页数
 */
- (NSInteger)MPNumberOfRowsInSection;

/**
 根据index返回对应的Cell

 @param tableView UITableView实例
 @param index 当前位置
 @return 返回要展示的UITableViewCell
 */
- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index;

@optional;
/**
 上拉加载更多数据
 */
- (void)MPPullRefreshDataSource;

/**
下拉刷新数据
 */
- (void)MPDropRefreshLoadMoreSource;

@end

NS_ASSUME_NONNULL_END
