//
//  MPBaseWebViewController.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/9.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "MPNavigationViewController.h"

@interface MPBaseWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

/** activityView */
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation MPBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    [self resgiterWebView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count < 1) {
        //禁用侧滑手势方法
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.navigationController.viewControllers.count < 1) {
        //禁用侧滑手势方法
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self resik];
}

- (void)loadRequest {
    if (!self.webUrl.length) {
        return;
    }
    [self setdefaultData];
    if ([self.webUrl hasPrefix:@"http"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    } else {
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        NSString * htmlCont = [NSString stringWithContentsOfFile:self.webUrl encoding:NSUTF8StringEncoding error:nil];
        [self.webView loadHTMLString:htmlCont baseURL:baseURL];
    }
}

- (BOOL)navigationShouldPopOnBackButton {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        return NO;
    }
    return YES;
}

- (void)reloadWebviewInset {
    [self.webView autoRemoveConstraintsAffectingView];
    if (ScreenWidth > ScreenHeight) {
        [self.webView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(IPHONEXAbove?84:32, 0, 0, 0)];
    } else {
        [self.webView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(IPHONEXAbove?84:64, 0, 0, 0)];
    }
}

- (void)reloadWebviewPage {
    [self.webView reload];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.activityIndicatorView startAnimating];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.activityIndicatorView stopAnimating];
    WeakSelf;
    [self.webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if ([result isKindOfClass:[NSString class]]) {
            weakSelf.title = result;
        }
    }];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.activityIndicatorView stopAnimating];
    LEDTOSTVITHMEAGE(@"页面加载失败", KeyWindow);
}

- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    // 支持window.open(),需要打开新界面是,WKWebView的代理```WKUIDelegate```方法
    // 会拦截到window.open()事件. 只需要我们在在方法内进行处理
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    
    return nil;
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([[NSThread currentThread] isMainThread]) {
        if (self.h5Msg_delegate != nil && [self.h5Msg_delegate respondsToSelector:@selector(H5PostMsgToNative:SELName:)]) {
            [self.h5Msg_delegate H5PostMsgToNative:message SELName:message.name];
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.h5Msg_delegate != nil && [self.h5Msg_delegate respondsToSelector:@selector(H5PostMsgToNative:SELName:)]) {
                [self.h5Msg_delegate H5PostMsgToNative:message SELName:message.name];
            }
        });
    }
}

-(void)resik {
    [[self.webView configuration].userContentController removeAllUserScripts];
    [[self.webView configuration].userContentController removeScriptMessageHandlerForName:SEL_NAME_POST_MSG];
}

// WKWebView不验证Https
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *card = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
        if (completionHandler) {
            completionHandler(NSURLSessionAuthChallengeUseCredential, card);
        }
    }
}

-(void)setSupportedInterfaceMaskLandscape:(BOOL)orientation {
    if ([self.navigationController isKindOfClass:[MPNavigationViewController class]]) {
        if (orientation) {
            [(MPNavigationViewController*)self.navigationController setOrientationMask:UIInterfaceOrientationMaskAllButUpsideDown preferredInterfaceOrientation:UIInterfaceOrientationPortrait];
        }else{
            [(MPNavigationViewController*)self.navigationController setOrientationMask:UIInterfaceOrientationMaskPortrait preferredInterfaceOrientation:UIInterfaceOrientationPortrait];
        }
        
    }
}

#pragma mark - UI
- (void)setUI {
    
//    self.navigationController.navigationBar.topItem.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.activityIndicatorView.backgroundColor = [UIColor lightGrayColor];
    self.activityIndicatorView.layer.cornerRadius = 10;
    self.activityIndicatorView.clipsToBounds = YES;
    
    [self.view addSubview:self.webView];
    [self.webView addSubview:self.activityIndicatorView];
    
    [self reloadWebviewInset];
    
    self.activityIndicatorView.frame = CGRectMake(0, 0, 100, 100);
    self.activityIndicatorView.center = KeyWindow.center;
}

-(void)resgiterWebView {
    [[self.webView configuration].userContentController addScriptMessageHandler:self name:SEL_NAME_POST_MSG];
}

- (void)setdefaultData {
    self.isHideActivity = NO;
    //    self.isHideNav = NO;
}

#pragma mark - setter/getter
- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
        webViewConfiguration.allowsInlineMediaPlayback = YES;
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:webViewConfiguration];
    }
    return _webView;
}

- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return _activityIndicatorView;
}

- (void)setIsHideNav:(BOOL)isHideNav {
    _isHideNav = isHideNav;
    [self setNavHiden:isHideNav];
}

- (void)setIsHideActivity:(BOOL)isHideActivity {
    _isHideActivity = isHideActivity;
    self.activityIndicatorView.hidden = isHideActivity;
}

- (void)setWebUrl:(NSString *)webUrl {
    _webUrl = webUrl;
    [self loadRequest];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
