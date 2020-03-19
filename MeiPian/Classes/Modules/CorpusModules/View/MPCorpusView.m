//
//  MPCorpusView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/18.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPCorpusView.h"
#import "MPCorpusBtn.h"

@interface MPCorpusView ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *btnContainerView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

/** animationIndex */
@property (nonatomic,assign) NSInteger animationIndex;
/** btnSource */
@property (nonatomic,strong) NSMutableArray <MPCorpusBtn *>*btnSource;

@end

@implementation MPCorpusView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
    [self setDefaultData];
}

- (void)dealloc {
    for (MPCorpusBtn *item in _btnSource) {
        [item removeFromSuperview];
    }
    [self.btnSource removeAllObjects];
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 关闭按钮旋转动画
- (void)closeBtnRotatingAnimation {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            self.closeBtn.transform = CGAffineTransformRotate(self.closeBtn.transform, M_PI_4);
        }];
    });
}

// 弹性动画
- (void)corpusSpringAnimation {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animationUpAndDownAnimation];
    });
}

- (IBAction)touchCorpusViewBtn:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(clickCorpusViewBtns:) params:[NSNumber numberWithInteger:sender.tag]];
}

#pragma marrk - private methods
- (void)setupUI {
    [self.containerView cutViewRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:10.f];
    NSArray *imgSource = @[@"chuangzuo_icon_wzcz",@"chuangzuo_icon_pic",@"chuangzuo_icon_spcz",@"chuangzuo_icon_cg"];
    NSArray *titleSource = @[@"图文",@"影集",@"短视频",@"草稿箱"];
    self.btnSource = [NSMutableArray arrayWithCapacity:titleSource.count];
    CGFloat itemW = CGRectGetWidth(self.btnContainerView.bounds)/imgSource.count;
    CGFloat itemH = CGRectGetHeight(self.btnContainerView.bounds);
    for (NSInteger i = 0; i < imgSource.count; i ++) {
        MPCorpusBtn *item = [[MPCorpusBtn alloc] initWithFrame:CGRectMake(itemW * i, 0, itemW, itemH)];
        [item setTitle:titleSource[i] forState:UIControlStateNormal];
        [item setCorpusBtnImg:imgSource[i]];
        [item addTarget:self action:@selector(touchCorpusViewBtn:) forControlEvents:UIControlEventTouchUpInside];
        item.tag = i;
        item.alpha = 0;
        item.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(self.btnContainerView.bounds));
        [self.btnContainerView addSubview:item];
        [self.btnSource addObject:item];
    }
    self.closeBtn.transform = CGAffineTransformRotate(self.closeBtn.transform, M_PI_4);
}

- (void)setDefaultData {
    self.animationIndex = 0;
}

- (void)animationUpAndDownAnimation {
    CGFloat delayTime = 0;
    for (int i = 0; i < self.btnSource.count; i++) {
        delayTime = i*0.05 - i/4*0.2;
        UIButton *button = self.btnSource[i];
        [UIView animateWithDuration:0.7 delay:delayTime usingSpringWithDamping:0.9 initialSpringVelocity:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            button.alpha = 1;
            button.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}

@end
