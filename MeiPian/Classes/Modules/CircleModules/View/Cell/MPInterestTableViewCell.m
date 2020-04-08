//
//  MPInterestTableViewCell.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/8.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPInterestTableViewCell.h"

@interface MPInterestTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userHeadImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *articleTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *commentsLab;

@end

@implementation MPInterestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadInterestCellSource:(MPCircleInterestArticleConfigModel *)modelSource {
    [self.userHeadImgView MPSetImageWithURL:modelSource.user.head_img];
    self.userNameLab.text = modelSource.user.nickname;
    [self.coverImgView MPSetImageWithURL:modelSource.talk.img];
    self.timeLab.text = modelSource.articleTime;
    self.articleTitleLab.text = modelSource.talk.text;
    self.commentsLab.text = modelSource.talk.summary;
}

- (void)cellAlphaAnimation {
    self.coverImgView.alpha = 0.4;
    [UIView animateWithDuration:ALPHAANIMATIONTIME animations:^{
        self.coverImgView.alpha = 1;
    }];
}

#pragma mark - private methods
- (void)setupUI {
    self.userHeadImgView.layer.cornerRadius = CGRectGetWidth(self.userHeadImgView.bounds)/2;
    self.userHeadImgView.clipsToBounds = YES;
    self.coverImgView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
