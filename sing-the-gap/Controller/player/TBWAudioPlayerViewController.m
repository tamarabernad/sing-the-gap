//
//  TBWAudioPlayerViewController.m
//  sing-the-gap
//
//  Created by mariachi on 03/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWAudioPlayerViewController.h"
#import "TBWAudioPlayerConstants.h"

typedef enum {
    kOpen,
    kClosed,
    kHidden,
    kClosedInteractively
} AudioPlayerLayoutState;

@interface TBWAudioPlayerViewController ()
@property (nonatomic) AudioPlayerLayoutState playerLayoutState;
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

        
        self.playerLayoutState = kHidden;
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
- (void)viewDidAppear:(BOOL)animated{
    self.playerLayoutState = kClosed;

    [self layout];
}
- (void)viewDidDisappear:(BOOL)animated{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [self close];
}
- (void) receiveHideNotification:(NSNotification *) notification
{
    [self hide];
}
- (void) receiveOpenNotification:(NSNotification *) notification
{
    [self open];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Player
////////////////////////////////////////////////////////////////////////

- (void)play{
    if(self.playerLayoutState != kClosedInteractively){
        [self setLayoutState:kOpen Animated:YES];
    }
}
-(void)pause{
    
}
- (void)open{
    [self setLayoutState:kOpen Animated:YES];
}
- (void)close{
    [self setLayoutState:kClosed Animated:YES];
}
- (void)hide{
    [self setLayoutState:kHidden Animated:YES];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Private methods
////////////////////////////////////////////////////////////////////////
- (CGRect) getEndFrameForState:(AudioPlayerLayoutState)state{
    CGRect frame = self.view.frame;
    switch (self.playerLayoutState) {
        case kClosed:
        case kClosedInteractively:
            frame.origin.y = [[UIScreen mainScreen] bounds].size.height - 56;
            break;
        case kOpen:
            frame.origin.y = [[UIScreen mainScreen] bounds].size.height - frame.size.height;
            break;
        case kHidden:
            frame.origin.y = [[UIScreen mainScreen] bounds].size.height;
            break;
    }
    return frame;

}

- (void)layout{
    [self.view setFrame:[self getEndFrameForState:self.playerLayoutState]];
}

- (void) setLayoutState:(AudioPlayerLayoutState)state Animated:(BOOL) animated{
    self.playerLayoutState = state;
    if(animated){
        [UIView animateWithDuration:0.5 animations:^{
            [self.view setFrame:[self getEndFrameForState:self.playerLayoutState]];
        }];
    }else{
        [self.view setFrame:[self getEndFrameForState:self.playerLayoutState]];
    }
}
@end
