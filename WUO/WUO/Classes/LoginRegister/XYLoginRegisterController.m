//
//  XYLoginRegisterController.m
//  WUO
//
//  Created by mofeini on 17/1/2.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYLoginRegisterController.h"

@interface XYLoginRegisterController ()

@end

@implementation XYLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topBackgroundView.backgroundColor = [UIColor clearColor];
    self.shadowLineView.backgroundColor = [UIColor clearColor];
    
    [self xy_setBackBarTitle:nil titleColor:nil image:[UIImage imageNamed:@"Login_backSel"] forState:UIControlStateNormal];
    
}



@end
