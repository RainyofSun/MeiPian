//
//  NSObject+FileCache.m
//  YiZhan
//
//  Created by 刘冉 on 2020/2/9.
//  Copyright © 2020 YZ_BMAC. All rights reserved.
//

#import "NSObject+FileCache.h"

@implementation NSObject (FileCache)

/*
 自定义方法：获取缓存大小
 */
- (CGFloat)getCacheSize{
    //获取文件管理器
    NSFileManager *fileM = [NSFileManager defaultManager];
    //获取缓存路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    //得到缓存文件列表
    NSArray *childPaths = [fileM subpathsAtPath:cachePath];
    
    //存储文件总长度
    long long size = 0;
    for(NSString *childPath in childPaths){
        //得到文件路径
        NSString *filePath = [cachePath stringByAppendingPathComponent:childPath];
        
        //获取当前是文件还是目录
        BOOL isDir = NO;
        [fileM fileExistsAtPath:filePath isDirectory:&isDir];
 
        if(isDir){//如果是目录则跳出此次循环
            continue;
        }
        
        //将文件大小累加
        size = size + [[fileM attributesOfItemAtPath:filePath error:nil][NSFileSize] longLongValue];
    }
    //将字节大小转为MB，然后传出去
    return size/1000.0/1000;
}

/*
 自定义方法，清除APP缓存
 */
- (void)clearCache {
    //获取文件管理器
    NSFileManager *fileM = [NSFileManager defaultManager];
    //获取缓存路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //清除缓存
    [fileM removeItemAtPath:cachePath error:nil];

}

@end
