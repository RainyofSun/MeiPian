//
//  TelePhoneTextField.m
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/22.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import "TelePhoneTextField.h"

@interface TelePhoneTextField ()<UITextFieldDelegate>

@property(nonatomic,assign)NSInteger limitCount;
/** replaceStr */
@property (nonatomic,strong) NSString *replaceStr;

@end

@implementation TelePhoneTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        [self registerTestField];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self registerTestField];
}

-(void)registerTestField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    _limitCount =11+2;
    self.delegate = self;
    if ([self.replaceStr isEqual:[NSNull null]] || self.replaceStr == nil) {
        [self setFiledTextStyle:FormatStyle_Space];
    } else {
        
    }
}

#pragma mark - textField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}
- (BOOL)textField:(UITextField *)textFieldTemp shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    string = [textFieldTemp.text stringByReplacingCharactersInRange:range withString:string];
    if (string.length > _limitCount) {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.nearsetViewController) {
        [self.nearsetViewController.view endEditing:YES];
    }
    return YES;
}

- (void)textFieldDidChange:(NSNotification *)not {
    
    NSString *text = self.text;
    
    if (text.length) {
        [self creadCardFormart:text];
    }
    if (self.markedTextRange == nil && text.length > _limitCount) {
        self.text = [text substringToIndex:_limitCount];
    }
    if ([self.LEdDelegate respondsToSelector:@selector(textFieldDidChange:)]) {
        [self.LEdDelegate textFieldDidChange:self];
    }
}

//手机号
- (void)creadCardFormart:(NSString*)text {
    NSMutableString *tmpStr = [[text stringByReplacingOccurrencesOfString:self.replaceStr withString:@""] mutableCopy];
    NSMutableArray * tempArray = [NSMutableArray new];
    if(tmpStr.length>3) {
        [ tempArray addObject:[tmpStr substringWithRange:NSMakeRange(0, 3)]];
        [tmpStr deleteCharactersInRange:NSMakeRange(0, 3)];
    }else{
        self.text = tmpStr;
        return;
    }
    BOOL cando = YES;
    while (cando) {
        if(tmpStr.length>4){
            [tempArray addObject:[tmpStr substringWithRange:NSMakeRange(0, 4)]];
            [tmpStr deleteCharactersInRange:NSMakeRange(0, 4)];
        }else{
            [tempArray addObject:[tmpStr copy]];
            cando =NO;
        }
    }
    self.text = [tempArray componentsJoinedByString:self.replaceStr];
    
}

- (void)setFiledTextStyle:(FormatStyle)style {
    if (style == FormatStyle_Line) {
        self.replaceStr = @"-";
    } else {
        self.replaceStr = @" ";
    }
}

@end
