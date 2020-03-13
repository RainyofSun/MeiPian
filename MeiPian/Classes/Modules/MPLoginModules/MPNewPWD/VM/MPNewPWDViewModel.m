//
//  MPNewPWDViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPNewPWDViewModel.h"
#import "MPNewPWDView.h"

@interface MPNewPWDViewModel ()

/** pwdView */
@property (nonatomic,strong) MPNewPWDView *pwdView;

@end

@implementation MPNewPWDViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 加载主界面
- (void)loadNewPWDMainView:(UIViewController *)vc {
    self.pwdView = [[[NSBundle mainBundle] loadNibNamed:@"MPNewPWDView" owner:nil options:nil] firstObject];
    [vc.view addSubview:self.pwdView];
    [self.pwdView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.pwdView loadTopTipAttributeText:[self topTipAttributeText]];
    [vc setNavHiden:YES];
}

// 界面按钮点击逻辑
- (void)mainViewBtnLogic:(UIViewController *)vc senderTag:(NSNumber *)senderTag {
    switch (senderTag.integerValue) {
        case 0:
            [vc.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
        {
            if (![[self.pwdView getNewPWD] passwordStronger]) {
                [MBHUDToastManager showBriefAlert:@"密码为 8-16 位数字和字母组合"];
                return;
            }
            [MBHUDToastManager showWaitingWithTitle:@"登录中..." inView:vc.view];
            [self setDefaultUserModel];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBHUDToastManager hideAlert];
                [MBHUDToastManager showBriefAlert:@"登录成功"];
                [vc.navigationController dismissViewControllerAnimated:YES completion:nil];
            });
        }
            break;
        default:
            break;
    }
}

#pragma mark - private methods
// 默认用户数据
- (void)setDefaultUserModel {
    MPUserInfoModel *infoModel = [[MPUserInfoModel alloc] init];
    infoModel.userId = @"1";
    infoModel.phone = [self.phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    infoModel.realName = @"张三";
    infoModel.sex = @"男";
    infoModel.age = @(22);
    infoModel.token = @"skkskskks";
    infoModel.tokenTimesTamp = [NSString stringWithFormat:@"%lld",[self getNowTimestamp]];
    [MPUserStatusGlobalModel UserGlobalModel].token = infoModel.token;
    [MPUserStatusGlobalModel UserGlobalModel].userInfoModel = infoModel;
    [MPUserStatusGlobalModel UserGlobalModel].isLogin = YES;
    [MPUserInfoCache saveCacheUserinfoModel];
}

- (NSAttributedString *)topTipAttributeText {
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] initWithString:@"密码为 8-16 位数字和字母组合" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:HexColor(0x8A8A8A)}];
    [attributeText addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(4, 4)];
    return attributeText;
}

@end
