//
//  MPADDownLoadManager.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/10.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPADDownLoadManager.h"

@interface MPADDownLoadManager ()<NSURLSessionDelegate>

/** downloadSession */
@property (nonatomic,strong) NSURLSession *downloadSession;
/** filePath */
@property (nonatomic,strong) NSString *filePath;

@end

@implementation MPADDownLoadManager

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)downLoadADPicFile:(NSString *)pdfFile {
    [[self.downloadSession downloadTaskWithURL:[NSURL URLWithString:pdfFile]] resume];
}

- (void)removeLoalADPicFile:(NSString *)filePath {
    if ([AppFileManager isExistsAtPath:filePath]) {
        NSError *removeError = nil;
        if ([AppFileManager removeItemAtPath:filePath error:&removeError]) {
            NSLog(@"删除成功");
        } else {
            NSLog(@"删除失败 %@",removeError);
        }
    }
}

#pragma mark - NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session task:(nonnull NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error {
    if (error) {
        NSLog(@"文件下载失败 %@",error);
    } else {
        [self.downloadSession invalidateAndCancel];
        self.downloadSession = nil;
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    if ([self savePDFFile:[self saveADPicPath] localtionPath:location.path]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBHUDToastManager hideAlertDelay:1.5];
                if (self.Complete) {
                    self.Complete(self.filePath);
            }
        });
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
//    CGFloat speed = 1.0 * bytesWritten/totalBytesWritten;
//    NSLog(@"下载速度 %f %lld %lld %lld",speed,bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
}

#pragma mark - private mehtods
// 写入文件
- (BOOL)savePDFFile:(NSString *)filePath localtionPath:(NSString *)localFilePath{
    BOOL copySuccess = NO;
    [self removeLoalADPicFile:filePath];
    NSError *copyError = nil;
    copySuccess = [AppFileManager copyItemAtPath:localFilePath toPath:filePath error:&copyError];
    if (!copySuccess && copyError) {
      NSLog(@"复制文件错误 %@",copyError);
    } else {
      self.filePath = filePath;
      NSLog(@"复制文件成功");
    }
    return copySuccess;
}

// 存储地址
- (NSString *)saveADPicPath {
    NSString *filePath = [[AppFileManager documentsDir] stringByAppendingPathComponent:@"ADFile.jpg"];
    NSLog(@"存储地址 %@",filePath);
    return filePath;
}

#pragma mark - setter
- (NSURLSession *)downloadSession {
    if (!_downloadSession) {
        _downloadSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _downloadSession;
}

@end
