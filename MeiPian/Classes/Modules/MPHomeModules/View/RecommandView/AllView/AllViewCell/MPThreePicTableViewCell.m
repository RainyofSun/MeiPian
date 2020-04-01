//
//  MPThreePicTableViewCell.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPThreePicTableViewCell.h"

@interface MPThreePicTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *atricleTitleLab;
@property (weak, nonatomic) IBOutlet UIView *coverContainerView;
@property (weak, nonatomic) IBOutlet UIButton *articleTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *authorNameBtn;
@property (weak, nonatomic) IBOutlet UILabel *commentsNumLab;
@property (weak, nonatomic) IBOutlet UIButton *coverNumBtn;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *converBtnW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *articleTypeBtnW;
/** imgControlsArray */
@property (nonatomic,strong) NSMutableArray <UIImageView *>*imgControlsArray;
/** lineLayer */
@property (nonatomic,strong) CALayer *lineLayer;

@end

@implementation MPThreePicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
    [self setImgviewControls];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.lineLayer.frame = CGRectMake(15, CGRectGetHeight(self.containerView.bounds)-0.5, ScreenWidth - 30, 0.5);
}

- (void)dealloc {
    for (UIImageView *imgView in self.imgControlsArray) {
        [imgView removeFromSuperview];
    }
    [self.imgControlsArray removeAllObjects];
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadThreePicArticleDataSource:(MPRecommadAllConfigModel *)articleSource {
    self.atricleTitleLab.text = articleSource.recommandAllModel.article.title;
    [self.authorNameBtn setTitle:articleSource.recommandAllModel.author.nickname forState:UIControlStateNormal];
    [self.articleTypeBtn setTitle:articleSource.recommandAllModel.article.feed_tag_info.tag_name forState:UIControlStateNormal];
    self.commentsNumLab.text = articleSource.recommandAllModel.article.comment_count;
    [self.coverNumBtn setTitle:articleSource.recommandAllModel.article.image_count forState:UIControlStateNormal];
    self.converBtnW.constant = articleSource.imgCountW;
    self.articleTypeBtnW.constant = articleSource.articleTypeBtnW;
    [self.imgControlsArray enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj MPSetImageWithURL:articleSource.recommandAllModel.article.cover_imgs[idx]];
    }];
}

- (void)cellAlphaAnimation {
    for (UIImageView *coverImgView in self.imgControlsArray) {
        coverImgView.alpha = 0.4;
        [UIView animateWithDuration:ALPHAANIMATIONTIME animations:^{
            coverImgView.alpha = 1;
        }];
    }
}

#pragma mark - private methods
- (void)setupUI {
    self.coverNumBtn.layer.cornerRadius = CGRectGetHeight(self.coverNumBtn.bounds)/2;
    self.coverNumBtn.clipsToBounds = YES;
    
    self.articleTypeBtn.layer.cornerRadius = CGRectGetHeight(self.articleTypeBtn.bounds)/2;
    self.articleTypeBtn.clipsToBounds = YES;
    
    self.lineLayer.backgroundColor = RGB(237, 237, 237).CGColor;
    [self.containerView.layer addSublayer:self.lineLayer];
}

- (void)setImgviewControls {
    self.imgControlsArray = [NSMutableArray arrayWithCapacity:3];
    CGFloat W = ScreenWidth - 30;
    CGFloat H = CGRectGetHeight(self.coverContainerView.bounds);
    CGFloat Dis = 3.f;
    CGFloat ImgW = (W - Dis * 2)/3;
    for (NSInteger i = 0; i < 3; i ++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((ImgW + Dis) * i, 0, ImgW, H)];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.backgroundColor = HexColor(0xEDEFF4);
        [self.coverContainerView addSubview:imgView];
        [self.imgControlsArray addObject:imgView];
    }
}

#pragma mark - lazy
- (CALayer *)lineLayer {
    if (!_lineLayer) {
        _lineLayer = [CALayer layer];
    }
    return _lineLayer;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
