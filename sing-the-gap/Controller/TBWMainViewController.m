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
    [self.view bringSubviewToFront:self.audioPlayer.view];
    
    NSLayoutConstraint *verticalAudioplayerConstraint =[NSLayoutConstraint constraintWithItem:self.audioPlayer.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.audioPlayer setVerticalConstraint:verticalAudioplayerConstraint];
    [self.view addConstraint:verticalAudioplayerConstraint];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[audioPlayer]-0-|"
                                                                      options:NSLayoutFormatAlignAllBaseline
                                                                      metrics:nil
                                                                        views:@{@"audioPlayer":self.audioPlayer.view}]];
    
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
