//
//  MPBaseModel.m
//  YiZhan
//
//  Created by YZ_BMAC on 2020/1/13.
//  Copyright © 2020 YZ_BMAC. All rights reserved.
//

#import "MPBaseModel.h"

@implementation MPBaseModel

- (void)dealloc {
    NSLog(@"DELLOC : %@",NSStringFromClass(self.class));
}

+(NSMutableArray*)modelArrayWithDictArray:(NSArray*)response{
    if ([response isKindOfClass:[NSArray class]]) {
        NSMutableArray* array = [self mj_objectArrayWithKeyValuesArray:response];
        return array;
    }
    return [NSMutableArray new];
}

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary{
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        return [self mj_objectWithKeyValues:dictionary];
    }
    return [[self alloc] init];
}

+(void)setUpModelClassInArrayWithCotainDict:(NSDictionary *)dict{
    if (dict.allKeys.count == 0) {
        return;
    }
    [self mj_setupObjectClassInArray:^NSDictionary *{
        return dict;
    }];
}

+(NSMutableArray *)modelArrayWithDictArray:(NSArray *)response containDict:(NSDictionary *)dict{
    if (dict == nil) {
        dict = [NSMutableDictionary new];
    }
    [self setUpModelClassInArrayWithCotainDict:dict];
    return [self modelArrayWithDictArray:response];
}

+ (id)modelWithDictionary:(NSDictionary *)dictionary containDict:(NSDictionary *)dict {
    if (dict == nil) {
        dict = [NSMutableDictionary new];
    }
    [self setUpModelClassInArrayWithCotainDict:dict];
    return [self modelWithDictionary:dictionary];
}

- (NSMutableDictionary *)modelKeyValues {
    return [self mj_keyValues];
}

@end
