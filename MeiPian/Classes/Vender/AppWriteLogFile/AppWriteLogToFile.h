//
//  AppWriteLogToFile.h
//  LibTools
//
//  Created by 刘冉 on 2018/11/30.
//  Copyright © 2018 LRCY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppWriteLogToFile : NSObject

+ (instancetype)AppWriteLogToLocalFile;

- (void)writeLogStr:(NSString *)logStr;

@end

NS_ASSUME_NONNULL_END
