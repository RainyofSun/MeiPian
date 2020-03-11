//
//  MPADDownLoadManager.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPADDownLoadManager : MPBaseViewModel

/** complete */
@property (nonatomic,copy) void(^Complete)(NSString *localFilePath);

/// 下载ADPic文件
- (void)downLoadADPicFile:(NSString *)pdfFile;
/// 删除ADPic文件
- (void)removeLoalADPicFile:(NSString *)filePath;
/// 获取下载文件路径
- (NSString *)saveADPicPath;

@end

NS_ASSUME_NONNULL_END
