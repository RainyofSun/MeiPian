//
//  MPSheYingArticleTypeView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/6.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPSheYingArticleTypeView.h"

@interface MPSheYingArticleTypeView ()

/** defaultSource */
@property (nonatomic,strong) NSArray <NSString *>*defaultSource;
/** btnSource */
@property (nonatomic,strong) NSMutableArray <UIButton *>*btnSource;

@end

@implementation MPSheYingArticleTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setDefaultData];
        [self setupUI];
    }
    return self;
}

- (void)dealloc {
    for (UIButton *btn in self.btnSource) {
        [btn removeFromSuperview];
    }
    [self.btnSource removeAllObjects];
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

- (void)touchArticleType:(UIButton *)sender {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(selectArticleType:) params:[NSNumber numberWithInteger:sender.tag]];
}

#pragma mark - private methods
- (void)setDefaultData {
    self.defaultSource = @[@"人像印记",@"爱花品茗",@"都市掠影",@"风景名胜",@"摄影达人"];
    self.btnSource = [NSMutableArray arrayWithCapacity:self.defaultSource.count];
}

- (void)setupUI {
    CGFloat distance    = 8;
    CGFloat itemW       = (CGRectGetWidth(self.bounds) - 8 * (self.defaultSource.count - 1))/self.defaultSource.count;
    CGFloat itemH       = CGRectGetHeight(self.bounds);
    NSArray <NSString *>*imgArray = @[@"renXiang",@"aiHua",@"duShi",@"fengJing",@"sheYing"];
    for (NSInteger i = 0; i < self.defaultSource.count; i ++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.frame = CGRectMake((itemW + distance) * i , 0, itemW, itemH);
        [item setTitle:self.defaultSource[i] forState:UIControlStateNormal];
        [item setTitleColor:MAIN_BLACK_COLOR forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
        [self changeButtonImgTopAndTextBottom:8 item:item];
        item.titleLabel.font = [UIFont systemFontOfSize:15];
        [item addTarget:self action:@selector(touchArticleType:) forControlEvents:UIControlEventTouchUpInside];
        item.backgroundColor = [UIColor whiteColor];
        item.tag = i;
        [self addSubview:item];
        [self.btnSource addObject:item];
    }
}

- (void)changeButtonImgTopAndTextBottom:(CGFloat)distance item:(UIButton *)sender {
    CGFloat interval = distance ? distance : 1.0;
    CGSize imageSize = sender.imageView.bounds.size;
    [sender setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + interval, -(imageSize.width), 0, 0)];
    CGSize titleSize = sender.titleLabel.bounds.size;
    [sender setImageEdgeInsets:UIEdgeInsetsMake(0,2, titleSize.height + interval, -(titleSize.width))];
}


@end
