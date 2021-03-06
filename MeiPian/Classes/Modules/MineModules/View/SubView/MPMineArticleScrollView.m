//
//  MPMineArticleScrollView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/17.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPMineArticleScrollView.h"
#import "MPArticleCellViewModel.h"
#import "MPMineArticleView.h"
#import "MPMineWorksView.h"
#import "MPMineCollectionView.h"

@interface MPMineArticleScrollView ()<UIScrollViewDelegate>

/** cellVM */
@property (nonatomic,strong) MPArticleCellViewModel *cellVM;
/** mainScrollView */
@property (nonatomic,strong) UIScrollView *mainScrollView;
/** articleView */
@property (nonatomic,strong) MPMineArticleView *articleView;
/** worksView */
@property (nonatomic,strong) MPMineWorksView *worksView;
/** collectionView */
@property (nonatomic,strong) MPMineCollectionView *collectionView;
/** artcileViewH */
@property (nonatomic,readwrite) CGFloat artcileViewH;
/** selectedIndex */
@property (nonatomic,assign) NSInteger selectedIndex;

@end

@implementation MPMineArticleScrollView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat cellW = CGRectGetWidth(self.bounds);
    CGFloat cellH = CGRectGetHeight(self.bounds);
    [self.mainScrollView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    self.articleView.frame = CGRectMake(0, 0, cellW, cellH);
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
- (void)loadMineArticleSource:(MPMineArticleModel *)articleSource {
    self.cellVM.articleModel = articleSource;
    [self.articleView loadArticleSource:self.cellVM.articleModel.articles];
}

- (void)loadMineArticleHeightSource:(NSArray<NSNumber *> *)articleHeightSource {
    self.cellVM.articleHeightSource = articleHeightSource;
    self.artcileViewH = [self.cellVM articlrViewH:0];
}

- (void)resetSubScrollViewContentOffSet:(NSNumber *)senderTag {
    self.selectedIndex = senderTag.integerValue;
    self.artcileViewH = [self.cellVM articlrViewH:senderTag.integerValue];
    switch (senderTag.integerValue) {
        case 0:
            break;
        case 1:
            if (!_worksView) {
                [self.mainScrollView addSubview:self.worksView];
                self.worksView.frame = CGRectMake(CGRectGetWidth(self.bounds) * senderTag.integerValue, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
            }
            break;
        case 2:
            if (!_collectionView) {
                [self.mainScrollView addSubview:self.collectionView];
                self.collectionView.frame = CGRectMake(CGRectGetWidth(self.bounds) * senderTag.integerValue, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
            }
            break;
        default:
            break;
    }
    [self.mainScrollView setContentOffset:CGPointMake(ScreenWidth * senderTag.integerValue, 0) animated:YES];
}

- (MPBaseTableView *)getArticleCellTableView {
    switch (self.selectedIndex) {
        case 0:
            return self.articleView.articleListView;
        case 1:
            return self.worksView.worksListView;
        case 2:
            return [self.collectionView mineCollectionSubTabView];
        default:
            return nil;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

/**
*  滚动完毕就会调用（如果不是人为拖拽scrollView导致滚动完毕，才会调用这个方法）
*/
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    FLOG(@"不是人为拖拽scrollView导致滚动完毕");
    
}

/**
 *  滚动完毕就会调用（如果是人为拖拽scrollView导致滚动完毕，才会调用这个方法）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    FLOG(@"人为拖拽scrollView导致滚动完毕");
    self.selectedIndex = scrollView.contentOffset.x / ScreenWidth;
    self.artcileViewH = [self.cellVM articlrViewH:self.selectedIndex];
    [MPModulesMsgSend sendCumtomMethodMsg:self.superview.superview methodName:@selector(switchSliderBar:) params:[NSNumber numberWithInteger:self.selectedIndex]];
}

#pragma mark - private methods
- (void)setupUI {
    if (@available(iOS 11.0, *)) {
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    self.mainScrollView = [[UIScrollView alloc] init];
    self.mainScrollView.backgroundColor = RGB(242, 244, 249);
    self.mainScrollView.delegate = self;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth * 3, 0);
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.bounces = NO;
    [self addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.articleView];
    
    self.artcileViewH = ScreenHeight - kNavAndTabHeight - 50;
    self.selectedIndex = 0;
}

#pragma mark - lazy
- (MPArticleCellViewModel *)cellVM {
    if (!_cellVM) {
        _cellVM = [[MPArticleCellViewModel alloc] init];
    }
    return _cellVM;
}

- (MPMineArticleView *)articleView {
    if (!_articleView) {
        _articleView = [[MPMineArticleView alloc] init];
    }
    return _articleView;
}

- (MPMineWorksView *)worksView {
    if (!_worksView) {
        _worksView = [[MPMineWorksView alloc] init];
    }
    return _worksView;
}

- (MPMineCollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[MPMineCollectionView alloc] init];
    }
    return _collectionView;
}

@end
