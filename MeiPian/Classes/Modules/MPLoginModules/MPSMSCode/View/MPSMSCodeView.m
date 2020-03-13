//
//  MPSMSCodeView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPSMSCodeView.h"

@interface MPSMSCodeView ()

@property (weak, nonatomic) IBOutlet UILabel *topTipLab;
@property (weak, nonatomic) IBOutlet UITextField *smsCodeTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
/** timeBtn */
@property (nonatomic,strong) UIButton *timeBtn;

@end

@implementation MPSMSCodeView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)dealloc {
    [self.timeBtn forceInvaildGCDTimer];
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)startCountDown:(NSInteger)time {
    [self.timeBtn timeCountDown:time];
}

- (void)reloadTopTipText:(NSAttributedString *)phone {
    self.topTipLab.attributedText = phone;
}

- (void)resetNextBtnTitle:(NSString *)title {
    [self.nextBtn setTitle:title forState:UIControlStateNormal];
}

- (IBAction)touchSmsCodeViewBtn:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(touchSMSCodeViewBtn:) params:[NSNumber numberWithInteger:sender.tag]];
}

- (void)resendSMSCode:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(touchSMSCodeBtn)];
}

#pragma mark - 通知
- (void)textFieldDidChangeValue:(NSNotification *)notification {
    UITextField *textField = (UITextField *)[notification object];
    NSString *toBeString = textField.text;
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    NSInteger MAX_STARWORDS_LENGTH = 4;
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        self.nextBtn.backgroundColor = toBeString.length >= MAX_STARWORDS_LENGTH ? RGB(38, 122, 255) : RGB(179, 213, 255);
        self.nextBtn.enabled = (toBeString.length >= MAX_STARWORDS_LENGTH);
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
    self.smsCodeTextFiled.layer.cornerRadius = CGRectGetHeight(self.smsCodeTextFiled.bounds)/2;
    self.nextBtn.layer.cornerRadius = CGRectGetHeight(self.nextBtn.bounds)/2;
    self.smsCodeTextFiled.clipsToBounds = self.nextBtn.clipsToBounds = YES;
    
    [self.smsCodeTextFiled createLeftEmptyView:15];
    self.timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.timeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.timeBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.timeBtn.normalText = @"重新获取";
    self.timeBtn.selectedText = @"后重试";
    self.timeBtn.normalTextColor = RGB(119, 118, 117);
    self.timeBtn.selectedTextColor = RGB(119, 118, 117);
    
    self.timeBtn.frame = CGRectMake(0, 0, 100, CGRectGetHeight(self.smsCodeTextFiled.bounds));
    [self.timeBtn addTarget:self action:@selector(resendSMSCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.smsCodeTextFiled createRightCustomView:self.timeBtn];
    
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangeValue:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

@end
