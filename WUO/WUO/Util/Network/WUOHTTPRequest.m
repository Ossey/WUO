//
//  WUOHTTPRequest.m
//  WUO
//
//  Created by mofeini on 17/1/2.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "WUOHTTPRequest.h"
//#import <AFNetworkActivityIndicatorManager.h>

@implementation WUOHTTPRequest

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
    // 注意：密码采用md5加密，未加盐
    NSString *pwdMD5 = [pwd MD5].uppercaseString;
    [parameters setValue:pwdMD5 forKey:@"pwd"];
    [parameters setValue:@"1.73" forKey:@"versionCode"];
    
    [[XYNetworkRequest shareInstance] request:XYNetworkRequestTypePOST url:urlStr parameters:parameters progress:nil finished:finishedCallBack];
    
}

@end
