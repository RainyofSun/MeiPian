//
//  MPPDFFatherViewController.m
//  MeiPian
//
//  Created by MP_BMAC on 2020/2/19.
//  Copyright © 2020 MP_BMAC. All rights reserved.
//

#import "MPPDFFatherViewController.h"
#import "MPPDFViewController.h"

@interface MPPDFFatherViewController ()

/** downLoadPdfUrl */
@property (nonatomic,strong) NSDictionary *downLoadPDFInfo;

@end

@implementation MPPDFFatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addPdfVC];
}

#pragma mark - 消息传递
- (void)modulesSendMsg:(id)params {
    if ([params isKindOfClass:[NSDictionary class]]) {
        self.title = [params objectForKey:@"title"];
        self.downLoadPDFInfo = (NSDictionary *)params;
    }
}

- (void)addPdfVC {
    MPPDFViewController *pdfVC = (MPPDFViewController *)[MPModulesMsgSend sendMsg:self.downLoadPDFInfo vcName:@"MPPDFViewController"];
    pdfVC.view.frame = self.view.frame;
    [self.view addSubview:pdfVC.view];
    [self addChildViewController:pdfVC];
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
