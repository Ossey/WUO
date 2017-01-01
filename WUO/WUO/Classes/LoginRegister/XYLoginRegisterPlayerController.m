//
//  XYLoginRegisterPlayerController.m
//  WUO
//
//  Created by mofeini on 17/1/1.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYLoginRegisterPlayerController.h"
#import <AVFoundation/AVFoundation.h>
#import "XYLoginController.h"
#import "XYRegisterController.h"

#define btnPadding 10
#define btnMiddleMargin 50
#define btnWidth (CGRectGetWidth(self.view.frame) - btnPadding * 2 - btnMiddleMargin) * 0.5
#define btnHeight 40

@interface XYLoginRegisterPlayerController ()

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation XYLoginRegisterPlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self initObserver];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.topBackgroundView.backgroundColor = [UIColor clearColor];
    self.shadowLineView.backgroundColor = [UIColor clearColor];
}

- (void)setupUI {
    [self setupPlayer];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:kColor(255, 255, 255, 1.0) forState:UIControlStateNormal];
    [registerBtn setBackgroundColor:kColor(0, 0, 0, 0.25)];
    registerBtn.layer.cornerRadius = 5;
    [registerBtn.layer setMasksToBounds:YES];
    [self.view addSubview:registerBtn];
    registerBtn.tag = 1;
    [registerBtn addTarget:self action:@selector(jumpToLoginRegisterVc:) forControlEvents:UIControlEventTouchUpInside];

    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(btnPadding);
        make.height.mas_offset(btnHeight);
        make.bottom.mas_equalTo(self.view).mas_offset(-60);
        make.width.mas_equalTo(btnWidth);
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:kColor(0, 0, 0, 1.0) forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:kColor(230, 230, 230, 0.05)];
    loginBtn.layer.cornerRadius = 5;
    [loginBtn.layer setMasksToBounds:YES];
    [self.view addSubview:loginBtn];
    loginBtn.tag = 2;
    [loginBtn addTarget:self action:@selector(jumpToLoginRegisterVc:) forControlEvents:UIControlEventTouchUpInside];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-btnPadding);
        make.height.mas_offset(btnHeight);
        make.bottom.mas_equalTo(self.view).mas_offset(-60);
        make.width.mas_equalTo(btnWidth);
    }];

    
}

#pragma mark - Event 
- (void)jumpToLoginRegisterVc:(UIButton *)btn {
    
    UIViewController *vc = nil;
    if (btn.tag == 1) {
        vc = [XYRegisterController new];
    } else if (btn.tag == 2) {
        vc = [XYLoginController new];
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)setupPlayer {
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"launch" ofType:@"mp4"]];
    AVAsset *asset = [AVAsset assetWithURL:url];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithAsset:asset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    player.externalPlaybackVideoGravity = AVLayerVideoGravityResizeAspectFill;
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = [UIScreen mainScreen].bounds;
    [self.view.layer addSublayer:playerLayer];
    self.player = player;
}

- (void)initObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerPasue) name:UIApplicationDidEnterBackgroundNotification object:nil];

}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self.player play];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [self.player pause];
}

- (void)playerItemDidReachEnd:(NSNotification *)note {

    [self.player play];
}

- (void)playerPasue {
    
    [self.player pause];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)dealloc {
    
    NSLog(@"%s", __FUNCTION__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
