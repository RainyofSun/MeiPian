//
//  MPAdvertisingView.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/9.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPAdvertisingView : UIView

/** adDisBlock */
@property (nonatomic,copy) void (^adDisBlock)(NSInteger senderTag);
/// 更新倒计时文字
- (void)updateTimeBtnAttributeTitle:(NSAttributedString *)attributeTitle;
/// 倒计时结束
- (void)disappearADView;
/// 加载广告图片
- (void)loadADPic:(UIImage *)adImg;

@end

