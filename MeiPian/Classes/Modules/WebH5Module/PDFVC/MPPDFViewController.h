//
//  MPPDFViewController.h
//  MeiPian
//
//  Created by 刘冉 on 2019/9/28.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>

NS_ASSUME_NONNULL_BEGIN

@interface MPPDFViewController : QLPreviewController

- (void)downLoadPdfFile:(NSString *)fileUrl;

@end

NS_ASSUME_NONNULL_END
