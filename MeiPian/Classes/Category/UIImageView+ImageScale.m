//
//  UIImageView+ImageScale.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/31.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "UIImageView+ImageScale.h"

@implementation UIImageView (ImageScale)

- (void)MPSetImageWithURL:(NSString *)imgUrl {
    if (![imgUrl hasPrefix:@"http"]) {
        self.image = [UIImage imageNamed:imgUrl];
        return;
    }
    [self setImageWithURL:[NSURL URLWithString:imgUrl] placeholder:[UIImage imageNamed:@"image_loading_wide"] options:YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
    }];
}

- (UIImage *)thumbnailWithImage:(UIImage *)originalImage size:(CGSize)size {
    CGSize originalsize = [originalImage size];
    
    if (originalsize.width<size.width && originalsize.height<size.height) {
        //原图长宽均小于标准长宽的，不作处理返回原图
        return originalImage;
    } else if(originalsize.width>size.width && originalsize.height>size.height) {
        //原图长宽均大于标准长宽的，按比例缩小至最大适应值
        CGFloat rate = 1.0;
        CGFloat widthRate = originalsize.width/size.width;
        CGFloat heightRate = originalsize.height/size.height;
        rate = widthRate>heightRate?heightRate:widthRate;
        CGImageRef imageRef = nil;
        if (heightRate>widthRate) {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height*rate/2, originalsize.width, size.height*rate));//获取图片整体部分
        } else {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width*rate/2, 0, size.width*rate, originalsize.height));//获取图片整体部分
        }
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        return standardImage;
    } else if(originalsize.height>size.height || originalsize.width>size.width) {
        //原图长宽有一项大于标准长宽的，对大于标准的那一项进行裁剪，另一项保持不变
        CGImageRef imageRef = nil;
        if(originalsize.height>size.height) {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height/2, originalsize.width, size.height));//获取图片整体部分
        } else if (originalsize.width>size.width) {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width/2, 0, size.width, originalsize.height));//获取图片整体部分

        }
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        return standardImage;

    } else {
        //原图为标准长宽的，不做处理
                return originalImage;

    }
}

@end
