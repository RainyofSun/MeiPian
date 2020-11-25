//
//  MPRequestInterence.h
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/9.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#ifndef MPRequestInterence_h
#define MPRequestInterence_h

#pragma mark - H5与原生定义方法名
#define SEL_NAME_POST_MSG   @"postQuery"
#define HostURL             @"https://api.meipian.me/"
#define ArticleURL(maskId)  [NSString stringWithFormat:@"https://www.meipian.cn/%@?from=appviewrcmd",maskId]

#endif /* MPRequestInterence_h */
