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

@interface MPBaseViewModel : NSObject

/** requestIdDict */
@property (nonatomic,strong) NSMutableArray <NSURLSessionDataTask *>*requestTaskArray;

@end

NS_ASSUME_NONNULL_END
