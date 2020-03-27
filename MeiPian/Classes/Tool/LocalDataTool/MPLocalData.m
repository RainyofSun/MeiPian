//
//  MPLocalData.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPLocalData.h"

@implementation MPLocalData

+ (void)MPGetLocalDataFileName:(NSString *)localFileName localData:(LocalDataCallBack)dataBlock errorBlock:(ErrorCallBack)error {
    if (!localFileName.length) {
        if (error) {
            error(@"文件名不能为空");
        }
        return;
    }
    NSString *localPath = [[NSBundle mainBundle] pathForResource:localFileName ofType:@"json"];
    // 文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:localPath];
    NSDictionary *localFileData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSLog(@"获取本地数据 %@",[localFileData objectForKey:@"data"]);
    if (dataBlock) {
        dataBlock([localFileData objectForKey:@"data"]);
    }
}

@end
