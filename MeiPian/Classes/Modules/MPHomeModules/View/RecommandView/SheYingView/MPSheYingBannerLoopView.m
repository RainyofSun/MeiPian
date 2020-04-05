//
//  MPSheYingBannerLoopView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/2.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPSheYingBannerLoopView.h"
#import "MPBannerLoopViewModel.h"

@interface MPSheYingBannerLoopView ()<AppCycleScrollviewDelegate>
{
    CGFloat LoopW;
}
/** imgBannerView */
@property (nonatomic,strong) AppCycleScrollview *imgBannerView;
/** loopVM */
@property (nonatomic,strong) MPBannerLoopViewModel *loopVM;

@end

@implementation MPSheYingBannerLoopView

- (instancetype)init {
    if (self = [super init]) {
        LoopW = ScreenWidth - 30;
        [self setupImgBannerView];
        [self getLoopImgSource];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.imgBannerView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.imgBannerView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:10];
    [self.imgBannerView autoSetDimensionsToSize:CGSizeMake(LoopW, LoopW * 0.36)];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.imgBannerView.placeholderImage = [UIImage imageNamed:@"image_loading_wide"];
    });
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - AppCycleScrollviewDelegate
- (void)cycleScrollView:(AppCycleScrollview *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    [self.loopVM touchBannerLoopLink:index];
}

#pragma mark - private methods
- (void)setupImgBannerView {
    
    self.imgBannerView = [AppCycleScrollview appCycleScrollViewWithFrame:CGRectZero shouldInfiniteLoop:YES cycleDelegate:self];
    self.imgBannerView.imgCornerRadius = 5.0f;
    self.imgBannerView.autoScrollTimeInterval = 5.0f;
    self.imgBannerView.isZoom = NO;
//    self.imgBannerView.itemSpace = 10.f;
    self.imgBannerView.heightProportion = 0.875;
    self.imgBannerView.itemWidth = LoopW;
    self.imgBannerView.isHidePageControl = NO;
    [self addSubview:self.imgBannerView];
}

- (void)getLoopImgSource {
    self.imgBannerView.imageURLStringsGroup = [self.loopVM bannerLoopSource].allValues;
}

#pragma mark - lazy
- (MPBannerLoopViewModel *)loopVM {
    if (!_loopVM) {
        _loopVM = [[MPBannerLoopViewModel alloc] init];
    }
    return _loopVM;
}

@end
