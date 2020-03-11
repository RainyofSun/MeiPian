//
//  MPPDFViewController.m
//  MeiPian
//
//  Created by 刘冉 on 2019/9/28.
//  Copyright © 2019 EGLS_BMAC. All rights reserved.
// http://econtract.gateway.test.fcd77.com/sign/lookContract?url=/nfs_data/sign/borrowSign/aixin/AIXIN-CNLN-OFQ149628749411816448.pdf

#import "MPPDFViewController.h"
#import "MPPDFViewModel.h"

@interface QLPreviewItemCustom : NSObject<QLPreviewItem>

@property (nonatomic,readwrite) NSURL * previewItemURL;

@property (nonatomic,readwrite) NSString * previewItemTitle;

@end

@implementation QLPreviewItemCustom

@end

@interface MPPDFViewController ()<QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@property (nonatomic,strong) NSString *filePath;
/** pageTitle */
@property (nonatomic,strong) NSString *pageTitle;
/** pdfVM */
@property (nonatomic,strong) MPPDFViewModel *pdfVM;

@end

@implementation MPPDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.dataSource = self;
}

-(void)dealloc {
    NSLog(@"释放了  ----%@ 类",NSStringFromClass(self.class));
}

- (void)modulesSendMsg:(id)params {
    if ([params isKindOfClass:[NSDictionary class]]) {
        self.pageTitle = [params objectForKey:@"title"];
        [self downLoadPdfFile:[params objectForKey:@"url"]];
    }
}

- (void)downLoadPdfFile:(NSString *)fileUrl {
    WeakSelf;
    [self.pdfVM downLoadPdfFile:fileUrl];
    self.pdfVM.Complete = ^(NSString * _Nonnull localFilePath) {
        weakSelf.filePath = localFilePath;
        [weakSelf refreshCurrentPreviewItem];
    };
}

#pragma mark - QLPreviewControllerDelegate
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
  return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    QLPreviewItemCustom * previewItem = [QLPreviewItemCustom new];
    previewItem.previewItemTitle = self.pageTitle;
    if (self.filePath.length) {
      previewItem.previewItemURL = [NSURL fileURLWithPath:self.filePath];
    }
    return previewItem;
}

- (void)previewControllerDidDismiss:(QLPreviewController *)controller {
    [self.pdfVM removeLoalPDFFile:self.filePath];
}

#pragma mark - setter
- (MPPDFViewModel *)pdfVM {
    if (!_pdfVM) {
        _pdfVM = [[MPPDFViewModel alloc] init];
    }
    return _pdfVM;
}

- (void)setPageTitle:(NSString *)pageTitle {
    _pageTitle = pageTitle;
    self.title = pageTitle;
}

@end
