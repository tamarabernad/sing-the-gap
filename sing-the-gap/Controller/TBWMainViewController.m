//
//  TBWMainViewController.m
//  sing-the-gap
//
//  Created by Tamara Bernad on 8/9/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWMainViewController.h"
#import "TBWAudioPlayerViewController.h"
#import "TBWHomeViewController.h"
@interface TBWMainViewController ()

@property (nonatomic, strong) TBWAudioPlayerViewController *audioPlayer;
@end

@implementation TBWMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TBWHomeViewController *hvc = [[TBWHomeViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:hvc];
    [nc setNavigationBarHidden:YES];
    
    [nc willMoveToParentViewController:self];
    [self.view addSubview:nc.view];
    [self addChildViewController:nc];
    [nc didMoveToParentViewController:self];
    
    self.audioPlayer = [[TBWAudioPlayerViewController alloc] init];
    [self.audioPlayer willMoveToParentViewController:self];
    [self addChildViewController:self.audioPlayer];
    [self.view addSubview:self.audioPlayer.view];
    [self.audioPlayer didMoveToParentViewController:self];
//    [self.audioPlayer.view setFrame:CGRectMake(0, 0, self.audioPlayer.view.frame.size.width, self.audioPlayer.view.frame.size.height)];
    [self.view bringSubviewToFront:self.audioPlayer.view];
    id metrics = @{@"margin": @0};

    
//    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    

    
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[audioPlayer(100)]"
//                                                                      options:0
//                                                                      metrics:metrics
//                                                                        views:@{@"audioPlayer":self.audioPlayer.view}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[audioPlayer]"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:@{@"audioPlayer":self.audioPlayer.view}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[audioPlayer]-0-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:@{@"audioPlayer":self.audioPlayer.view}]];

//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[audioPlayer]-|"
//                                                                      options:0
//                                                                      metrics:metrics
//                                                                        views:@{@"audioPlayer":self.audioPlayer.view}]];
//    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[audioPlayer(122)]"
//                                                                      options:0
//                                                                      metrics:metrics
//                                                                        views:@{@"audioPlayer":self.audioPlayer.view}]];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[audioPlayer]-0-|" options:0 metrics:metrics views:@{@"audioPlayer":self.audioPlayer.view}]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
