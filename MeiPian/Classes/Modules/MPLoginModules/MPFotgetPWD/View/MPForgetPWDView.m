//
//  MPForgetPWDView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPForgetPWDView.h"

@interface MPForgetPWDView ()<LEDTelePhoneTextFieldDelegate>

@property (weak, nonatomic) IBOutlet TelePhoneTextField *phoneTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *smsCodeBtn;

/** phoneAreaCodeBtn */
@property (nonatomic,strong) UIButton *phoneAreaCodeBtn;

@end

@implementation MPForgetPWDView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)dealloc {
    [self.phoneTextFiled removeNotificationReference];
    self.phoneTextFiled.LEdDelegate = nil;
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)reloadPhoneAreaCode:(NSString *)code {
    [self.phoneAreaCodeBtn setTitle:code forState:UIControlStateNormal];
}

- (NSString *)getPhoneNum {
    return [self.phoneTextFiled.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (IBAction)touchForgetPWDViewBtn:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(touchForgetPWDViewBtn:) params:[NSNumber numberWithInteger:sender.tag]];
}

- (void)selectedCountryCode:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(selectedCountryPhoneCode)];
}

#pragma mark - LEDTelePhoneTextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField {
    self.smsCodeBtn.enabled = textField.text.length;
    self.smsCodeBtn.backgroundColor = textField.text.length ? RGB(38, 122, 255) : RGB(179, 213, 255);
}

#pragma mark - private methods
- (void)setupUI {
    self.phoneTextFiled.layer.cornerRadius = CGRectGetHeight(self.phoneTextFiled.bounds)/2;
    self.smsCodeBtn.layer.cornerRadius = CGRectGetHeight(self.smsCodeBtn.bounds)/2;
    self.phoneTextFiled.clipsToBounds = self.smsCodeBtn.clipsToBounds = YES;

    self.phoneAreaCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.phoneAreaCodeBtn setTitle:@"+86" forState:UIControlStateNormal];
    [self.phoneAreaCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.phoneAreaCodeBtn setImage:[UIImage imageNamed:@"sign_icon_arrow_down"] forState:UIControlStateNormal];
    self.phoneAreaCodeBtn.frame = CGRectMake(0, 0, 70, CGRectGetHeight(self.phoneTextFiled.bounds));
    [self.phoneAreaCodeBtn changeButtonImgRightAndTextLeft:10];
    [self.phoneAreaCodeBtn addTarget:self action:@selector(selectedCountryCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.phoneTextFiled createLeftCustomView:self.phoneAreaCodeBtn];
    
    self.phoneTextFiled.LEdDelegate = self;
}

@end
