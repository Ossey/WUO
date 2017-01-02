//
//  XYLoginRegisterController.m
//  WUO
//
//  Created by mofeini on 17/1/2.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYLoginRegisterController.h"
#import "XYNetworkRequest.h"
#import "XYThirdPartyLoginView.h"
#import "XYLoginView.h"

#define loginViewHeight 220
#define registerViewHeight 250


@interface XYLoginRegisterController () <UIScrollViewDelegate>

@property (nonatomic, assign) XYLoginRegisterType type;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) XYThirdPartyLoginView *thirdPartyLoginView;
@property (nonatomic, strong) XYLoginView *loginView;
@end

@implementation XYLoginRegisterController

- (instancetype)initWithType:(XYLoginRegisterType)type {
    
    if (self = [super init]) {
        
        self.type = type;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {

    [self setupNavBar];

    [self.thirdPartyLoginView setThirdPartyLoginBlock:^(XYThirdPartyLoginType type) {
        NSLog(@"%ld", type);
    }];
    
    if (_type == XYLoginRegisterTypeRegister) {
        
        self.xy_title = @"注册";
        
    } else if (XYLoginRegisterTypeLogin) {
        self.xy_title = @"登录";
        
        self.loginView.hidden = NO;
    }
}

- (void)setupNavBar {
    
    self.topBackgroundView.backgroundColor = [UIColor clearColor];
    self.shadowLineView.backgroundColor = [UIColor whiteColor];
    
    [self xy_setBackBarTitle:nil titleColor:nil image:[UIImage imageNamed:@"Login_backSel"] forState:UIControlStateNormal];

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

- (UIScrollView *)scrollView {
    
    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(0, CGRectGetHeight(self.view.frame) + 10);
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
    }
    
    return _scrollView;
}

- (XYThirdPartyLoginView *)thirdPartyLoginView {
    
    if (_thirdPartyLoginView == nil) {
        _thirdPartyLoginView = [XYThirdPartyLoginView xy_viewFromXib];
        _thirdPartyLoginView.frame = CGRectMake(0, loginViewHeight + kNavigationBarHeight, CGRectGetWidth(self.scrollView.frame), 80);
        [self.scrollView addSubview:_thirdPartyLoginView];
    }
    
    return _thirdPartyLoginView;
}

- (XYLoginView *)loginView {
    
    if (_loginView == nil) {
        
        _loginView = [XYLoginView xy_viewFromXib];
        _loginView.frame = CGRectMake(0, kNavigationBarHeight, CGRectGetWidth(self.scrollView.frame), loginViewHeight);
        [self.scrollView addSubview:_loginView];
    }
    
    return _loginView;
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
}


@end
