//
//  MPWebViewController.m
//  MeiPian
//
//  Created by 刘冉 on 2019/8/27.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import "MPWebViewController.h"

@interface MPWebViewController ()<MPBaseH5MsgDelegate>

@property(nonatomic)NSString *url;

@end

@implementation MPWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.webUrl = self.url;
    self.h5Msg_delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.h5Msg_delegate = nil;
}

#pragma mark - EGLSBaseH5MsgProtocol
- (void)H5PostMsgToNative:(WKScriptMessage *)msg SELName:(NSString *)sel_name {
    if ([sel_name isEqualToString:SEL_NAME_POST_MSG]) {
        NSDictionary *h5Params = [msg.body urlDecode];
        if ([[h5Params objectForKey:@"msgType"] isEqualToString:@"Downloader"]) {
            [self downLoadNewApp:[[h5Params objectForKey:@"extraInfo"] objectForKey:@"URL"]];
        }
    }
}

- (void)downLoadNewApp:(NSString *)downLoadAppUrl {
    if (!downLoadAppUrl.length) {
        NSLog(@"下载地址不合法");
        return;
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:downLoadAppUrl]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downLoadAppUrl]];
    }
}

- (void)modulesSendMsg:(id)params {
    if ([params isKindOfClass:[NSString class]]) {
        NSLog(@"H5地址 %@",params);
        self.url = (NSString *)params;
    }
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
