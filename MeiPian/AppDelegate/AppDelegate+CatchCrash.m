//
//  AppDelegate+CatchCrash.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/5.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "AppDelegate+CatchCrash.h"

@implementation AppDelegate (CatchCrash)

- (void)catchCrash {
    NSArray *noneSelClassStrings = @[@"NSNull",@"NSNumber",@"NSString",@"NSDictionary",@"NSArray"];
    [AvoidCrash setupNoneSelClassStringsArr:noneSelClassStrings];
    [AvoidCrash makeAllEffective];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
}

- (void)dealwithCrashMessage:(NSNotification *)notification {
    NSLog(@"crash info %@",notification.userInfo);
    [[AppWriteLogToFile AppWriteLogToLocalFile] writeLogStr:[self combineData:notification.userInfo]];
#if DEBUG
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"与APP开发者共享" message:@"允许Apple将崩溃数据和您使用方式相关的统计数据共享给APP开发者,以帮助开发者改进APP" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *urlStr = [NSString stringWithFormat:@"mailto://liuran@YZgame.com?subject=bug报告&body=感谢您的配合!错误详情:%@",
                            [self combineData:notification.userInfo]];
        NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [[UIApplication sharedApplication] openURL:url];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:sureAction];
    [alert addAction:cancelAction];
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
#endif
}

- (NSString *)combineData:(NSDictionary *)params {
    NSMutableDictionary *crashInfoDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [crashInfoDict removeObjectForKey:@"exception"];
    NSString *js = [crashInfoDict mj_JSONString];
    return js;
}

@end
