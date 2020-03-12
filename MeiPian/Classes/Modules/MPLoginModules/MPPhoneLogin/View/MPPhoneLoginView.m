//
//  MPPhoneLoginView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPPhoneLoginView.h"

@interface MPPhoneLoginView ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *smsCodeBtn;
/** phoneAreaCodeBtn */
@property (nonatomic,strong) UIButton *phoneAreaCodeBtn;

@end

@implementation MPPhoneLoginView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)reloadPhoneAreaCode:(NSString *)code {
    [self.phoneAreaCodeBtn setTitle:code forState:UIControlStateNormal];
}

- (IBAction)touchPhoneViewBtn:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(touchPhoneLoginViewBtn:) params:[NSNumber numberWithInteger:sender.tag]];
}

- (void)selectedCountryCode:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(selectedCountryPhoneCode)];
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
}

@end
