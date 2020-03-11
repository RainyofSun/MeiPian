//
//  MPPDFViewModel.h
//  MeiPian
//
//  Created by 刘冉 on 2019/9/28.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPPDFViewModel : MPBaseViewModel

/** complete */
@property (nonatomic,copy) void(^Complete)(NSString *localFilePath);

/// 下载PDF文件
- (void)downLoadPdfFile:(NSString *)pdfFile;
/// 删除PDF文件
- (void)removeLoalPDFFile:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
