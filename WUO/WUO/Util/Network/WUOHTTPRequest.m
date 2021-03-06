//
//  WUOHTTPRequest.m
//  WUO
//
//  Created by mofeini on 17/1/2.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "WUOHTTPRequest.h"
#import "XYLoginInfoItem.h"

//#import <AFNetworkActivityIndicatorManager.h>

@implementation WUOHTTPRequest

static id _instance;

+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

+ (void)setActivityIndicator:(BOOL)enabled {
    
//    [AFNetworkActivityIndicatorManager sharedManager].enabled = enabled;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = enabled;
}

// 登录接口
+ (void)loginWithAccount:(NSString *)account pwd:(NSString *)pwd finished:(FinishedCallBack)finishedCallBack {
    
    // 登录接口
    NSString *urlStr = @"http://me.api.kfit.com.cn/me-api/rest/api/userInfo/login";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"123" forKey:@"deviceToken"];
    [parameters setValue:account forKey:@"loginAccount"];
    [parameters setValue:@"iOS" forKey:@"os"];
    [parameters setValue:@"4.2.2" forKey:@"osVersion"];
    [parameters setValue:@"iPhone 6 (A1549/A1586)" forKey:@"phoneModel"];
    // 密码采用md5加密，未加盐
    NSString *pwdMD5 = [pwd MD5].uppercaseString;
    [parameters setValue:pwdMD5 forKey:@"pwd"];
    [parameters setValue:@"1.73" forKey:@"versionCode"];
    
    [[XYNetworkRequest shareInstance] request:XYNetworkRequestTypePOST url:urlStr parameters:parameters progress:nil finished:finishedCallBack];
    
}

// 动态接口
+ (void)dynamicWithIdstamp:(NSString *)idstamp finished:(FinishedCallBack)finishedCallBack {
    
    XYLoginInfoItem *loginInfoItem = [WUOHTTPRequest userLoginInfoItem];
    // 设置请求头部
    [[XYNetworkRequest shareInstance].manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld", loginInfoItem.userInfo.uid] forHTTPHeaderField:@"uid"];
    [[XYNetworkRequest shareInstance].manager.requestSerializer setValue:loginInfoItem.userInfo.token forHTTPHeaderField:@"token"];
    
    NSString *urlStr = @"http://me.api.kfit.com.cn/me-api/rest/api/trend/getAll";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:idstamp forKey:@"idstamp"];
    [parameters setValue:@15 forKey:@"pageNum"];
    [parameters setValue:@1 forKey:@"type"];
    
    [[XYNetworkRequest shareInstance] request:XYNetworkRequestTypePOST url:urlStr parameters:parameters progress:nil finished:finishedCallBack];
}

// 获取用户登录的信息，并转换为模型
+ (XYLoginInfoItem *)userLoginInfoItem {
    
    NSDictionary *loginInfoDict = [NSDictionary dictionaryWithContentsOfFile:kLoginInfoPath];
    
    return [XYLoginInfoItem loginInfoItemWithDict:loginInfoDict];
}

@end
