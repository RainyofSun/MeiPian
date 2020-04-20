//
//  MPMinePageView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/16.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMinePageView.h"
#import "MPMineInfoTableViewCell.h"
#import "MPMineArticleTableViewCell.h"
#import "MPMineSliderBarView.h"
#import "MPMineViewModel.h"

static NSString *InfoCell = @"MineInfoCell";
static NSString *ArticleCell = @"MineArticleCell";
static NSString *SectionHeaderIdentifier = @"ArticleHeader";

@interface MPMinePageView ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource>

/** mineListView */
@property (nonatomic,strong) MPBaseTableView *mineListView;
/** sliderBarView */
@property (nonatomic,strong) MPMineSliderBarView *sliderBarView;
/** mineVM */
@property (nonatomic,strong) MPMineViewModel *mineVM;
/** mineSource */
@property (nonatomic,strong) NSArray <MPMineConfigModel *>*mineSource;
/** sliderbarSelectedIndex */
@property (nonatomic,assign) NSInteger sliderbarSelectedIndex;
/** isNeedRefreshSliderBarSource */
@property (nonatomic,assign) BOOL isNeedRefreshSliderBarSource;

@end

@implementation MPMinePageView

- (instancetype)init {
    if (self = [super init]) {
        [self setDefaultData];
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

#pragma mark - 消息透传
// 切换sliderBar
- (void)switchSliderBar:(NSNumber *)senderTag {
    self.sliderbarSelectedIndex = senderTag.integerValue;
    [self.sliderBarView switchSliderBarSlectedItem:senderTag];
    self.mineListView.isCompleteRequest = YES;
}

// 重新调整偏移量
- (void)resetScrollViewContentOffset:(NSNumber *)senderTag {
    self.sliderbarSelectedIndex = senderTag.integerValue;
    MPMineArticleTableViewCell *cell = [self.mineListView MPBaseTableViewCellForRowAtIndex:[NSIndexPath indexPathForRow:0 inSection:(self.mineSource.count - 1)]];
    [cell resetSubScrollViewContentOffSet:senderTag];
    self.mineListView.isCompleteRequest = YES;
}

#pragma mark - MPBaseTableViewDelegate & MPBaseTableViewDataSource
- (NSInteger)MPNumberOfSections {
    return self.mineSource.count;
}

- (NSInteger)MPNumberOfRowsInSection {
    return 1;
}

- (CGFloat)MPHeightForRowAtIndexPath:(NSIndexPath *)index {
    if (index.section == 0) {
        return self.mineSource[index.section].cellHeightSource.firstObject.floatValue;
    } else {
        return self.mineSource[index.section].cellHeightSource[self.sliderbarSelectedIndex].floatValue;
    }
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    switch (self.mineSource[index.section].cellType) {
        case MineCellStyle_info:
        {
            MPMineInfoTableViewCell *cell = [tableView dequeueReusableTableViewCellWithIdentifier:InfoCell forIndex:index];
            [cell loadMineInfoSource:self.mineSource[index.section].infoModel];
            return cell;
        }
        case MineCellStyle_Article:
        {
            MPMineArticleTableViewCell *cell = [tableView dequeueReusableTableViewCellWithIdentifier:ArticleCell forIndex:index];
            [cell loadMineArticleSource:self.mineSource[index.section].articleModel];
            return cell;
        }
        default:
            break;
    }
    return nil;
}

- (UIView *)MPBaseTableView:(MPBaseTableView *)tableview headerFooterInSection:(NSInteger)section isSectionHeader:(BOOL)sectionHeader {
    if (sectionHeader) {
        if (section == 0) {
            return nil;
        }
        self.sliderBarView = [tableview dequeueCustomReusableHeaderFooterViewWithIdentifier:SectionHeaderIdentifier];
        self.isNeedRefreshSliderBarSource ? [self.sliderBarView loadSliderBarTitleSource:self.mineSource[section].sliderTitleSource] : nil;
        self.isNeedRefreshSliderBarSource = NO;
        return self.sliderBarView;
    }
    return nil;
}

- (CGFloat)MPHeightForHeaderInSection:(NSInteger)index isSectionHeader:(BOOL)sectionHeader {
    if (sectionHeader) {
        return index == 1 ? 50 : 0.00001;
    } else {
        return 0.00001;
    }
}

- (void)MPDropRefreshLoadMoreSource {
    [self requestMineInfo];
}

#pragma mark - private methods
- (void)setDefaultData {
    self.sliderbarSelectedIndex = 0;
    self.isNeedRefreshSliderBarSource = YES;
}

- (void)setupUI {
    self.mineListView = [MPBaseTableView setupListView];
    self.mineListView.tableDalegate = self;
    self.mineListView.tableDataSource = self;
    self.mineListView.isOpenFooterRefresh = NO;
    [self addSubview:self.mineListView];
    [self.mineListView registerClass:@"MPMineInfoTableViewCell" forTableViewCellWithReuseIdentifier:InfoCell withNibFile:YES];
    [self.mineListView registerClass:@"MPMineArticleTableViewCell" forTableViewCellWithReuseIdentifier:ArticleCell withNibFile:NO];
    [self.mineListView registerClass:@"MPMineSliderBarView" forHeaderFooterViewReuseIdentifier:SectionHeaderIdentifier withNibFile:NO isSectionHeader:YES];
}

- (void)requestMineInfo {
    WeakSelf;
    [self.mineVM MPMineInfoRequest:^(id  _Nonnull returnValue) {
        weakSelf.mineSource = (NSArray <MPMineConfigModel *>*)returnValue;
        weakSelf.mineListView.isCompleteRequest = YES;
    }];
}

#pragma mark - lazy
- (MPMineViewModel *)mineVM {
    if (!_mineVM) {
        _mineVM = [[MPMineViewModel alloc] init];
    }
    return _mineVM;
}

@end
