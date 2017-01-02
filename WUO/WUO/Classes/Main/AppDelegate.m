//
//  AppDelegate.m
//  WUO
//
//  Created by mofeini on 17/1/1.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "XYLaunchPlayerController.h"
#import "XYCustomNavController.h"
#import "WUOHTTPRequest.h"

@interface AppDelegate () 

@property (nonatomic, strong) MainTabBarController *mainVc;
@property (nonatomic, strong) XYCustomNavController *customNav;

@end

@implementation AppDelegate

@synthesize isLogin = _isLogin;

- (MainTabBarController *)mainVc {
    if (_mainVc == nil) {
        _mainVc = [MainTabBarController new];
    }
    return _mainVc;
}

- (XYCustomNavController *)customNav {
    if (_customNav == nil) {
        XYLaunchPlayerController *playerVc = [XYLaunchPlayerController new];
        _customNav = [[XYCustomNavController alloc] initWithRootViewController:playerVc];
    }
    
    return _customNav;
}

- (BOOL)isLogin {
    
    id isLogin = [[NSUserDefaults standardUserDefaults] objectForKey:XYUserLoginStatuKey];
    
    if ([isLogin integerValue] == 0) {
        _isLogin = YES;
    } else if ([isLogin integerValue] == -2) {
        _isLogin = NO;
    }
    return _isLogin;
}

- (void)setIsLogin:(BOOL)isLogin {
    _isLogin = isLogin;
    
    if (_isLogin) {
        
        self.window.rootViewController = self.mainVc;
    } else {
        
        self.window.rootViewController = self.customNav;
    }
    
}


- (UIViewController *)getRootVc {
    
    if (self.isLogin) {
        
         return self.mainVc;
    } else {
        
        return self.customNav;
    }
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [self getRootVc];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [WUOHTTPRequest setActivityIndicator:YES];
    [WUOHTTPRequest dynamicWithIdstamp:@"" finished:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        [WUOHTTPRequest setActivityIndicator:NO];
        NSInteger code = [responseObject[@"code"] integerValue];;
        if (code == -2) {
            
            [self showInfo:[NSString stringWithFormat:@"您的账号已于%@在其他设备上登录，如果不是您的操作，您的密码可能已经泄露，请立刻重新登录后修改密码", @"(刚刚)"]];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 用户没有登录
                self.isLogin = NO;
            });
        }
        
    }];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
   
    
}


@end
