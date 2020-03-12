//
//  TelephoneCodeData.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/12.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TelephoneCodeData : NSObject

+ (NSArray <NSArray *>*)countryCodeSource;
+ (NSArray <NSString *>*)countryCodeIndexes;

@end

NS_ASSUME_NONNULL_END
