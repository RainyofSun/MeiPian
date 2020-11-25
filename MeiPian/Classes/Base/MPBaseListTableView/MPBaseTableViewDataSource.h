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
 分组数 默认为1
 */
- (NSInteger)MPNumberOfSections;

/**
 组头/组尾视图
 */
- (UIView *)MPBaseTableView:(MPBaseTableView *)tableview headerFooterInSection:(NSInteger)section isSectionHeader:(BOOL)sectionHeader;

/**
 编辑模式 默认删除
 */
- (UITableViewCellEditingStyle)MPBaseTableViewEditingStyleForRowAtIndexPath:(NSIndexPath *)index;

/**
 进入编辑模式操作处理
 */
- (void)MPBaseTableViewCellEditingAtIndexPath:(NSIndexPath *)index;

/**
 自定义删除按钮 仅限iOS11.0之后
 Example:
     UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
         [self.titleArr removeObjectAtIndex:indexPath.row];
         completionHandler (YES);
         [self.tableView reloadData];
     }];
     deleteRowAction.image = [UIImage imageNamed:@"删除"];
     deleteRowAction.backgroundColor = [UIColor redColor];
     UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
     return config;
 */
- (UISwipeActionsConfiguration *)MPBaseTableViewTrailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)index API_AVAILABLE(ios(11.0));

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
