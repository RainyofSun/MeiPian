//
//  AppWriteLogToFile.m
//  LibTools
//
//  Created by 刘冉 on 2018/11/30.
//  Copyright © 2018 LRCY. All rights reserved.
//

#import "AppWriteLogToFile.h"
#import "AppWriteLogGetFile.h"
#import "AppWriteLogGetDate.h"

static NSInteger expirDays = 7;

@interface AppWriteLogToFile ()

/** fileManager */
@property (nonatomic,strong) NSFileHandle *fileHandle;
/** logQueue */
@property (nonatomic,strong) dispatch_queue_t logQueue;
/** fileManager */
@property (nonatomic,strong) AppWriteLogGetFile *fileManager;
/** dateTool */
@property (nonatomic,strong) AppWriteLogGetDate *dateTool;

@end

static AppWriteLogToFile *logManager = nil;

@implementation AppWriteLogToFile

+ (instancetype)AppWriteLogToLocalFile {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!logManager) {
            logManager = [[AppWriteLogToFile alloc] init];
            logManager.logQueue = dispatch_queue_create("logQueue", DISPATCH_QUEUE_CONCURRENT);
        }
    });
    return logManager;
}

-(instancetype)init{
    if (self = [super init]) {
        self.fileManager = [[AppWriteLogGetFile alloc] init];
        self.dateTool    = [[AppWriteLogGetDate alloc] init];
        [self redirectNSLogToLocalFile];
    }
    return self;
}

- (void)dealloc {
    self.fileManager = nil;
    self.dateTool    = nil;
    NSLog(@"DELLOC %@",NSStringFromClass(self.class));
}

- (void)redirectNSLogToLocalFile {
    // 删除7天创建的log文件
    [self removeExpireLogFile];
    // 检验文件是否存在
    BOOL isExist;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [self.fileManager getLogFilePath];
    if (![fileManager fileExistsAtPath:filePath isDirectory:&isExist]) {
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    }
    _fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
}

- (void)removeExpireLogFile {
    // 获取文件的创建日期
    NSArray *fileArray = [self.fileManager getSandboxFileList];
    NSString *fileCreateDate = nil;
    for (NSString *fileName in fileArray) {
        fileCreateDate = [self.fileManager getFileCreatTime:fileName];
        if ([self.dateTool getDifferenceByDate:[self.dateTool getTimeDate:fileCreateDate]] >= expirDays) {
            [self.fileManager deleteSandboxFile:fileCreateDate];
            NSLog(@"删除过期文件%@",fileCreateDate);
        } else {
            NSLog(@"未超过7天时间");
        }
    }
}

- (void)writeFile:(NSData *)logStrData {
    if (!logStrData) {
        NSLog(@"写入log日志data 为空");
        return;
    }
    [_fileHandle seekToEndOfFile];
    [_fileHandle writeData:logStrData];
}

- (void)writeLogStr:(NSString *)logStr {
    if (!logStr.length) {
        NSLog(@"log文件为空");
        return;
    }
    __weak AppWriteLogToFile *weakSelf = self;
    __block NSString *writeLogStr = nil;
    dispatch_async(_logQueue, ^{
        writeLogStr = [NSString stringWithFormat:@"%@\n %@\n",[self.dateTool getTimeNow],logStr];
        [weakSelf writeFile:[writeLogStr dataUsingEncoding:NSUTF8StringEncoding]];
    });
}

@end
