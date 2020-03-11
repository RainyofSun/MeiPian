//
//  MPBasePopViewController.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/11.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBasePopViewController.h"

@interface MPBasePopViewController ()

@end

@implementation MPBasePopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)showWithPresentVC:(UIViewController*)presentVC CompletionBlock:(void (^)(NSInteger buttonIndex))completionBlock {
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    if ([[UIApplication topMostController] isKindOfClass:[self class]]) {
        NSLog(@"拦截二次alert 弹窗");
        return;
    }
    [presentVC presentViewController:self animated:NO completion:nil];
    _completeBlock  = completionBlock;
}

-(void)dismissViewController:(void (^)(void))completion {
    [self dismissViewControllerAnimated:NO completion:completion];
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
