//
//  MPRecommandCollectionViewCell.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/8.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPRecommandCollectionViewCell.h"

@interface MPRecommandCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *recommandImgView;
@property (weak, nonatomic) IBOutlet UIImageView *recommandLevelImgView;
@property (weak, nonatomic) IBOutlet UILabel *articleTitleLab;


@end

@implementation MPRecommandCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadRecommandCellSource:(MPCircleRecommandModel *)modelSource {
    if ([modelSource.thumb_image hasPrefix:@"https"]) {
        [self.recommandImgView MPSetImageWithURL:modelSource.thumb_image];
    } else {
        self.recommandImgView.image = [UIImage imageNamed:modelSource.thumb_image];
    }
    [self.recommandImgView MPSetImageWithURL:modelSource.bedge_image_url];
    self.articleTitleLab.text = modelSource.name;
}

- (void)cellAlphaAnimation {
    self.recommandImgView.alpha = self.recommandLevelImgView.alpha = 0.4;
    [UIView animateWithDuration:ALPHAANIMATIONTIME animations:^{
        self.recommandImgView.alpha = self.recommandLevelImgView.alpha = 1;
    }];
}

#pragma mark - private methods
- (void)setupUI {
    self.recommandImgView.layer.cornerRadius = 5.f;
    self.recommandImgView.clipsToBounds = YES;
}

@end
