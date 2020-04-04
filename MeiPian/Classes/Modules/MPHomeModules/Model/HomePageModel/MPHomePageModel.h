//
//  MPHomePageModel.h
//  MeiPian
//
//  Created by 刘冉 on 2020/4/4.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "MPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MPHomePageModel : MPBaseModel

/** pageID */
@property (nonatomic,strong) NSNumber *pageID;
/** icon_img_url */
@property (nonatomic,strong) NSString *icon_img_url;
/** tag_name */
@property (nonatomic,strong) NSString *tag_name;
/** uri */
@property (nonatomic,strong) NSString *uri;
/** fixed */
@property (nonatomic,strong) NSNumber *fixed;

@end

NS_ASSUME_NONNULL_END
