//
//  MPPushMessageTableViewCell.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPPushMessageTableViewCell.h"
#import "MPPushMsgView.h"

@interface MPPushMessageTableViewCell ()

/** msgViewArray */
@property (nonatomic,strong) NSMutableArray <MPPushMsgView *>*msgViewArray;
/** containerView */
@property (nonatomic,strong) UIView *containerView;

@end

@implementation MPPushMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)dealloc {
    [self deallocViewMemory];
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadPushMessageCellSource:(NSArray<MPPushMessageModel *> *)messageModel {
    [self deallocViewMemory];
    CGFloat pushViewH = (CGRectGetHeight(self.bounds) - 10)/messageModel.count;
    for (NSInteger i = 0; i < messageModel.count; i ++) {
        MPPushMsgView *pushView = [[[NSBundle mainBundle] loadNibNamed:@"MPPushMsgView" owner:nil options:nil] firstObject];
        [pushView loadPushMsgViewSource:messageModel[i]];
        [self.containerView addSubview:pushView];
        pushView.frame = CGRectMake(0, pushViewH * i, CGRectGetWidth(self.bounds), pushViewH);
    }
}

- (void)cellAlphaAnimation {
    for (MPPushMsgView *pushView in self.msgViewArray) {
        [pushView cellAlphaAnimation];
    }
}

#pragma mark - private methods
- (void)deallocViewMemory {
    for (MPPushMsgView *pushView in self.msgViewArray) {
        [pushView removeFromSuperview];
    }
    [self.msgViewArray removeAllObjects];
}

- (void)setupUI {
    self.backgroundColor = self.contentView.backgroundColor = self.containerView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.containerView];
    self.containerView.frame = CGRectMake(0, 8, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 8);
}

#pragma mark - lazy
- (NSMutableArray<MPPushMsgView *> *)msgViewArray {
    if (!_msgViewArray) {
        _msgViewArray = [NSMutableArray array];
    }
    return _msgViewArray;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
