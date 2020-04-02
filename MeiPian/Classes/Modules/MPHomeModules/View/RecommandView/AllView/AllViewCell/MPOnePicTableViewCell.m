//
//  MPOnePicTableViewCell.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/30.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPOnePicTableViewCell.h"

@interface MPOnePicTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *atricleTitleLab;
@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;
@property (weak, nonatomic) IBOutlet UIButton *articleTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *authorNameBtn;
@property (weak, nonatomic) IBOutlet UILabel *commentsNumLab;
@property (weak, nonatomic) IBOutlet UIButton *coverNumBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverNumBtnW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *articleTypeBtnW;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation MPOnePicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadOnePicArticleDataSource:(MPRecommadAllConfigModel *)articleSource {
    self.atricleTitleLab.text = articleSource.recommandAllModel.article.title;
    [self.coverImgView MPSetImageWithURL:articleSource.recommandAllModel.article.cover_imgs.firstObject];
    [self.authorNameBtn setTitle:articleSource.recommandAllModel.author.nickname forState:UIControlStateNormal];
    [self.articleTypeBtn setTitle:articleSource.recommandAllModel.article.feed_tag_info.tag_name forState:UIControlStateNormal];
    self.commentsNumLab.text = articleSource.recommandAllModel.article.comment_count;
    [self.coverNumBtn setTitle:articleSource.recommandAllModel.article.image_count forState:UIControlStateNormal];;
    self.coverNumBtnW.constant = articleSource.imgCountW;
    self.articleTypeBtnW.constant = articleSource.articleTypeBtnW;
}

- (void)cellAlphaAnimation {
    self.coverImgView.alpha = 0.4;
    [UIView animateWithDuration:ALPHAANIMATIONTIME animations:^{
        self.coverImgView.alpha = 1;
    }];
}

#pragma mark - private methods
- (void)setupUI {
    self.coverNumBtn.layer.cornerRadius = CGRectGetHeight(self.coverNumBtn.bounds)/2;
    self.coverNumBtn.clipsToBounds = YES;
    
    self.articleTypeBtn.layer.cornerRadius = CGRectGetHeight(self.articleTypeBtn.bounds)/2;
    self.articleTypeBtn.clipsToBounds = YES;
    
    self.coverImgView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
