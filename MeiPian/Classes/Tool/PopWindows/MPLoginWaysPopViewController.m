//
//  MPLoginWaysPopViewController.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPLoginWaysPopViewController.h"
#import "SeparateLineButton.h"

@interface MPLoginWaysPopViewController ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet SeparateLineButton *cancelBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewH;

@end

@implementation MPLoginWaysPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
    [self setupPopSource];
}

- (IBAction)touchCancelBtn:(SeparateLineButton *)sender {
    WeakSelf;
    [self dismissViewController:^{
        weakSelf.completeBlock ? weakSelf.completeBlock(sender.tag) : nil;
    }];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor clearColor];
    [self.bgView cutViewRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:15.f];
}

- (void)setupPopSource {
    CGFloat btnH = CGRectGetHeight(self.cancelBtn.bounds);
    self.bgViewH.constant = btnH * (self.popSource.count + 1) + 10;
    self.cancelBtn.tag = self.popSource.count;
    for (NSInteger i = 0; i < self.popSource.count; i ++) {
        SeparateLineButton *sepBtn = [SeparateLineButton buttonWithType:UIButtonTypeCustom];
        [sepBtn setTitle:self.popSource[i] forState:UIControlStateNormal];
        [sepBtn setTitleColor:HexColor(0x1F1F1F) forState:UIControlStateNormal];
        sepBtn.frame = CGRectMake(0, btnH * i, CGRectGetWidth(self.view.bounds), btnH);
        sepBtn.backgroundColor = [UIColor whiteColor];
        [self.containerView addSubview:sepBtn];
        [sepBtn addTarget:self action:@selector(touchCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        sepBtn.tag = i;
        if (i == 0) {
            [sepBtn setupLineStyle:SeparateLineStyle_TopHidden];
        } else if (i == (self.popSource.count - 1)) {
            [sepBtn setupLineStyle:SeparateLineStyle_BottomHidden];
        } else {
            [sepBtn setupLineStyle:SeparateLineStyle_Normal];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
