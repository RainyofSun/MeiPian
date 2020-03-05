//
//  AppWriteLogGetFile.m
//  LibTools
//
//  Created by 刘冉 on 2018/12/3.
//  Copyright © 2018 LRCY. All rights reserved.
//

#import "AppWriteLogGetFile.h"
#import "AppWriteLogGetDate.h"

static NSString *file_prefix = @"LOG-";
static NSString *file_postfix= @".txt";

@interface AppWriteLogGetFile ()

/** dateTool */
@property (nonatomic,strong) AppWriteLogGetDate *dateTool;

@end

@implementation AppWriteLogGetFile

- (void)dealloc {
    self.dateTool = nil;
    NSLog(@"DDELLOC :%@",NSStringFromClass(self.class));
}

-(instancetype)init{
    if (self = [super init]) {
        self.dateTool = [[AppWriteLogGetDate alloc] init];
    }
    return self;
}

/// log本地文件的创建路径
- (NSString *)getLogFilePath{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:[self getFileName]];
    return plistPath;
}

/// 获取文件名字
- (NSString *)getFileName {
    return [[file_prefix stringByAppendingString:[self.dateTool getTimeStr:[NSDate date]]] stringByAppendingString:file_postfix];
}

/// 获取文件时间
- (NSString *)getFileCreatTime:(NSString *)fileName {
    fileName = [fileName stringByReplacingOccurrencesOfString:file_prefix withString:@""];
    fileName = [fileName stringByReplacingOccurrencesOfString:file_postfix withString:@""];
    NSLog(@"file 创建时间 %@",fileName);
    return fileName;
}

/// 获取沙盒下所有特定文件
-(NSArray *)getSandboxFileList{
    NSString *string = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *fileList = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:string error:nil] pathsMatchingExtensions:@[@"txt"]];
    return fileList;
}

/// 删除沙盒下某一个文件
- (void)deleteSandboxFile:(NSString *)fileCreatDate {
    NSString *fileName = [[file_prefix stringByAppendingString:fileCreatDate] stringByAppendingString:file_postfix];
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:fileName];
    [[NSFileManager defaultManager] removeItemAtPath:plistPath error:nil];
}

/// 删除沙盒下txt文件
- (void)removeSandboxTxtFile {
    NSString *extension = @"txt";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *pathString = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:pathString error:nil];
    NSEnumerator *enumerator = [contents objectEnumerator];
    NSString *fileName = nil;
    while (fileName = [enumerator nextObject]) {
        if ([[fileName pathExtension] isEqualToString:extension]) {
            [fileManager removeItemAtPath:[pathString stringByAppendingPathComponent:fileName] error:nil];
        }
    }
}

@end
