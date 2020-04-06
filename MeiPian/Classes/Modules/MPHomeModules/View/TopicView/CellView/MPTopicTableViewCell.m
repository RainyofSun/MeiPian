//
//  MPTopicTableViewCell.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPTopicTableViewCell.h"

@interface MPTopicTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *articleImgView;
@property (weak, nonatomic) IBOutlet UILabel *articleTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *articleSubTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *commentsLab;

@end

@implementation MPTopicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.articleImgView.clipsToBounds = YES;
}

#pragma mark - public methods
- (void)loadTopicCellSource:(MPTopicConfigModel *)configSource {
    [self.articleImgView MPSetImageWithURL:configSource.cover_img];
    self.articleTitleLab.text = configSource.name;
    self.articleSubTitleLab.text = configSource.descriptionStr;
    self.commentsLab.text = configSource.article_count;
}

- (void)cellAlphaAnimation {
    self.articleImgView.alpha = 0.4;
    [UIView animateWithDuration:ALPHAANIMATIONTIME animations:^{
        self.articleImgView.alpha = 1;
    }];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
