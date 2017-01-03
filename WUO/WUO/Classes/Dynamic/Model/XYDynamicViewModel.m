//
//  XYDynamicViewModel.m
//  WUO
//
//  Created by mofeini on 17/1/3.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYDynamicViewModel.h"

@implementation XYDynamicViewModel

- (instancetype)initWithItem:(XYDynamicItem *)item info:(XYDynamicInfo *)info {
    if (self = [super init]) {
        self.item = item;
        self.info = info;
    }
    
    return self;
}

+ (instancetype)dynamicViewModelWithItem:(XYDynamicItem *)item info:(XYDynamicInfo *)info {
    
    return [[self alloc] initWithItem:item info:info];
}


- (NSURL *)headerImageURL {
    NSString *fullPath = nil;
    if ([self.item.head containsString:@"http://"]) {
        fullPath = self.item.head;
    } else {
        fullPath = [self.info.basePath stringByAppendingString:self.item.head];
    }
    return [NSURL URLWithString:fullPath];
}



@end
