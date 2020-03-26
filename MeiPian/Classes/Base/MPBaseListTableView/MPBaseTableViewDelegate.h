//
//  MPBaseTableViewDelegate.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MPBaseTableView;

@protocol MPBaseTableViewDelegate <NSObject>

@optional;
/**
 选中cell，点击回调
 @param tableView 实例
 @param index 切换的位置
 */
- (void)MPBaseTableView:(MPBaseTableView *)tableView didSelectedAtIndex:(NSIndexPath *)index;

/**
 设置cell的高度
 @return 返回cell高度 默认高度45
 */
- (CGFloat)MPHeightForRowAtIndexPath;

@end

NS_ASSUME_NONNULL_END
