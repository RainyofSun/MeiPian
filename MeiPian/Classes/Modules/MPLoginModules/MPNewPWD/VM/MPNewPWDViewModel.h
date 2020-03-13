//
//  MPNewPWDViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPNewPWDViewModel : MPBaseViewModel

/** phone */
@property (nonatomic,strong) NSString *phone;

/// 加载主界面
- (void)loadNewPWDMainView:(UIViewController *)vc;
/// 界面按钮点击逻辑
- (void)mainViewBtnLogic:(UIViewController *)vc senderTag:(NSNumber *)senderTag;

@end

NS_ASSUME_NONNULL_END
