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
    self.worksView.frame = CGRectMake(cellW, 0, cellW, cellH);
    self.collectionView.frame = CGRectMake(cellW * 2, 0, cellW, cellH);
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
    NSLog(@"Cell0 H %f",self.artcileViewH);
}

- (void)resetSubScrollViewContentOffSet:(NSNumber *)senderTag {
    self.artcileViewH = [self.cellVM articlrViewH:senderTag.integerValue];
    NSLog(@"按钮切换 H %f",self.artcileViewH);
    [self.mainScrollView setContentOffset:CGPointMake(ScreenWidth * senderTag.integerValue, 0) animated:YES];
}

- (MPBaseTableView *)getArticleCellTableView {
    return self.articleView.articleListView;
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
    NSInteger tag = scrollView.contentOffset.x / ScreenWidth;
    self.artcileViewH = [self.cellVM articlrViewH:tag];
    NSLog(@"滑动切换 H %f",self.artcileViewH);
    [MPModulesMsgSend sendCumtomMethodMsg:self.superview.superview methodName:@selector(switchSliderBar:) params:[NSNumber numberWithInteger:tag]];
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
    [self.mainScrollView addSubview:self.worksView];
    [self.mainScrollView addSubview:self.collectionView];
    
    self.artcileViewH = 600;
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
