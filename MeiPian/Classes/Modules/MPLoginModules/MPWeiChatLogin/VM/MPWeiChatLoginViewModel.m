//
//  MPWeiChatLoginViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPWeiChatLoginViewModel.h"
#import "MPWeiChatLoginView.h"
#import "MPLoginWaysPopViewController.h"

@implementation MPWeiChatLoginViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 加载微信登录的主界面
- (void)loadWeiChatLoginMainView:(UIViewController *)vc {
    [vc setNavHiden:YES];
    MPWeiChatLoginView *loginView = [[[NSBundle mainBundle] loadNibNamed:@"MPWeiChatLoginView" owner:nil options:nil] firstObject];
    [vc.view addSubview:loginView];
    [loginView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [loginView updateProtocolAttributeText:[self protocolAttributeText:@"登录即表示同意《美篇用户协议》《美篇隐私协议》"]];
}

// 界面按钮点击逻辑
- (void)mainViewBtnLogic:(UIViewController *)vc senderTag:(nonnull NSNumber *)senderTag {
    NSLog(@"SenderTag : %@",senderTag);
    switch (senderTag.integerValue) {
        case 0:
            [vc.navigationController dismissViewControllerAnimated:YES completion:nil];
            break;
        case 1:
            [vc pushVC:[MPModulesMsgSend sendMsg:@"https://www.jianshu.com/p/6868d8c04ec6" vcName:@"MPWebViewController"]];
            break;
        case 2:
            [vc pushVC:@"MPForgetPWDViewController"];
            break;
        case 3:
            [vc pushVC:@"MPPhoneLoginViewController"];
            break;
        case 4:
            [self switchLoginWay:vc];
            break;
        default:
            break;
    }
}

// 切花登录方式
- (void)switchLoginWay:(UIViewController *)vc {
    MPLoginWaysPopViewController *loginWaysVC = [[MPLoginWaysPopViewController alloc] initWithNibName:@"MPLoginWaysPopViewController" bundle:nil];
    loginWaysVC.popSource = @[@"QQ登录",@"微博登录",@"美篇号登录"];
    loginWaysVC.completeBlock = ^(NSInteger senderTag) {
        NSLog(@"sss %ld",senderTag);
        switch (senderTag) {
            case 2:
                [vc pushVC:@"MPAccountLoginViewController"];
                break;
                
            default:
                break;
        }
    };
    [vc presentVC:loginWaysVC];
}

#pragma mark - private methods
- (NSAttributedString *)protocolAttributeText:(NSString *)protocolText {
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] initWithString:protocolText attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGB(163, 163, 163)}];
    
    NSRange range0 = NSMakeRange(protocolText.length - 16, 16);
    NSRange range1 = NSMakeRange(protocolText.length - 16, 8);
    NSRange range2 = NSMakeRange(protocolText.length - 8, 8);
    
    [attributeText addAttributes:@{NSForegroundColorAttributeName:RGB(132, 133, 134)} range:range0];
    [attributeText addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)} range:NSMakeRange(protocolText.length - 15, 6)];
    [attributeText addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)} range:NSMakeRange(protocolText.length - 7, 6)];
    
    [attributeText setTextHighlightRange:range1 color:RGB(132, 133, 134) backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"ssss");
    }];
    [attributeText setTextHighlightRange:range2 color:RGB(132, 133, 134) backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"aaaa");
    }];
    return attributeText;
}

@end
