//
//  MPBaseViewModel.h
//  YiZhan
//
//  Created by YZ_BMAC on 2020/1/13.
//  Copyright © 2020 YZ_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^_Nullable ReturnValueBlock)(id returnValue);

typedef NS_ENUM(NSInteger, MPLoadingType) {
    MPLoadingType_Normal,//正常加载
    MPLoadingType_Refresh,//下拉刷新
    MPLoadingType_More//上拉加载
};

@interface MPBaseViewModel : NSObject

/** requestIdDict */
@property (nonatomic,strong) NSMutableArray <NSURLSessionDataTask *>*requestTaskArray;
/** pageCount */
@property (nonatomic,assign) NSInteger pageCount;
/** page */
@property (nonatomic,assign) NSInteger page;
/** 首次加载完成 */
@property (nonatomic, assign) BOOL isListDataCompleted;
/** 下拉刷新加载完成 */
@property (nonatomic, assign) BOOL isPullRefreshComplted;
/** 上拉加载 */
@property (nonatomic, assign) BOOL isLoadMoreComplted;
/** 上拉加载没有更多数据 */
@property (nonatomic, assign) BOOL isResetNoMoreData;

@end

NS_ASSUME_NONNULL_END
