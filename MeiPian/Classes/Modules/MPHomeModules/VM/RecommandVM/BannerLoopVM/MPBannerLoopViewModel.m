//
//  MPBannerLoopViewModel.m
//  MeiPian
//
//  Created by 刘冉 on 2020/4/5.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBannerLoopViewModel.h"

@interface MPBannerLoopViewModel ()

/** loopModelSource */
@property (nonatomic,strong) NSArray <MPBannerLoopModel *>*loopModelSource;
/** loopImgSource */
@property (nonatomic,strong) NSMutableDictionary *loopImgSource;

@end

@implementation MPBannerLoopViewModel

- (instancetype)init{
    if (self = [super init]) {
        [self getDefaultData];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 轮播图数据
- (NSDictionary *)bannerLoopSource {
    return [self.loopImgSource copy];
}

// 点击轮播图事件处理
- (NSString *)touchBannerLoopLink:(NSInteger)index {
    return self.loopModelSource[index].uri;
}

#pragma mark - private methods
- (void)getDefaultData {
    WeakSelf;
    NSInteger loopIndex = arc4random()%2;
    [MPLocalData MPGetLocalDataFileName:[NSString stringWithFormat:@"BannerLoop%ld",loopIndex] localData:^(id  _Nonnull responseObject) {
        weakSelf.loopModelSource = [MPBannerLoopModel modelArrayWithDictArray:(NSArray *)responseObject];
        [weakSelf combineLoopSource];
    } errorBlock:^(NSString * _Nullable errorInfo) {
        
    }];
}

- (void)combineLoopSource {
    self.loopImgSource = [NSMutableDictionary dictionaryWithCapacity:self.loopModelSource.count];
    WeakSelf;
    [self.loopModelSource enumerateObjectsUsingBlock:^(MPBannerLoopModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf.loopImgSource setObject:obj.cover_img forKey:obj.title];
    }];
}

@end
