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

/** lineLayer */
@property (nonatomic,strong) CALayer *lineLayer;

@end

@implementation MPJXTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.lineLayer.frame = CGRectMake(15, CGRectGetHeight(self.containerView.bounds)-0.5, ScreenWidth - 30, 0.5);
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
}

#pragma mark - private methods
- (void)setupUI {
    self.lineLayer.backgroundColor = RGB(237, 237, 237).CGColor;
    [self.containerView.layer addSublayer:self.lineLayer];
    
    self.coverImgView.clipsToBounds = YES;
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
