//
//  MPMineArticleScrollView.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPMineArticleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPMineArticleScrollView : UIView

/** artcileViewH */
@property (nonatomic,readonly) CGFloat artcileViewH;

- (void)loadMineArticleSource:(MPMineArticleModel *)articleSource;
- (void)loadMineArticleHeightSource:(NSArray <NSNumber *>*)articleHeightSource;
- (void)resetSubScrollViewContentOffSet:(NSNumber *)senderTag;
- (MPBaseTableView *)getArticleCellTableView;

@end

NS_ASSUME_NONNULL_END
