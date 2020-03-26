//
//  MPAttentionView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPAttentionView.h"
#import "MPMoreInterestingTableViewCell.h"
#import "MPInterestingPeopleTableViewCell.h"

static NSString *MoreInterestingCellIndifier = @"MoreInterestingCell";
static NSString *InterestingPeopleIndifier   = @"InsterestingPelpleCell";

@interface MPAttentionView ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource>

/** listTableView */
@property (nonatomic,strong) MPBaseTableView *listTableView;

@end

@implementation MPAttentionView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.listTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - MPBaseTableViewDelegate & MPBaseTableViewDataSource
- (NSInteger)MPNumberOfRowsInSection {
    return 1;
}

- (CGFloat)MPHeightForRowAtIndexPath {
    return 80;
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    MPMoreInterestingTableViewCell *cell = [tableView dequeueReusableTableViewCellWithIdentifier:MoreInterestingCellIndifier forIndex:index];
    return cell;
}

- (void)MPDropRefreshLoadMoreSource {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.listTableView.isCompleteRequest = YES;
    });
}

#pragma mark - private methods
- (void)setupUI {
    self.listTableView = [MPBaseTableView setupListView];
    [self.listTableView registerClass:@"MPMoreInterestingTableViewCell" forTableViewCellWithReuseIdentifier:MoreInterestingCellIndifier withNibFile:YES];
    self.listTableView.tableDalegate = self;
    self.listTableView.tableDataSource = self;
    [self addSubview:self.listTableView];
}

@end
