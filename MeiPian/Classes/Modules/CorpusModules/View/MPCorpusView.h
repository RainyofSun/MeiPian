//
//  MPCorpusView.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/18.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPCorpusView : UIView

/// 关闭按钮旋转动画
- (void)closeBtnRotatingAnimation;
/// 弹性动画
- (void)corpusSpringAnimation;

@end

NS_ASSUME_NONNULL_END
