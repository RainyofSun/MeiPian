//
//  MPCorpusViewController.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/18.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPCorpusViewController.h"
#import "MPCorpusViewModel.h"

@interface MPCorpusViewController ()

/** corpusVM */
@property (nonatomic,strong) MPCorpusViewModel *corpusVM;

@end

@implementation MPCorpusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.corpusVM loadCorpusMainView:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self clickCorpusViewBtns:@(4)];
}

#pragma mark - 消息透传
- (void)clickCorpusViewBtns:(NSNumber *)senderTag {
    [self.corpusVM mainViewBtnLogic:self senderTag:senderTag];
}

#pragma mark - lazy
- (MPCorpusViewModel *)corpusVM {
    if (!_corpusVM) {
        _corpusVM = [[MPCorpusViewModel alloc] init];
    }
    return _corpusVM;
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
