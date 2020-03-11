//
//  TelephoneCodeView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "TelephoneCodeView.h"

@interface TelephoneCodeView ()

/** codeTableView */
@property (nonatomic,strong) UITableView *codeTableView;

@end

@implementation TelephoneCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - private methods
- (void)setupUI {
   
}

#pragma mark - lazy
- (UITableView *)codeTableView {
    if (!_codeTableView) {
        _codeTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    return _codeTableView;
}

@end
