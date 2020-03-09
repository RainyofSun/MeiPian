//
//  MPBaseWebViewController.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/9.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPBaseH5MsgDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPBaseWebViewController : MPBaseViewController

/** webView */
@property (nonatomic,strong) WKWebView *webView;
/** webUrl */
@property (nonatomic,copy) NSString *webUrl;
/** h5Msg_delegate */
@property (nonatomic,weak) id<MPBaseH5MsgDelegate> h5Msg_delegate;
/** 是否显示导航栏 */
@property (nonatomic,assign) BOOL isHideNav;
/** 是否显示活动指示器 */
@property (nonatomic,assign) BOOL isHideActivity;
/// 重新设置webViewInset
- (void)reloadWebviewInset;
/// 重载页面
- (void)reloadWebviewPage;

@end

NS_ASSUME_NONNULL_END
