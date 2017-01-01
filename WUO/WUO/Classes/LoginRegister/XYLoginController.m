//
//  XYLoginController.m
//  WUO
//
//  Created by mofeini on 17/1/1.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYLoginController.h"
#import "XYNetworkRequest.h"


@interface XYLoginController ()

@end

@implementation XYLoginController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loginAccount];
    
}

- (void)setupUI {
    
    self.xy_title = @"登录";
}

- (void)loginAccount {

    // 登录接口
    NSString *urlStr = @"http://me.api.kfit.com.cn/me-api/rest/api/userInfo/login";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"123" forKey:@"deviceToken"];
    [parameters setValue:@"18810181988" forKey:@"loginAccount"];
    [parameters setValue:@"iOS" forKey:@"os"];
    [parameters setValue:@"4.2.2" forKey:@"osVersion"];
    [parameters setValue:@"iPhone 6 (A1549/A1586)" forKey:@"phoneModel"];
    [parameters setValue:@"4CD0C8A7131993B397DC44EB5AD60BE7" forKey:@"pwd"];
    [parameters setValue:@"1.73" forKey:@"versionCode"];
    
    [[XYNetworkRequest shareInstance] request:XYNetworkRequestTypePOST url:urlStr parameters:parameters progress:nil finished:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        
        NSLog(@"%@", responseObject);
    }];

}

@end
