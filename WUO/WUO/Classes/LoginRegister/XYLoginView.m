//
//  XYLoginView.m
//  WUO
//
//  Created by mofeini on 17/1/2.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYLoginView.h"

@interface XYLoginView ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation XYLoginView

+ (instancetype)xy_viewFromXib {
    
    return [[NSBundle mainBundle] loadNibNamed:@"XYLoginRegisterView" owner:nil options:nil][1];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.loginBtn.layer.cornerRadius = 5;
    [self.loginBtn.layer setMasksToBounds:YES];
}


- (IBAction)loginBtnClick:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginView:loginAccount:)]) {
        [self.delegate loginView:self loginAccount:sender];
    }
}

- (IBAction)forgetPwd:(id)sender {
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(loginView:forgetPwd:)]) {
        [self.delegate loginView:self forgetPwd:sender];
    }
}

@end
