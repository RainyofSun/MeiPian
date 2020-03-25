//
//  BaseNetRequestConfig.m
//  XiaoYeMa
//
//  Created by 刘冉 on 2019/8/25.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
//

#import "BaseNetRequestConfig.h"

static  BaseNetRequestConfig *config = nil;

@implementation BaseNetRequestConfig

+ (instancetype)netRequestConfig {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!config) {
            config = [[BaseNetRequestConfig alloc] init];
            [config setDefaultConfig];
        }
    });
    return config;
}

- (void)setDefaultConfig {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 60;
    self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:HostURL] sessionConfiguration:config];
    self.manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST",@"GET", @"HEAD"]];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/png",@"image/jpeg", nil];
    [self.manager.requestSerializer setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"version"];
    [self.manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [self.manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"mobileType"];
}

- (void)setRequestHeader:(NSDictionary *)params {
    [self.manager.requestSerializer setValue:[params objectForKey:@"guest_id"] forHTTPHeaderField:@"guest_id"];
    [self.manager.requestSerializer setValue:[params objectForKey:@"user_id"] forHTTPHeaderField:@"user_id"];
    [self.manager.requestSerializer setValue:[params objectForKey:@"token"] forHTTPHeaderField:@"token"];
//    [self.manager.requestSerializer setValue:[DeviceUtils getDeviceTerminalId] forHTTPHeaderField:@"device_id"];
}

#pragma mark - setter
- (NSMutableArray <NSURLSessionDataTask *>*)dispatchTable {
    if (!_dispatchTable) {
        _dispatchTable = [NSMutableArray array];
    }
    return _dispatchTable;
}

@end
