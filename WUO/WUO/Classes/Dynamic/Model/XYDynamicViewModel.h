//
//  XYDynamicViewModel.h
//  WUO
//
//  Created by mofeini on 17/1/3.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYDynamicInfo.h"
#import "XYDynamicItem.h"

@interface XYDynamicViewModel : NSObject

@property (nonatomic, strong) XYDynamicInfo *info;
@property (nonatomic, strong) XYDynamicItem *item;

+ (instancetype)dynamicViewModelWithItem:(XYDynamicItem *)item info:(XYDynamicInfo *)info;
@end
