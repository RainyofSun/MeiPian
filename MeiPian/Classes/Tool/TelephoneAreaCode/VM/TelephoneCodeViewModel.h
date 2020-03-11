//
//  TelephoneCodeViewModel.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TelephoneCodeViewModel : NSObject

/// 加载主界面
- (void)loadTelephoneCodeMainView:(UIViewController *)vc;
/// 加载searchVC
- (void)loadNavSearchItem:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
