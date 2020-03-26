//
//  MPMoreInterestingTableViewCell.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMoreInterestingTableViewCell.h"

@interface MPMoreInterestingTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImgView;

/** headImgContainerView */
@property (nonatomic,strong) UIView *headImgContainerView;
/** headSource */
@property (nonatomic,strong) NSArray *headSource;

@end

@implementation MPMoreInterestingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setDefaultData];
    [self setupUI];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.headImgContainerView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.headImgContainerView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.arrowImgView withOffset:-15];
    [self.headImgContainerView autoSetDimensionsToSize:CGSizeMake(100, 80 * 0.85)];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - private methods
- (void)setupUI {
    
    [self.containerView addSubview:self.headImgContainerView];
    
    CGFloat itemW = 40;
    CGFloat itemY = 80 * 0.85 * 0.5 - itemW/2;
    for (NSInteger i = 0; i < self.headSource.count; i ++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100 - itemW/2 * (i + 2), itemY, itemW, itemW)];
        [imgView setImageWithURL:[NSURL URLWithString:self.headSource[i]] options:YYWebImageOptionSetImageWithFadeAnimation];
        imgView.layer.cornerRadius = itemW/2;
        imgView.layer.borderWidth = 2.f;
        imgView.layer.borderColor = [UIColor whiteColor].CGColor;
        imgView.clipsToBounds = YES;
        [self.headImgContainerView addSubview:imgView];
    }
}

- (void)setDefaultData {
    self.headSource = @[@"https://ss2.meipian.me/users/82441686/9c94335a8cf241a2831c3d96f95050aa.jpg",
                        @"https://ss2.meipian.me/users/86221110/7732c26487934d4a822dc7063117a27f.jpg",
                        @"https://ss2.meipian.me/users/85846178/fc26aca2fbd8467087455184cc989fe0.jpg",
                        @"https://ss2.meipian.me/users/50475709/e2df163be3d74f2eac5a9c040718d273.jpg"];
}

#pragma mark - lazy
- (UIView *)headImgContainerView {
    if (!_headImgContainerView) {
        _headImgContainerView = [[UIView alloc] init];
    }
    return _headImgContainerView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
