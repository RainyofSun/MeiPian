//
//  MPSMSCodeViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPSMSCodeViewModel.h"
#import "MPSMSCodeView.h"
#import "MPUserInfoModel.h"

static NSInteger SMSCodeTime = 60;

@interface MPSMSCodeViewModel ()

/** codeView */
@property (nonatomic,strong) MPSMSCodeView *codeView;

@end

@implementation MPSMSCodeViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 加载短验登录界面
- (void)loadSMSCodeMainView:(UIViewController *)vc {
    self.codeView = [[[NSBundle mainBundle] loadNibNamed:@"MPSMSCodeView" owner:nil options:nil] firstObject];
    [vc.view addSubview:self.codeView];
    [self.codeView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [self.codeView reloadTopTipText:[self getPhoneAttributeStr]];
    [self.codeView resetNextBtnTitle:(self.viewStyle == SMSCodeViewStyle_PhoneLogin ? @"登录" : @"下一步")];
    [vc setNavHiden:YES];
    [self.codeView startCountDown:SMSCodeTime];
}

// 界面按钮点击逻辑
- (void)mainViewBtnLogic:(UIViewController *)vc senderTag:(NSNumber *)senderTag {
    switch (senderTag.integerValue) {
        case 0:
            [vc.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            if (self.viewStyle == SMSCodeViewStyle_PhoneLogin) {
                [MBHUDToastManager showWaitingWithTitle:@"登录中..."];
                [self setDefaultUserModel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBHUDToastManager hideAlert];
                    [MBHUDToastManager showBriefAlert:@"登录成功"];
                    [vc.navigationController dismissViewControllerAnimated:YES completion:nil];
                });
            } else {
                [vc pushVC:[MPModulesMsgSend sendMsg:self.phone vcName:@"MPNewPWDViewController"]];
            }
            break;
        default:
            break;
    }
}

// 请求验证码
- (void)requestSMSCode:(UIViewController *)vc {
    [self.codeView startCountDown:SMSCodeTime];
}

// 添加/删除textFiled的监听通知
- (void)addOrDeleteTextFiledObserver:(BOOL)isAdd {
    isAdd ? [self.codeView addNotification] : [self.codeView removeNotification];
}

#pragma mark - private methods
- (NSAttributedString *)getPhoneAttributeStr {
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] initWithString:[@"短信验证码已发送至 " stringByAppendingString:self.phone] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:HexColor(0x8A8A8A)}];
    [attributeText addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(10, _phone.length)];
    return attributeText;
}

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

#pragma mark - setter
- (void)setPhone:(NSString *)phone {
    NSMutableString *mutableStr = [[NSMutableString alloc] initWithString:phone];
    [mutableStr insertString:@" " atIndex:3];
    [mutableStr insertString:@" " atIndex:8];
    _phone = mutableStr;
}

@end
