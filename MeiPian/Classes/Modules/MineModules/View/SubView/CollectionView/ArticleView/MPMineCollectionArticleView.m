//
//  MPMineCollectionArticleView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/23.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineCollectionArticleView.h"

@interface MPMineCollectionArticleView ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

/** collectionArticleSource */
@property (nonatomic,strong) NSArray *collectionArticleSource;

@end

@implementation MPMineCollectionArticleView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        [self requestWorksSource];
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

#pragma mark - MPBaseTableViewDelegate & MPBaseTableViewDataSource
- (NSInteger)MPNumberOfRowsInSection {
    return self.collectionArticleSource.count;
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    return nil;
}

#pragma mark - DZNEmptyDataSetSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"你没有收藏任何文章\n遇到喜欢的文章可以收藏在这里";
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineHeightMultiple = 1.3;
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{
                                NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0f],
                                NSForegroundColorAttributeName:RGB(142, 143, 146),
                                NSParagraphStyleAttributeName:style,};
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:title attributes:attributes];
    return attributeStr;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return SizeHeight(25);
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    // 处理视图点击事件...
    NSLog(@"touch view");
//    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(gotoBorrowMoney)];
}

#pragma mark - private methods
- (void)setupUI {
    self.articleListView = [MPBaseTableView setupListView];
    self.articleListView.tableDalegate = self;
    self.articleListView.tableDataSource = self;
    self.articleListView.isOpenHeaderRefresh = self.articleListView.isOpenFooterRefresh = NO;
    self.articleListView.scrollEnabled = NO;
    self.articleListView.backgroundColor = RGB(242, 244, 246);
    [self addSubview:self.articleListView];
}

- (void)requestWorksSource {
    if (!self.collectionArticleSource.count) {
        self.articleListView.emptyDataSetDelegate = self;
        self.articleListView.emptyDataSetSource = self;
    }
}

@end
