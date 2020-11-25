//
//  MPMineArticleCellTableViewCell.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/20.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineArticleCellTableViewCell.h"

@interface MPMineArticleCellTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *moreInfoBtn;
@property (weak, nonatomic) IBOutlet UIImageView *articleImgView;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *commentsLab;

@end

@implementation MPMineArticleCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadMineWorkModel:(MPMineWorksModel *)worksModel {
    self.titleLab.text = worksModel.title;
    [self.articleImgView MPSetImageWithURL:worksModel.cover_img_url];
    self.timeLab.text = worksModel.articleTime;
    self.commentsLab.text = worksModel.comments;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
