//
//  TelephoneCodeViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "TelephoneCodeViewModel.h"
#import "TelephoneCodeView.h"

@interface TelephoneCodeViewModel ()<UISearchResultsUpdating>

/** searchVC */
@property (nonatomic,strong) UISearchController *seearchVC;

@end

@implementation TelephoneCodeViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 加载主界面
- (void)loadTelephoneCodeMainView:(UIViewController *)vc {
    TelephoneCodeView *codeView = [[TelephoneCodeView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(vc.view.bounds), CGRectGetHeight(vc.view.bounds))];
    [vc.view addSubview:codeView];
}

// 加载searchVC
- (void)loadNavSearchItem:(UIViewController *)vc {
    self.seearchVC = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.seearchVC.searchResultsUpdater = self;
    if (@available(iOS 9.1, *)) {
        self.seearchVC.obscuresBackgroundDuringPresentation = NO;
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 11.0, *)) {
        vc.navigationItem.searchController = self.seearchVC;
        vc.navigationItem.hidesSearchBarWhenScrolling = NO;
    } else {
        // Fallback on earlier versions
    }
    
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

@end
