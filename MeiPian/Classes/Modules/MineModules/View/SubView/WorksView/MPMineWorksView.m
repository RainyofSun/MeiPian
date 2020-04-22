//
//  MPMineWorksView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/20.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineWorksView.h"

@interface MPMineWorksView ()<MPBaseTableViewDelegate,MPBaseTableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

/** worksSource */
@property (nonatomic,strong) NSArray *worksSource;

@end

@implementation MPMineWorksView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        [self requestWorksSource];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.worksListView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - MPBaseTableViewDelegate & MPBaseTableViewDataSource
- (NSInteger)MPNumberOfRowsInSection {
    return self.worksSource.count;
}

- (UITableViewCell *)MPBaseTableView:(MPBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {
    return nil;
}

#pragma mark - DZNEmptyDataSetSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"你还没有作品集\n作品挤可以整理归纳你的作品";
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

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    // 设置按钮标题
    NSString *buttonTitle = @"  新建作品集";
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f],
                                 NSForegroundColorAttributeName : MAIN_BLUE_COLOR,
                                 };
    
    NSMutableAttributedString *textStr = [[NSMutableAttributedString alloc] initWithString:buttonTitle attributes:attributes];
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"content_icon_add"];
    attachment.bounds = CGRectMake(0, -2, attachment.image.size.width, attachment.image.size.height);
    NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:attachment];
    [textStr insertAttributedString:imgStr atIndex:0];
    return textStr;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    // 处理视图点击事件...
    NSLog(@"touch view");
//    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(gotoBorrowMoney)];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    // 处理按钮点击事件...
    NSLog(@"touch Btn");
//    [EGLSModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(gotoBorrowMoney)];
}

#pragma mark - private methods
- (void)setupUI {
    self.worksListView = [MPBaseTableView setupListView];
    self.worksListView.tableDalegate = self;
    self.worksListView.tableDataSource = self;
    self.worksListView.isOpenHeaderRefresh = self.worksListView.isOpenFooterRefresh = NO;
    self.worksListView.scrollEnabled = NO;
    self.worksListView.backgroundColor = RGB(242, 244, 246);
    [self addSubview:self.worksListView];
}

- (void)requestWorksSource {
    if (!self.worksSource.count) {
        self.worksListView.emptyDataSetDelegate = self;
        self.worksListView.emptyDataSetSource = self;
    }
}

@end
