//
//  TelephoneCodeIndexView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/12.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "TelephoneCodeIndexView.h"

@interface TelephoneCodeIndexView ()

/** indexSource */
@property (nonatomic,strong) NSMutableArray <NSString *>*indexSource;

@end

@implementation TelephoneCodeIndexView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - publc methods
// 加载索引数据
- (void)loadIndexSource:(NSArray *)indexSource {
    self.indexSource = [NSMutableArray arrayWithArray:indexSource];
    [self.indexSource replaceObjectAtIndex:0 withObject:@"⭐️"];
    [self setupIndexBtn];
}

#pragma mark - private methods
- (void)setupIndexBtn {
    CGFloat distance = 6;
    for (NSInteger i = 0; i < self.indexSource.count; i ++) {
        UIButton *indexBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        indexBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [indexBtn setTitle:self.indexSource[i] forState:UIControlStateNormal];
        [indexBtn setTitleColor:[UIColor colorWithRed:61/255.0 green:81/255.0 blue:130/255.0 alpha:1] forState:UIControlStateNormal];
        [indexBtn addTarget:self action:@selector(selectIndex:) forControlEvents:UIControlEventTouchUpInside];
        indexBtn.frame = CGRectMake(0, (distance + 20) * i, CGRectGetWidth(self.bounds), 20);
        indexBtn.tag = i;
        [self addSubview:indexBtn];
    }
}

- (void)selectIndex:(UIButton *)sender {
    if (self.alphabetIndexDelegate != nil && [self.alphabetIndexDelegate respondsToSelector:@selector(didSelectedAlphabetIndex:)]) {
        [self.alphabetIndexDelegate didSelectedAlphabetIndex:sender.tag];
    }
}

@end
