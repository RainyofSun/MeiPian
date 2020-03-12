//
//  TelephoneCodeIndexView.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/12.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TelephoneCodeIndexDelegate <NSObject>

/// 选择字母索引回调
- (void)didSelectedAlphabetIndex:(NSInteger)index;

@end

@interface TelephoneCodeIndexView : UIView

/** alphabetIndexDelegate */
@property (nonatomic,weak) id<TelephoneCodeIndexDelegate> alphabetIndexDelegate;

/// 加载索引数据
- (void)loadIndexSource:(NSArray *)indexSource;

@end

NS_ASSUME_NONNULL_END
