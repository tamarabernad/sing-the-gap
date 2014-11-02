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
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSString *constrantsVF = [NSString stringWithFormat:@"V:[audioPlayer(%li)]", (long)[self getViewHeight]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:constrantsVF
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:@{@"audioPlayer":self.view}]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidAppear:(BOOL)animated{
    [self setLayoutState:kClosed Animated:NO];
}
- (void)viewDidDisappear:(BOOL)animated{
}
////////////////////////////////////////////////////////////////////////
#pragma mark - Notification Handling
////////////////////////////////////////////////////////////////////////

- (void) receivePlayNotification:(NSNotification *) notification
{
//    NSString *contentUrl = [notification.userInfo objectForKey:@"contentUrl"];
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
- (NSInteger)getViewHeight{
    return 122;
}

- (NSInteger) getLayoutConstantForState:(AudioPlayerLayoutState)state{
    NSInteger constant;
    switch (self.playerLayoutState) {
        case kClosed:
        case kClosedInteractively:
            constant = [self getViewHeight];
            break;
        case kOpen:
            constant = 0;
            break;
        case kHidden:
            constant = 100;
            break;
    }
    return constant;
    
}
- (void) setLayoutState:(AudioPlayerLayoutState)state Animated:(BOOL) animated{
    self.playerLayoutState = state;
    
    self.verticalConstraint.constant = [self getLayoutConstantForState:self.playerLayoutState];
    if(animated){
        [UIView animateWithDuration: 0.5 animations:^{
            [self.view.superview layoutIfNeeded];
        }];
    }else{
        [self.view.superview layoutIfNeeded];
    }
}
@end
