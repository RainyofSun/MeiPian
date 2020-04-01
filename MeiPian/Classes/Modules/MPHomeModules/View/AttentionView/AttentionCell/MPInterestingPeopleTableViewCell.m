//
//  MPInterestingPeopleTableViewCell.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/27.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPInterestingPeopleTableViewCell.h"

@interface MPInterestingTipCell ()

/** topTipLab */
@property (nonatomic,strong) UILabel *topTipLab;

@end

@implementation MPInterestingTipCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.topTipLab autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:13];
    [self.topTipLab autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.contentView withOffset:15];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - private methods
- (void)setupUI {
    self.topTipLab.text = @"你可能感兴趣的人";
    self.topTipLab.textColor = MAIN_BLACK_COLOR;
    self.topTipLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.topTipLab];
}

#pragma mark - lazy
- (UILabel *)topTipLab {
    if (!_topTipLab) {
        _topTipLab = [[UILabel alloc] init];
    }
    return _topTipLab;
}

@end

@interface MPInterestingPeopleTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *signLab;
@property (weak, nonatomic) IBOutlet UILabel *fanNumLab;
@property (weak, nonatomic) IBOutlet UIButton *headImgBtn;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UIImageView *vipImgView;
@property (weak, nonatomic) IBOutlet UIImageView *highQualityAuthorImgView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
/** lineLayer */
@property (nonatomic,strong) CALayer *lineLayer;

@end

@implementation MPInterestingPeopleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.lineLayer.frame = CGRectMake(65, CGRectGetHeight(self.contentView.bounds)-0.5, CGRectGetWidth(self.contentView.bounds) - 75, 0.5);
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadInterestUsersInfo:(MPAttentionModelConfig *)userInfo {
    [self.headImgBtn setImageWithURL:[NSURL URLWithString:userInfo.interestUsers.head_img] forState:UIControlStateNormal options:YYWebImageOptionSetImageWithFadeAnimation];
    self.userNameLab.text = userInfo.interestUsers.name;
    self.signLab.text = userInfo.interestUsers.signature;
    self.fanNumLab.text = userInfo.interestUsers.summary_tips;
    self.vipImgView.hidden = !userInfo.interestUsers.bedge_img.length;
    self.highQualityAuthorImgView.hidden = !userInfo.interestUsers.label_img.length;
    if (userInfo.interestUsers.bedge_img.length) {
        [self.vipImgView setImageWithURL:[NSURL URLWithString:userInfo.interestUsers.bedge_img] options:YYWebImageOptionSetImageWithFadeAnimation];
    }
    if (userInfo.interestUsers.label_img.length) {
        [self.highQualityAuthorImgView setImageWithURL:[NSURL URLWithString:userInfo.interestUsers.label_img] options:YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionProgressiveBlur];
    }
}

- (void)cellAlphaAnimation {
    self.headImgBtn.alpha = 0.4;
    [UIView animateWithDuration:ALPHAANIMATIONTIME animations:^{
        self.headImgBtn.alpha = 1;
    }];
}

#pragma mark - private methods
- (void)setupUI {
    
    self.headImgBtn.layer.cornerRadius = 20.f;
    self.headImgBtn.clipsToBounds = YES;
    
    self.attentionBtn.layer.cornerRadius = 14.f;
    self.attentionBtn.clipsToBounds = YES;
    
    self.lineLayer = [CALayer layer];
    self.lineLayer.backgroundColor = RGB(237, 237, 237).CGColor;
    [self.containerView.layer addSublayer:self.lineLayer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
