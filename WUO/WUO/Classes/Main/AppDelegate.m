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

@interface AppDelegate () 

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    id isLogin = [[NSUserDefaults standardUserDefaults] objectForKey:XYUserLoginStatuKey];
    self->_isLogin = [isLogin integerValue];
    
    
    UIViewController *rootVc = nil;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    if (_isLogin) {
        MainTabBarController *mainVc = [MainTabBarController new];
        rootVc = mainVc;
    } else {
        XYLaunchPlayerController *playerVc = [XYLaunchPlayerController new];
        XYCustomNavController *customNav = [[XYCustomNavController alloc] initWithRootViewController:playerVc];
        rootVc = customNav;
    }
    self.window.rootViewController = rootVc;
    [self.window makeKeyAndVisible];
    
    return YES;
}




@end
