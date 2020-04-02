//
//  MPJXTableViewCell.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/1.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPJXTableViewCell.h"

@interface MPJXTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;
@property (weak, nonatomic) IBOutlet UILabel *atricleTitleLab;
@property (weak, nonatomic) IBOutlet UIButton *authorBtn;
@property (weak, nonatomic) IBOutlet UILabel *commentLab;

@end

@implementation MPJXTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadJingXuanCellSource:(MPJingXuanConfigModel *)modelSource {
    self.atricleTitleLab.text = modelSource.article.title;
    [self.authorBtn setTitle:modelSource.author.nickname forState:UIControlStateNormal];
    self.commentLab.text = modelSource.commentsText;
    [self.coverImgView MPSetImageWithURL:modelSource.article.cover_imgs.firstObject];
    self.atricleTitleLab.textColor = modelSource.textColor;
}

#pragma mark - private methods
- (void)setupUI {
    self.coverImgView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
