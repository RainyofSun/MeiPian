//
//  MPCorpusViewModel.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/18.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPCorpusViewModel.h"
#import "MPCorpusView.h"

@implementation MPCorpusViewModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
// 加载主界面
- (void)loadCorpusMainView:(UIViewController *)vc {
    vc.view.backgroundColor = [UIColor clearColor];
    MPCorpusView *corpusView = [[[NSBundle mainBundle] loadNibNamed:@"MPCorpusView" owner:nil options:nil] firstObject];
    [vc.view addSubview:corpusView];
    [corpusView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    [corpusView closeBtnRotatingAnimation];
    [corpusView corpusSpringAnimation];
}

// 主界面按钮点击逻辑
- (void)mainViewBtnLogic:(UIViewController *)vc senderTag:(NSNumber *)senderTag {
    switch (senderTag.integerValue) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            [vc dismissViewControllerAnimated:YES completion:nil];
            break;
        default:
            break;
    }
}

@end
