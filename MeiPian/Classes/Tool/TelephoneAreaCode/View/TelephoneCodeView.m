//
//  TelephoneCodeView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "TelephoneCodeView.h"
#import "TelephoneCodeIndexView.h"

static NSString *CodeCellIdentifier = @"AreaCode";
static CGFloat indexW = 40;

@interface TelephoneCodeCellView ()

/** countryLab */
@property (nonatomic,strong) UILabel *countryLab;
/** codeLab */
@property (nonatomic,strong) UILabel *codeLab;

@end

@implementation TelephoneCodeCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.countryLab.frame = CGRectMake(15, 0, CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds));
    self.codeLab.frame = CGRectMake(CGRectGetWidth(self.bounds)/3*2 - indexW, 0, CGRectGetWidth(self.bounds)/3, CGRectGetHeight(self.bounds));
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadCodeCellSource:(NSArray *)cellSource {
    self.countryLab.text = cellSource.firstObject;
    self.codeLab.text = cellSource.lastObject;
}

- (void)setupUI {
    
    self.codeLab.textColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1];
    self.codeLab.textAlignment = NSTextAlignmentRight;
    
    [self addSubview:self.countryLab];
    [self addSubview:self.codeLab];
}

#pragma mark - lazy
- (UILabel *)countryLab {
    if (!_countryLab) {
        _countryLab = [[UILabel alloc] init];
    }
    return _countryLab;
}

- (UILabel *)codeLab {
    if (!_codeLab) {
        _codeLab = [[UILabel alloc] init];
    }
    return _codeLab;
}

@end

@interface TelephoneCodeView ()<UITableViewDelegate,UITableViewDataSource,TelephoneCodeIndexDelegate>

/** codeTableView */
@property (nonatomic,strong) UITableView *codeTableView;
/** codeSource */
@property (nonatomic,strong) NSArray <NSArray *>*codeSource;
/** sectionTitleSource */
@property (nonatomic,strong) NSArray <NSString *>*sectionTitleSource;
/** indexView */
@property (nonatomic,strong) TelephoneCodeIndexView *indexView;

@end

@implementation TelephoneCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.codeTableView.frame = self.frame;
}

- (void)dealloc {
    self.codeTableView.tableHeaderView = nil;
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadCodeSources:(NSArray<NSArray *> *)codeSource {
    self.codeSource = codeSource;
    [self.codeTableView reloadData];
}

- (void)loadSectionTitleSource:(NSArray<NSString *> *)sectionTitleSource {
    self.sectionTitleSource = sectionTitleSource;
    [self.indexView loadIndexSource:sectionTitleSource];
}

- (void)addHeaderSearchView:(UISearchBar *)searchBar {
    self.codeTableView.tableHeaderView = searchBar;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.codeSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.codeSource[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TelephoneCodeCellView *cell = [tableView dequeueReusableCellWithIdentifier:CodeCellIdentifier];
    [cell loadCodeCellSource:self.codeSource[indexPath.section][indexPath.row]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.isSearchActive ? @"" : self.sectionTitleSource[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.codeDelegate != nil && [self.codeDelegate respondsToSelector:@selector(didSelectedCountryArea:)]) {
        NSArray *areaSource = self.codeSource[indexPath.section][indexPath.row];
        [self.codeDelegate didSelectedCountryArea:areaSource.lastObject];
    }
}

#pragma mark - TelephoneCodeIndexDelegate
- (void)didSelectedAlphabetIndex:(NSInteger)index {
    if (index >= self.codeSource.count) {
        return;
    }
    [self.codeTableView scrollToRow:0 inSection:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - private methods
- (void)setupUI {
    [self addSubview:self.codeTableView];
    [self addSubview:self.indexView];
    self.codeTableView.delegate = self;
    self.codeTableView.dataSource = self;
    self.indexView.alphabetIndexDelegate = self;
    [self.codeTableView registerClass:[TelephoneCodeCellView class] forCellReuseIdentifier:CodeCellIdentifier];
}

#pragma mark - lazy
- (UITableView *)codeTableView {
    if (!_codeTableView) {
        _codeTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    return _codeTableView;
}

- (TelephoneCodeIndexView *)indexView {
    if (!_indexView) {
        _indexView = [[TelephoneCodeIndexView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) - indexW, 56, indexW, CGRectGetHeight(self.bounds) - 56 * 2)];
    }
    return _indexView;
}

#pragma mark - setter
- (void)setIsSearchActive:(BOOL)isSearchActive {
    _isSearchActive = isSearchActive;
    self.indexView.hidden = isSearchActive;
}

@end
