//
//  MPMineCollectionVideoView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/23.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineCollectionVideoView.h"

@interface MPMineCollectionVideoView ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

/** videoSource */
@property (nonatomic,strong) NSArray *videoSource;

@end

@implementation MPMineCollectionVideoView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        [self requestWorksSource];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.videoListView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - MPBaseTableViewDelegate & MPBaseTableViewDataSource
- (NSInteger)MPNumberOfRowsInSection {
    return self.videoSource.count;
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    return nil;
}

#pragma mark - DZNEmptyDataSetSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"你没有收藏任何视频\n赞过的视频都会被收藏在这里";
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
    self.videoListView = [MPBaseTableView setupListView];
    self.videoListView.tableDalegate = self;
    self.videoListView.tableDataSource = self;
    self.videoListView.isOpenHeaderRefresh = self.videoListView.isOpenFooterRefresh = NO;
    self.videoListView.scrollEnabled = NO;
    self.videoListView.backgroundColor = RGB(242, 244, 246);
    [self addSubview:self.videoListView];
}

- (void)requestWorksSource {
    if (!self.videoSource.count) {
        self.videoListView.emptyDataSetDelegate = self;
        self.videoListView.emptyDataSetSource = self;
    }
}

@end
