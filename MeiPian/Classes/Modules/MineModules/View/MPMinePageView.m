//
//  MPMinePageView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/16.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMinePageView.h"
#import "MPMineInfoTableViewCell.h"

static NSString *InfoCell = @"MineInfoCell";

@interface MPMinePageView ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource>

/** mineListView */
@property (nonatomic,strong) MPBaseTableView *mineListView;

@end

@implementation MPMinePageView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.mineListView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - MPBaseTableViewDelegate & MPBaseTableViewDataSource
- (NSInteger)MPNumberOfSections {
    return 2;
}

- (NSInteger)MPNumberOfRowsInSection {
    return 1;
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    MPMineInfoTableViewCell *cell = [tableView dequeueReusableTableViewCellWithIdentifier:InfoCell forIndex:index];
    return cell;
}

#pragma mark - private methods
- (void)setupUI {
    self.mineListView = [MPBaseTableView setupListView];
    self.mineListView.tableDalegate = self;
    self.mineListView.tableDataSource = self;
    self.mineListView.isOpenFooterRefresh = NO;
    [self addSubview:self.mineListView];
    [self.mineListView registerClass:@"MPMineInfoTableViewCell" forTableViewCellWithReuseIdentifier:InfoCell withNibFile:YES];
}

@end
