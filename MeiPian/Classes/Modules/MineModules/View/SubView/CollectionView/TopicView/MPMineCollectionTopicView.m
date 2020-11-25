//
//  MPMineCollectionTopicView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/23.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineCollectionTopicView.h"

@interface MPMineCollectionTopicView ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

/** topicSource */
@property (nonatomic,strong) NSArray *topicSource;

@end

@implementation MPMineCollectionTopicView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        [self requestWorksSource];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.topicListView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - MPBaseTableViewDelegate & MPBaseTableViewDataSource
- (NSInteger)MPNumberOfRowsInSection {
    return self.topicSource.count;
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    return nil;
}

#pragma mark - DZNEmptyDataSetSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"你没有收藏任何话题\n遇到感兴趣的话题可以收藏在这里";
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
    self.topicListView = [MPBaseTableView setupListView];
    self.topicListView.tableDalegate = self;
    self.topicListView.tableDataSource = self;
    self.topicListView.isOpenHeaderRefresh = self.topicListView.isOpenFooterRefresh = NO;
    self.topicListView.scrollEnabled = NO;
    self.topicListView.backgroundColor = RGB(242, 244, 246);
    [self addSubview:self.topicListView];
}

- (void)requestWorksSource {
    if (!self.topicSource.count) {
        self.topicListView.emptyDataSetDelegate = self;
        self.topicListView.emptyDataSetSource = self;
    }
}

@end
