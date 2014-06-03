//
//  TBWAudioPlayerViewController.m
//  sing-the-gap
//
//  Created by mariachi on 03/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWAudioPlayerViewController.h"
#import "TBWAudioPlayerConstants.h"



@interface TBWAudioPlayerViewController ()

@end

@implementation TBWAudioPlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receivePlayNotification:)
                                                     name:TBWAudioPlayerPlayNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receivePauseNotification:)
                                                     name:TBWAudioPlayerPauseNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveCloseNotification:)
                                                     name:TBWAudioPlayerCloseNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveHideNotification:)
                                                     name:TBWAudioPlayerHideNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveOpenNotification:)
                                                     name:TBWAudioPlayerOpenNotification
                                                   object:nil];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Life Cycle
////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
////////////////////////////////////////////////////////////////////////
#pragma mark - Notification Handling
////////////////////////////////////////////////////////////////////////

- (void) receivePlayNotification:(NSNotification *) notification
{
    NSString *contentUrl = [notification.userInfo objectForKey:@"contentUrl"];
    [self play];
}
- (void) receivePauseNotification:(NSNotification *) notification
{
    [self pause];
}

- (void) receiveCloseNotification:(NSNotification *) notification
{
    [self pause];
}
- (void) receiveHideNotification:(NSNotification *) notification
{
    [self pause];
}
- (void) receiveOpenNotification:(NSNotification *) notification
{
    [self pause];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Player
////////////////////////////////////////////////////////////////////////

- (void)play{
    
}
-(void)pause{
    
}
- (void)open{
    
}
- (void)close{

}
- (void)hide{
    
}


@end
