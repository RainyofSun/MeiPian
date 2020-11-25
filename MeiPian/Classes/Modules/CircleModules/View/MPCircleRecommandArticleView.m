//
//  MPCircleRecommandArticleView.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/4/8.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPCircleRecommandArticleView.h"
#import "MPRecommandCollectionViewCell.h"
#import "MPCircleRecommandViewModel.h"

static NSString *CircleRecommandCell    = @"recommmandArticleCell";

@interface MPCircleRecommandArticleView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

/** recommandVM */
@property (nonatomic,strong) MPCircleRecommandViewModel *recommandVM;
/** recommandSource */
@property (nonatomic,strong) NSArray <MPCircleRecommandModel *>*recommandSource;
/** recommandH */
@property (nonatomic,assign,readwrite) CGFloat recommandH;
/** collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation MPCircleRecommandArticleView

- (instancetype)init {
    if (self = [super init]) {
        self.recommandH = 130;
        [self setupUI];
        [self requestRecommandData];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - UICollectionViewDelegateFlowLayout & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.recommandSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MPRecommandCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CircleRecommandCell forIndexPath:indexPath];
    [cell loadRecommandCellSource:self.recommandSource[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [MPModulesMsgSend sendCumtomMethodMsg:[self nearsetViewController] methodName:@selector(selectedRecommandArticle:) params:[NSNumber numberWithInteger:indexPath.item]];
}

#pragma mark - private methods
- (void)setupUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(80, self.recommandH);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 8;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 15);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MPRecommandCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CircleRecommandCell];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self addSubview:self.collectionView];
}

- (void)requestRecommandData {
    WeakSelf;
    [self.recommandVM MPCircleRecommandInfo:^(id  _Nonnull returnValue) {
        weakSelf.recommandSource = (NSArray <MPCircleRecommandModel *>*)returnValue;
        [weakSelf.collectionView reloadData];
    }];
}

#pragma mark - public methods
- (MPCircleRecommandViewModel *)recommandVM {
    if (!_recommandVM) {
        _recommandVM = [[MPCircleRecommandViewModel alloc] init];
    }
    return _recommandVM;
}

@end
