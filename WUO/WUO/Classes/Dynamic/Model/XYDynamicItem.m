//
//  XYDynamicItem.m
//  WUO
//
//  Created by mofeini on 17/1/3.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYDynamicItem.h"
#import "XYDynamicInfo.h"

@implementation XYDynamicItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}
+ (instancetype)dynamicItemWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (NSURL *)headerImageURL {
    
    return [self.dynamicInfo.basePath stringByAppendingString:self.head];
}

@end
