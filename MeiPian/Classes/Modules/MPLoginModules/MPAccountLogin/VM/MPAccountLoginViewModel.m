//
//  MPAccountLoginViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPAccountLoginViewModel.h"
#import "MPAccountLoginView.h"
#import "MPLoginWaysPopViewController.h"

@implementation MPAccountLoginViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 账号登录主界面
- (void)loadAccountLoginMainView:(UIViewController *)vc {
    [vc setNavHiden:YES];
    MPAccountLoginView *accountView = [[[NSBundle mainBundle] loadNibNamed:@"MPAccountLoginView" owner:nil options:nil] firstObject];
    [vc.view addSubview:accountView];
    [accountView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [accountView updateProtocolAttributeText:[self protocolAttributeText:@"登录即表示同意《美篇用户协议》《美篇隐私协议》"]];
}

// 界面按钮点击逻辑
- (void)mainViewBtnLogic:(UIViewController *)vc senderTag:(NSNumber *)senderTag {
    NSLog(@"senderTag %@",senderTag);
    switch (senderTag.integerValue) {
        case 0:
            [vc.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            [vc.navigationController dismissViewControllerAnimated:YES completion:nil];
            break;
        case 2:
            
            break;
        case 3:
            [MBHUDToastManager showBriefAlert:@"微信登录"];
            break;
        case 4:
            [vc pushVC:@"MPPhoneLoginViewController"];
            break;
        case 5:
            [self switchLoginWay:vc];
            break;
        case 6:
            [vc pushVC:[MPModulesMsgSend sendMsg:@"https://www.jianshu.com/p/6868d8c04ec6" vcName:@"MPWebViewController"]];
            break;
        default:
            break;
    }
}

#pragma mark - private methods
// 切花登录方式
- (void)switchLoginWay:(UIViewController *)vc {
    MPLoginWaysPopViewController *loginWaysVC = [[MPLoginWaysPopViewController alloc] initWithNibName:@"MPLoginWaysPopViewController" bundle:nil];
    NSArray *titleArray = @[@"QQ登录",@"微博登录"];
    loginWaysVC.popSource = titleArray;
    loginWaysVC.completeBlock = ^(NSInteger senderTag) {
        if (senderTag != 2) {
            [MBHUDToastManager showBriefAlert:titleArray[senderTag]];
        }
    };
    [vc presentVC:loginWaysVC];
}

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
