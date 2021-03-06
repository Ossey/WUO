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

/**
 * @explain 动态接口
 *
 * @param   idstamp  此字段是作为请求动态界面的数据参数的，当上拉加载更多时，将本地的idstamp作为下次上拉加载的参数，当下拉刷新时此字段为空
 */
+ (void)dynamicWithIdstamp:(NSString *)idstamp finished:(FinishedCallBack)finishedCallBack;

// 获取登录用户信息模型
+ (XYLoginInfoItem *)userLoginInfoItem;
@end
