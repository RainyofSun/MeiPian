//
//  MPAccountLoginView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPAccountLoginView.h"

@interface MPAccountLoginView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *accountTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *wcBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreWayBtn;
@property (weak, nonatomic) IBOutlet YYLabel *protocolLab;

@end

@implementation MPAccountLoginView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
    [self addNotification];
}

- (void)dealloc {
    [self removeNotification];
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark -- public methods
// 协议富文本
- (void)updateProtocolAttributeText:(NSAttributedString *)attributeProtocol {
    self.protocolLab.attributedText = attributeProtocol;
}

// 点击显示密码
- (void)showPWD:(UIButton *)sender {
    self.passwordTextFiled.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
}

- (IBAction)touchAccountViewBtn:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(touchAccountLoginViewBtn:) params:[NSNumber numberWithInteger:sender.tag]];
}

#pragma mark - UITextFieldDelegate

#pragma mark - 通知
- (void)textFieldDidChangeValue:(NSNotification *)notification {
    
    UITextField *textField = (UITextField *)[notification object];
    if (textField.tag == 0) {
        return;
    }
    NSString *toBeString = textField.text;
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    NSInteger MAX_STARWORDS_LENGTH = 16;
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        self.loginBtn.backgroundColor = toBeString.length >= 6 ? RGB(38, 122, 255) : RGB(179, 213, 255);
        self.loginBtn.enabled = (toBeString.length >= 6);
        if (toBeString.length > MAX_STARWORDS_LENGTH) {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
            if (rangeIndex.length == 1) {
                textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            } else {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

#pragma mark - private methods
- (void)setupUI {
    self.accountTextFiled.layer.cornerRadius = CGRectGetHeight(self.accountTextFiled.bounds)/2;
    self.passwordTextFiled.layer.cornerRadius = CGRectGetHeight(self.passwordTextFiled.bounds)/2;
    self.loginBtn.layer.cornerRadius = CGRectGetHeight(self.loginBtn.bounds)/2;
    self.accountTextFiled.clipsToBounds = self.passwordTextFiled.clipsToBounds = self.loginBtn.clipsToBounds = YES;
    
    [self.passwordTextFiled createLeftEmptyView:15];
    [self.accountTextFiled createLeftEmptyView:15];
    [self.passwordTextFiled createRightV:@"sign_icon_so" selectedName:@"sign_icon_invisible" target:self action:@selector(showPWD:)];
    
    [self.phoneBtn changeButtonImgTopAndTextBottom:5];
    [self.moreWayBtn changeButtonImgTopAndTextBottom:5];
    [self.wcBtn changeButtonImgTopAndTextBottom:5];
    
    self.passwordTextFiled.delegate = self;
    self.loginBtn.qi_eventInterval = 2;
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangeValue:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

@end
