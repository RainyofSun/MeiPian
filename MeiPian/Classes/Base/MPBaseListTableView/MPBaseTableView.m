//
//  MPBaseTableView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/26.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseTableView.h"
#import "MPDolphinRefreshHeader.h"

@interface MPBaseTableView ()<UITableViewDelegate,UITableViewDataSource>

/** tableViewSource */
@property (nonatomic,strong) NSMutableArray <id>*tableViewSource;

@end

@implementation MPBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        [self setRefreshHeader];
    }
    return self;
}

- (void)dealloc {
    self.delegate = nil;
    self.dataSource = nil;
    self.tableDalegate = nil;
    self.tableDataSource = nil;
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
+ (MPBaseTableView *)setupListView {
    MPBaseTableView *tableView = [[MPBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = MAIN_LIGHT_GRAY_COLOR;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tableView;
}

- (void)loadListSource:(NSArray<id> *)listSource {
    [self.tableViewSource removeAllObjects];
    [self.tableViewSource addObjectsFromArray:listSource];
    [self reloadData];
}

- (void)registerClass:(NSString *)cellClassName forTableViewCellWithReuseIdentifier:(NSString *)identifier withNibFile:(BOOL)hasXibFile {
    if (!identifier.length) {
        [NSException raise:@"This identifier must not be nil and must not be an empty string." format:@""];
    }
    if (hasXibFile) {
        [self registerNib:[UINib nibWithNibName:cellClassName bundle:nil] forCellReuseIdentifier:identifier];
    } else {
        [self registerClass:[NSClassFromString(cellClassName) class] forCellReuseIdentifier:identifier];
    }
}

- (UITableViewCell *)dequeueReusableTableViewCellWithIdentifier:(NSString *)identifier forIndex:(NSIndexPath *)index {
    if (!identifier.length) {
        [NSException raise:@"This identifier must not be nil and must not be an empty string." format:@""];
    }
    if (!index) {
        [NSException raise:@"please change an identifier" format:@""];
    }
    return [self dequeueReusableCellWithIdentifier:identifier forIndexPath:index];
}

- (UITableViewCell *)MPBaseTableViewCellForRowAtIndex:(NSIndexPath *)index {
    return [self cellForRowAtIndexPath:index];
}

- (void)loadNewData {
    if (self.tableDataSource != nil && [self.tableDataSource respondsToSelector:@selector(MPDropRefreshLoadMoreSource)]) {
        [self.tableDataSource MPDropRefreshLoadMoreSource];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.tableDataSource != nil && [self.tableDataSource respondsToSelector:@selector(MPNumberOfRowsInSection)]) {
        return [self.tableDataSource MPNumberOfRowsInSection];
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableDalegate != nil && [self.tableDalegate respondsToSelector:@selector(MPHeightForRowAtIndexPath)]) {
        return [self.tableDalegate MPHeightForRowAtIndexPath];
    } else {
        return 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableDataSource != nil && [self.tableDataSource respondsToSelector:@selector(MPBaseTableView:cellForRowAtIndexPath:)]) {
        return [self.tableDataSource MPBaseTableView:self cellForRowAtIndexPath:indexPath];
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableDalegate != nil && [self.tableDalegate respondsToSelector:@selector(MPBaseTableView:didSelectedAtIndex:)]) {
        [self.tableDalegate MPBaseTableView:self didSelectedAtIndex:indexPath];
    }
}

#pragma mark - private methods
- (void)setRefreshHeader {
    self.mj_header = [MPDolphinRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 马上进入刷新状态
    [self.mj_header beginRefreshing];
}

#pragma mark - setter
- (void)setIsCompleteRequest:(BOOL)isCompleteRequest {
    _isCompleteRequest = isCompleteRequest;
    isCompleteRequest ? [self.mj_header endRefreshing] : nil;
}

#pragma mark - lazy
- (NSMutableArray<id> *)tableViewSource {
    if (!_tableViewSource) {
        _tableViewSource = [NSMutableArray array];
    }
    return _tableViewSource;
}

@end
