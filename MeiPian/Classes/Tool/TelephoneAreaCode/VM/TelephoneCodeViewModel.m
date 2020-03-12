//
//  TelephoneCodeViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "TelephoneCodeViewModel.h"
#import "TelephoneCodeView.h"
#import "TelephoneCodeData.h"

@interface TelephoneCodeViewModel ()<UISearchResultsUpdating,UISearchBarDelegate,TelephoneCodeSelectedDelegate>

/** searchVC */
@property (nonatomic,strong) UISearchController *searchVC;
/** codeSource */
@property (nonatomic,strong) NSArray <NSArray *>*codeSource;
/** searchResultsArray */
@property (nonatomic,strong) NSMutableArray *searchResultsArray;
/** codeView */
@property (nonatomic,strong) TelephoneCodeView *codeView;

@end

@implementation TelephoneCodeViewModel

- (void)dealloc {
    self.searchVC.searchResultsUpdater = nil;
    self.searchVC = nil;
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 加载主界面
- (void)loadTelephoneCodeMainView:(UIViewController *)vc {
    self.codeView = [[TelephoneCodeView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(vc.view.bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - kNavBarAndStatusBarHeight)];
    [vc.view addSubview:self.codeView];
    self.codeSource = [TelephoneCodeData countryCodeSource];
    [self.codeView loadSectionTitleSource:[TelephoneCodeData countryCodeIndexes]];
    [self.codeView loadCodeSources:self.codeSource];
    [self customSearch];
    [self.codeView addHeaderSearchView:self.searchVC.searchBar];
    self.codeView.codeDelegate = self;
    // 确定UISearchController将要显示的父视图
    vc.definesPresentationContext = YES;
    [vc.navigationController.navigationBar setTranslucent:NO];
}

// 设置NavItem
- (void)setNavItems:(UIViewController *)vc {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"login_close"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, backBtn.currentImage.size.width * 1.2, backBtn.currentImage.size.height*1.2);
    [backBtn addTarget:self action:@selector(disNav:) forControlEvents:UIControlEventTouchUpInside];
    vc.title = @"选择国家和地区";
    [vc setNavigationBackButton:backBtn];
    
}

// 给控件调用者发送消息
- (void)sendMsgToCaller:(NSString *)msg callee:(nonnull UIViewController *)vc{
    UINavigationController *nav = (UINavigationController *)vc.presentingViewController;
    ((void (*)(id,SEL,id))objc_msgSend)(nav.topViewController,@selector(updateAreaCode:),msg);
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *inputStr = searchController.searchBar.text;
    if (!inputStr.length) {
        return;
    }
    if (self.searchResultsArray.count) {
        [self.searchResultsArray removeAllObjects];
    }
    NSString *countryName = nil;
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSArray *codeArray in self.codeSource) {
        for (NSArray *countryArray in codeArray) {
            countryName = countryArray.firstObject;
            if ([countryName containsString:inputStr]) {
                [tempArray addObject:countryArray];
            }
        }
    }
    [self.searchResultsArray addObject:tempArray];
    [self.codeView loadCodeSources:self.searchResultsArray];
    if (self.searchResultsArray.count) {
        self.codeView.isSearchActive = YES;
    }
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].title = @"取消";
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.codeView.isSearchActive = NO;
    [self.codeView loadCodeSources:self.codeSource];
}

#pragma mark - TelephoneCodeSelectedDelegate
- (void)didSelectedCountryArea:(NSString *)areaCode {
    if (self.disCallBack) {
        self.disCallBack(areaCode);
    }
}

#pragma mark - private methods
- (void)disNav:(UIButton *)sender {
    if (self.disCallBack) {
        self.disCallBack(@"");
    }
}

- (void)customSearch {
    self.searchVC = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchVC.searchResultsUpdater = self;
    self.searchVC.searchBar.delegate = self;
    if (@available(iOS 9.1, *)) {
        // 搜索时背景变模糊
        self.searchVC.obscuresBackgroundDuringPresentation = YES;
        // 搜索时背景变暗色
        self.searchVC.dimsBackgroundDuringPresentation = NO;
        // 隐藏导航栏在搜索的时候
        self.searchVC.hidesNavigationBarDuringPresentation = YES;
    } else {
        // Fallback on earlier versions
    }
    UIImageView *barImageView = [[[self.searchVC.searchBar.subviews firstObject] subviews] firstObject];
    barImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    barImageView.layer.borderWidth = 1;
    
    UITextField *searchField = nil;
    if (@available(iOS 13.0, *)) {
        searchField = self.searchVC.searchBar.searchTextField;
    } else {
        searchField = [self.searchVC.searchBar valueForKey:@"searchField"];
    }

    self.searchVC.searchBar.placeholder = @"搜索国家和地区";
    self.searchVC.searchBar.barTintColor = [UIColor whiteColor];
    
    if (searchField) {
        [searchField setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:240/255.0 alpha:1]];
        searchField.layer.cornerRadius = 16.0f;
        searchField.clipsToBounds = YES;
    }
}

#pragma mark - lazy
- (NSMutableArray *)searchResultsArray {
    if (!_searchResultsArray) {
        _searchResultsArray = [NSMutableArray array];
    }
    return _searchResultsArray;
}

@end
