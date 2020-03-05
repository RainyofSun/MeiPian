//
//  AppWriteLogGetFile.h
//  LibTools
//
//  Created by 刘冉 on 2018/12/3.
//  Copyright © 2018 LRCY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppWriteLogGetFile : NSObject

/// 获取文件名字
- (NSString *)getFileName;
/// 获取文件创建时间
- (NSString *)getFileCreatTime:(NSString *)fileName;
/// 获取沙盒下所有特定文件
-(NSArray *)getSandboxFileList;
/// log本地文件的创建路径
- (NSString *)getLogFilePath;
/// 移除txt文件
- (void)removeSandboxTxtFile;
/// 删除沙盒下某一个文件
- (void)deleteSandboxFile:(NSString *)fileCreatDate;

@end

NS_ASSUME_NONNULL_END
