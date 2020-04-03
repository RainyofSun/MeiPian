//
//  MPSheYingArticleView.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/2.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPSheYingArticleView : UIView

/** listTableView */
@property (nonatomic,strong) MPBaseTableView *listTableView;
/// 上层手动触发列表上拉刷新
- (void)manualTriggerArticleRefresh;
/// 重置刷新状态
- (void)resetManualTriggerStatus;

@end

NS_ASSUME_NONNULL_END
