//
//  TelePhoneTextField.h
//  MeiPian
//
//  Created by 刘冉 on 2019/8/22.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    FormatStyle_Line,
    FormatStyle_Space,
} FormatStyle;
@protocol LEDTelePhoneTextFieldDelegate <NSObject>

@optional
-(void)textFieldDidChange:(UITextField *)textField;

@end

@interface TelePhoneTextField : UITextField

@property(nonatomic,weak)id <LEDTelePhoneTextFieldDelegate>LEdDelegate ;

- (void)setFiledTextStyle:(FormatStyle)style;
- (void)creadCardFormart:(NSString*)text;

@end

NS_ASSUME_NONNULL_END
