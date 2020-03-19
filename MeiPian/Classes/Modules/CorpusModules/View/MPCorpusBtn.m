//
//  MPCorpusBtn.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/18.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPCorpusBtn.h"

@interface MPCorpusBtn ()

/** corpusImgView */
@property (nonatomic,strong) UIImageView *corpusImgView;

@end

@implementation MPCorpusBtn

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)setCorpusBtnImg:(NSString *)imgName {
    self.corpusImgView.image = [UIImage imageNamed:imgName];
}

#pragma mark - peivate methods
- (void)setupUI {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, -50, 0);
    [self setTitleColor:RGB(14, 15, 18) forState:UIControlStateNormal];
    self.adjustsImageWhenHighlighted = NO;
    [self addSubview:self.corpusImgView];
    CGSize imgSize = [UIImage imageNamed:@"chuangzuo_icon_cg"].size;
    [self.corpusImgView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self];
    [self.corpusImgView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.corpusImgView autoSetDimensionsToSize:CGSizeMake(imgSize.width * 1.1, imgSize.height * 1.1)];
}

#pragma mark - lazy
- (UIImageView *)corpusImgView {
    if (!_corpusImgView) {
        _corpusImgView = [[UIImageView alloc] init];
    }
    return _corpusImgView;
}

@end
