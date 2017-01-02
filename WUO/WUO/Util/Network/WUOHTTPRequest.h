//
//  WUOHTTPRequest.h
//  WUO
//
//  Created by mofeini on 17/1/2.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYNetworkRequest.h"

@class XYNetworkRequest, XYLoginInfoItem;
@interface WUOHTTPRequest : NSObject

+ (instancetype)shareInstance;

// 开启菊花
+ (void)setActivityIndicator:(BOOL)enabled;

// 登录接口
+ (void)loginWithAccount:(NSString *)account pwd:(NSString *)pwd finished:(FinishedCallBack)finishedCallBack;

// 动态接口
+ (void)dynamicFinished:(FinishedCallBack)finishedCallBack;

// 获取登录用户信息模型
+ (XYLoginInfoItem *)userLoginInfoItem;
@end
