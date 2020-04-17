//
//  MPMineArticleTableViewCell.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineArticleTableViewCell.h"
#import "MPArticleCellViewModel.h"

@interface MPMineArticleTableViewCell ()

/** cellVM */
@property (nonatomic,strong) MPArticleCellViewModel *cellVM;

@end

@implementation MPMineArticleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadMineArticleSource:(MPMineArticleModel *)articleSource {
    self.cellVM.articleModel = articleSource;
}

#pragma mark - private methods
- (void)setupUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - lazy
- (MPArticleCellViewModel *)cellVM {
    if (!_cellVM) {
        _cellVM = [[MPArticleCellViewModel alloc] init];
    }
    return _cellVM;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
