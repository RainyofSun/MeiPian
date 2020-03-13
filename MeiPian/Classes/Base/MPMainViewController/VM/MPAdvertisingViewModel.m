//
//  MPAdvertisingViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/9.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPAdvertisingViewModel.h"
#import "MPAdvertisingView.h"
#import "MPADDownLoadManager.h"

static NSInteger expireDays = 1;    // 清理广告缓存的间隔时间

@interface MPAdvertisingViewModel ()<EGLSGCDTimerDelegate>

/** adView */
@property (nonatomic,strong) MPAdvertisingView *adView;
/** downLoadManager */
@property (nonatomic,strong) MPADDownLoadManager *downLoadManager;
/** adTime */
@property (nonatomic,assign) NSInteger adTime;

@end

@implementation MPAdvertisingViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 展示广告页
- (void)showAdvertisingViewDisBlock:(void (^)(BOOL))disAdViewBlock {
    NSString *adFilePath = [self.downLoadManager saveADPicPath];
    if ([AppFileManager isExistsAtPath:adFilePath]) {
        NSDate *adDate = [AppFileManager creationDateOfItemAtPath:adFilePath];
        if ([adDate getDaysTo:[NSDate date]] >= expireDays) {
            [self.downLoadManager removeLoalADPicFile:adFilePath];
            [self cacheADFile];
            if (disAdViewBlock) {
                disAdViewBlock(NO);
            }
        } else {
            [self setupADView:disAdViewBlock];
        }
    } else {
        [self cacheADFile];
    }
}

#pragma mark - private methods
// 广告倒计时
- (void)ADCountDown:(NSInteger)time {
    self.adTime = time;
    [EGLSGlobalGCDTimer GlobalTimerSetUp].timerDelegate = self;
    [[EGLSGlobalGCDTimer GlobalTimerSetUp] timerStart];
}

#pragma mark - EGLSGCDTimerDelegate
- (void)countDownRefreshUI {
    if (self.adTime <= 0) {
        [[EGLSGlobalGCDTimer GlobalTimerSetUp] timerSuspend];
        [_adView disappearADView];
        NSLog(@"倒计时结束,定时器挂起");
        return;
    }
    [_adView updateTimeBtnAttributeTitle:[self timeAttributeTitle:self.adTime]];
    self.adTime --;
}

/// 倒计时按钮文字
- (NSAttributedString *)timeAttributeTitle:(NSInteger)time {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%lds｜跳过",time] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGB(130, 130, 132)}];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:RGB(135, 0, 4)} range:NSMakeRange(0, 2)];
    return attributeStr;
}

- (void)setupADView:(void (^)(BOOL))disAdViewBlock {
    UIViewController *topViewComtroller = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (!_adView) {
        _adView = [[MPAdvertisingView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    [topViewComtroller.view addSubview:_adView];
    [self ADCountDown:5];
    [_adView loadADPic:[UIImage imageWithContentsOfFile:[self.downLoadManager saveADPicPath]]];
    WeakSelf;
    _adView.adDisBlock = ^(NSInteger senderTag) {
        [[EGLSGlobalGCDTimer GlobalTimerSetUp] timerSuspend];
        [EGLSGlobalGCDTimer GlobalTimerSetUp].timerDelegate = nil;
        [weakSelf.adView removeFromSuperview];
        weakSelf.adView = nil;
        disAdViewBlock ? disAdViewBlock([NSNumber numberWithInteger:senderTag].boolValue) : nil;
    };
}

- (void)cacheADFile {
    NSLog(@"没有缓存广告,开启广告缓存");
    [self.downLoadManager downLoadADPicFile:[NSString stringWithFormat:@"http://qzonestyle.gtimg.cn/qzone/app/weishi/client/testimage/256/%u.jpg",arc4random()%100]];
    self.downLoadManager.Complete = ^(NSString * _Nonnull localFilePath) {
        NSLog(@"广告页已缓存,存储位置 %@",localFilePath);
    };
}

#pragma mark - lazy
- (MPADDownLoadManager *)downLoadManager {
    if (!_downLoadManager) {
        _downLoadManager = [[MPADDownLoadManager alloc] init];
    }
    return _downLoadManager;
}

@end
