//
//  MPBasePopViewController.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPBasePopViewController : MPBaseViewController

/** completeBlock */
@property (nonatomic,copy) void (^completeBlock)(NSInteger senderTag);
/** popSource */
@property (nonatomic,strong) NSArray *popSource;

- (void)showWithPresentVC:(UIViewController* _Nonnull)presentVC CompletionBlock:(void (^_Nullable)(NSInteger buttonIndex))completionBlock;
- (void)dismissViewController:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
