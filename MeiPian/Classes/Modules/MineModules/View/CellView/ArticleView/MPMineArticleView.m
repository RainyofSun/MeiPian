//
//  MPMineArticleView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/20.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineArticleView.h"
#import "MPMineArticleCellTableViewCell.h"

static NSString *ArticleCellSubCell   = @"ArticleViewSubCell";

@interface MPMineArticleView ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource>

/** articleSource */
@property (nonatomic,strong) NSArray <MPMineWorksModel *>*articleSource;

@end

@implementation MPMineArticleView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor systemBlueColor];
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.articleListView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadArticleSource:(NSArray<MPMineWorksModel *> *)articleSource {
    self.articleSource = articleSource;
    self.articleListView.isCompleteRequest = YES;
}

#pragma mark - MPBaseTableViewDelegate & MPBaseTableViewDataSource
- (NSInteger)MPNumberOfRowsInSection {
    return self.articleSource.count;
}

- (CGFloat)MPHeightForRowAtIndexPath:(NSIndexPath *)index {
    return 300;
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    MPMineArticleCellTableViewCell *cell = [tableView dequeueReusableTableViewCellWithIdentifier:ArticleCellSubCell forIndex:index];
    [cell loadMineWorkModel:self.articleSource[index.row]];
    return cell;
}

#pragma mark - private methods
- (void)setupUI {
    self.articleListView = [MPBaseTableView setupListView];
    self.articleListView.tableDalegate = self;
    self.articleListView.tableDataSource = self;
    self.articleListView.isOpenHeaderRefresh = NO;
    self.articleListView.isOpenFooterRefresh = NO;
    self.articleListView.showsHorizontalScrollIndicator = NO;
    self.articleListView.showsVerticalScrollIndicator = NO;
    self.articleListView.scrollEnabled = NO;
    [self addSubview:self.articleListView];
    [self.articleListView registerClass:@"MPMineArticleCellTableViewCell" forTableViewCellWithReuseIdentifier:ArticleCellSubCell withNibFile:YES];
}

@end
