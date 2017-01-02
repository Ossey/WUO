//
//  XYLaunchPlayerController.m
//  WUO
//
//  Created by mofeini on 17/1/1.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "XYLaunchPlayerController.h"
#import <AVFoundation/AVFoundation.h>
#import "XYLoginController.h"
#import "XYRegisterController.h"
#import "XYLaunchView.h"

#define btnPadding 10
#define btnMiddleMargin 50
#define btnWidth (CGRectGetWidth(self.view.frame) - btnPadding * 2 - btnMiddleMargin) * 0.5
#define btnHeight 40

@interface XYLaunchPlayerController ()

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation XYLaunchPlayerController

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
    __weak typeof(self) weakSelf = self;
    [XYLaunchView launchView:self.view loginRegisterCallBack:^(XYLaunchViewType type) {
        
        UIViewController *vc = nil;
        if (type == XYLaunchViewTypeRegister) {
            vc = [XYRegisterController new];
        } else if (type == XYLaunchViewTypeLogin) {
            vc = [XYLoginController new];
        }
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
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
