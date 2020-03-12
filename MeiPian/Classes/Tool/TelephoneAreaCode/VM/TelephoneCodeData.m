//
//  TelephoneCodeData.m
//  MeiPian
//
//  Created by EGLS_BMAC on 2020/3/12.
//  Copyright © 2020 EGLS_BMAC. All rights reserved.
//

#import "TelephoneCodeData.h"

@implementation TelephoneCodeData

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

#pragma mark - public methods
+ (NSArray<NSArray *> *)countryCodeSource {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CountryPhoneCode" ofType:@"plist"];
    NSArray *codeSource = [NSArray arrayWithContentsOfFile:plistPath];
    NSLog(@"%@",codeSource);
    return codeSource;
}

+ (NSArray<NSString *> *)countryCodeIndexes {
    return @[@"常用",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z"];
}
@end
