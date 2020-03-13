//
//  MPNewPWDView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPNewPWDView.h"

@interface MPNewPWDView ()

@property (weak, nonatomic) IBOutlet UILabel *topTipLab;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;


@end

@implementation MPNewPWDView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
    [self addNotification];
}

- (void)dealloc {
    [self removeNotification];
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadTopTipAttributeText:(NSAttributedString *)attributeText {
    self.topTipLab.attributedText = attributeText;
}

- (NSString *)getNewPWD {
    return self.pwdTextFiled.text;
}

- (IBAction)touchNewPwdViewBtn:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(touchNewPWDViewBtn:) params:[NSNumber numberWithInteger:sender.tag]];
}

- (void)showPWD:(UIButton *)sender {
    self.pwdTextFiled.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
}

#pragma mark - 通知
- (void)textFieldDidChangeValue:(NSNotification *)notification {
    UITextField *textField = (UITextField *)[notification object];
    NSString *toBeString = textField.text;
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    NSInteger MAX_STARWORDS_LENGTH = 16;
    NSInteger MIN_STARWORDS_LENGTH = 8;
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        self.confirmBtn.backgroundColor = toBeString.length >= MIN_STARWORDS_LENGTH ? RGB(38, 122, 255) : RGB(179, 213, 255);
        self.confirmBtn.enabled = (toBeString.length >= MIN_STARWORDS_LENGTH);
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
    self.pwdTextFiled.layer.cornerRadius = CGRectGetHeight(self.pwdTextFiled.bounds)/2;
    self.confirmBtn.layer.cornerRadius = CGRectGetHeight(self.confirmBtn.bounds)/2;
    self.pwdTextFiled.clipsToBounds = self.confirmBtn.clipsToBounds = YES;
    
    [self.pwdTextFiled createLeftEmptyView:15];
    [self.pwdTextFiled createRightV:@"sign_icon_so" selectedName:@"sign_icon_invisible" target:self action:@selector(showPWD:)];
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangeValue:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

@end
