//
//  AVPlayerVC.m
//  DemoVideoPlay
//
//  Created by zhangshaoyu on 16/11/9.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "AVPlayerVC.h"

// 导入头文件
#import"SYVideo.h"

@interface AVPlayerVC ()

@property (nonatomic, strong) SYAVPlayer *player;

@end

@implementation AVPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"本地", @"网络"]];
    segment.frame = CGRectMake(0.0, 0.0, 200.0, 44.0);
    [segment addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
}

#pragma mark - 未封装使用

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.player) {
        [self.player releasePlayer];
    }
    NSLog(@"释放了 %@~", self.class);
}

// 按钮播放事件
- (void)playClick:(UISegmentedControl *)button
{
    // 本地文件
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"movie" ofType:@"mp4"];
    // 视频文件
    if (button.selectedSegmentIndex == 1) {
        moviePath = @"http://devimages.apple.com/iphone/samples/bipbop/gear4/prog_index.m3u8";
    }
    
    CGRect rect = CGRectMake(10.0, 10.0, (self.view.bounds.size.width - 10.0 * 2), 200.0);
    self.player = [[SYAVPlayer alloc] initWithFrame:rect];
    [self.view addSubview:self.player];
    self.player.videoUrl = moviePath;
    self.player.videoTitle = @"本地视频";
    self.player.playerView.viewType = SYAVPlayerStatusViewTypeBottom;
//    player.playerView.playerStatusView.scaleButton.hidden = YES;
    SYAVPlayerSelfWeak;
    self.player.scaleClick = ^(BOOL isFullScreen){
        SYAVPlayerDelegate.allowRotation = isFullScreen;
        [SYAVPlayerWeakSelf.navigationController setNavigationBarHidden:isFullScreen animated:YES];
    };
    
}


@end
