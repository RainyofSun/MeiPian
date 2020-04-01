//
//  UIImageView+ImageScale.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/31.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (ImageScale)

/** 加载图片*/
- (void)MPSetImageWithURL:(NSString *)imgUrl;

@end

NS_ASSUME_NONNULL_END
