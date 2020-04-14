//
//  MPPushTableViewCell.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/14.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPPushTableViewCell.h"
#import "MPPushMsgView.h"

@interface MPPushTableViewCell ()

/** pushView */
@property (nonatomic,strong) MPPushMsgView *pushView;

@end

@implementation MPPushTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadPushMsgViewSource:(MPPushMessageModel *)modelSource {
    [self.pushView loadPushMsgViewSource:modelSource];
}

#pragma mark - private methods
- (void)setupUI {
    [self.contentView addSubview:self.pushView];
    [self.pushView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - lazy
- (MPPushMsgView *)pushView {
    if (!_pushView) {
        _pushView = [[[NSBundle mainBundle] loadNibNamed:@"MPPushMsgView" owner:nil options:nil] firstObject];
    }
    return _pushView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
