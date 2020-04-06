//
//  MPSheYingBannerLoopView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/2.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPSheYingBannerLoopView.h"
#import "MPBannerLoopViewModel.h"
#import "MPSheYingArticleTypeView.h"

static CGFloat BannerHeightScale = 0.37;

@interface MPSheYingBannerLoopView ()<AppCycleScrollviewDelegate>
{
    CGFloat LoopW;
}
/** imgBannerView */
@property (nonatomic,strong) AppCycleScrollview *imgBannerView;
/** typeView */
@property (nonatomic,strong) MPSheYingArticleTypeView *typeView;
/** loopVM */
@property (nonatomic,strong) MPBannerLoopViewModel *loopVM;
/** loopH */
@property (nonatomic,assign,readwrite) CGFloat loopH;
/** lineLayer */
@property (nonatomic,strong) CALayer *lineLayer;

@end

@implementation MPSheYingBannerLoopView

- (instancetype)init {
    if (self = [super init]) {
        LoopW = ScreenWidth - 30;
        self.loopH = 280;
        [self setupImgBannerView];
        [self setArticleTypeView];
        [self setupUI];
        [self getLoopImgSource];
    }
    return self;
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
    
    self.imgBannerView = [AppCycleScrollview appCycleScrollViewWithFrame:CGRectMake(15, 15, LoopW, LoopW * BannerHeightScale) shouldInfiniteLoop:YES cycleDelegate:self];
    self.imgBannerView.imgCornerRadius = 5.0f;
    self.imgBannerView.autoScrollTimeInterval = 3.0f;
    self.imgBannerView.isZoom = NO;
    self.imgBannerView.heightProportion = 1;
    self.imgBannerView.itemWidth = LoopW;
    self.imgBannerView.isHidePageControl = NO;
    [self addSubview:self.imgBannerView];
    self.imgBannerView.placeholderImage = [UIImage imageNamed:@"image_loading_wide"];
}

- (void)setArticleTypeView {
    self.typeView = [[MPSheYingArticleTypeView alloc] initWithFrame:CGRectMake(15, LoopW * BannerHeightScale + 23, LoopW, 250 - LoopW * BannerHeightScale)];
    [self addSubview:self.typeView];
}

- (void)getLoopImgSource {
    self.imgBannerView.imageURLStringsGroup = [self.loopVM bannerLoopSource].allValues;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.lineLayer = [CALayer layer];
    self.lineLayer.backgroundColor = MAIN_LIGHT_GRAY_COLOR.CGColor;
    self.lineLayer.frame = CGRectMake(15, self.loopH - 1, LoopW, 1);
    [self.layer addSublayer:self.lineLayer];
}

#pragma mark - lazy
- (MPBannerLoopViewModel *)loopVM {
    if (!_loopVM) {
        _loopVM = [[MPBannerLoopViewModel alloc] init];
    }
    return _loopVM;
}

@end
