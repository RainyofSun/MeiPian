//
//  MPRecommandView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/19.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPRecommandView.h"
#import "MPPageControlSliderBar.h"

@interface MPRecommandView ()

/** topBar */
@property (nonatomic,strong) MPPageControlSliderBar *topBar;
/** titleArray */
@property (nonatomic,strong) NSArray <NSString *>*titleArray;

@end

@implementation MPRecommandView

- (instancetype)init {
    if (self = [super init]) {
        [self setDefaultData];
        [self setupUI];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - 消息透传
- (void)switchTopSliderBarItem:(NSNumber *)senderTag {
    FLOG(@"切换到 %@",self.titleArray[senderTag.integerValue]);
    [MPNetRequestManager MPNetRequestType:AFNRequestType_Post requestUrl:@"https://api.meipian.me/5.5/selectedChannel/list" requestParams:@{@"guest_id":@"429-45128",@"user_id":@"1000",@"token":@"guest",@"page":@(4)} success:^(NSURLSessionDataTask * _Nullable task, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        NSLog(@"ERROR %@",error.localizedDescription);
    }];
}

#pragma mark - private methods
- (void)setDefaultData {
    self.titleArray = @[@"全部",@"精选",@"摄影",@"情感",@"文学",@"旅行"];
}

- (void)setupUI {
    self.backgroundColor = MAIN_LIGHT_GRAY_COLOR;
    [self addSubview:self.topBar];
    [self.topBar loadSliderBarTitleSource:self.titleArray];
}

#pragma mark - lazy
- (MPPageControlSliderBar *)topBar {
    if (!_topBar) {
        _topBar = [[MPPageControlSliderBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    }
    return _topBar;
}

@end
