//
//  MPPushMessageTableViewCell.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/13.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPPushMessageTableViewCell.h"
#import "MPPushTableViewCell.h"

static NSString *pushCell = @"PushTableViewCell";

@interface MPPushMessageTableViewCell ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource>

/** containerView */
@property (nonatomic,strong) UIView *containerView;
/** pushListView */
@property (nonatomic,strong) MPBaseTableView *pushListView;
/** pushSource */
@property (nonatomic,strong) NSArray <MPPushMessageModel *>*pushSource;

@end

@implementation MPPushMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.pushListView.frame = CGRectMake(0, 8, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 8);
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadPushMessageCellSource:(NSArray<MPPushMessageModel *> *)messageModel {
    self.pushSource = messageModel;
    self.pushListView.isCompleteRequest = YES;
}

#pragma mark - MPBaseTableViewDelegate & MPBaseTableViewDataSource
- (NSInteger)MPNumberOfRowsInSection {
    return self.pushSource.count;
}

- (CGFloat)MPHeightForRowAtIndexPath:(NSIndexPath *)index {
    CGFloat pushViewH = (CGRectGetHeight(self.bounds) - 8)/self.pushSource.count;
    return pushViewH;
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    MPPushTableViewCell *cell = [tableView dequeueReusableTableViewCellWithIdentifier:pushCell forIndex:index];
    [cell loadPushMsgViewSource:self.pushSource[index.row]];
    return cell;
}

- (void)MPBaseTableViewCellEditingAtIndexPath:(NSIndexPath *)index {
    [MPModulesMsgSend sendCumtomMethodMsg:self.superview.superview methodName:@selector(deletePushMsg:) params:[NSNumber numberWithInteger:index.row]];
}

- (void)cellAlphaAnimation {
    
}

#pragma mark - private methods
- (void)setupUI {
    self.pushListView = [MPBaseTableView setupListView];
    self.pushListView.tableDalegate = self;
    self.pushListView.tableDataSource = self;
    self.pushListView.isOpenFooterRefresh = NO;
    self.pushListView.isOpenHeaderRefresh = NO;
    self.pushListView.isOpenEdit = YES;
    self.pushListView.bounces = NO;
    self.pushListView.scrollEnabled = NO;
    [self.contentView addSubview:self.pushListView];
    [self.pushListView registerClass:@"MPPushTableViewCell" forTableViewCellWithReuseIdentifier:pushCell withNibFile:NO];
    self.backgroundColor = self.contentView.backgroundColor = self.pushListView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - lazy
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
