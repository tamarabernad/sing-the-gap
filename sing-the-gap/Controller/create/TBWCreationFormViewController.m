//
//  TBWCreationFormViewController.m
//  sing-the-gap
//
//  Created by Tamara Bernad on 17/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWCreationFormViewController.h"
#import "TBWTextToSpeechService.h"

#import  <AVFoundation/AVFoundation.h>
@interface TBWCreationFormViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *step1View;
@property (weak, nonatomic) IBOutlet UIView *step2View;
@property (weak, nonatomic) IBOutlet UIView *step3View;
@property (weak, nonatomic) IBOutlet UIView *step4View;
@property (weak, nonatomic) IBOutlet UIView *step5View;
@property (weak, nonatomic) IBOutlet UIView *step2WriteView;
@property (weak, nonatomic) IBOutlet UIView *step2RecordView;
@property (weak, nonatomic) IBOutlet UITextField *tfStep2Write;
@property (weak, nonatomic) IBOutlet UILabel *tfStep4Name;
@property (weak, nonatomic) IBOutlet UIButton *btStep1Write;
@property (weak, nonatomic) IBOutlet UIButton *btStep1Record;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (nonatomic, strong)TBWTextToSpeechService *textToSpeachService;
@property (nonatomic, strong) NSString *currentTextToSpeechString;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (nonatomic) BOOL writeVisible;
@property (nonatomic) NSInteger currentStep;
@end

@implementation TBWCreationFormViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
- (AVAudioPlayer *)audioPlayerWithPath:(NSString *)path{
    if(_audioPlayer){
        if ([_audioPlayer isPlaying]) {
            [_audioPlayer stop];
        }
        _audioPlayer = nil;
    }

    NSURL *url = [NSURL fileURLWithPath:path];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    _audioPlayer = [AVPlayer playerWithPlayerItem:playerItem];
    return _audioPlayer;
}
- (TBWTextToSpeechService *)textToSpeachService{
    if(!_textToSpeachService){
        _textToSpeachService = [[TBWTextToSpeechService alloc] init];
    }
    return _textToSpeachService;
}
- (void)setCurrentStep:(NSInteger)currentStep{
    _currentStep = currentStep;
    [self updateStep];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self showWriteViewAnimated:NO];
    self.currentStep = 2;

}
- (void)viewDidAppear:(BOOL)animated{
        [self.scrollview setContentSize:CGSizeMake(self.scrollview.frame.size.width, self.step5View.frame.origin.y+self.step5View.frame.size.height)];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////////////////////////
#pragma mark - Actions
////////////////////////////////

////////////////////////////////
#pragma mark Step 1 actions
////////////////////////////////
- (IBAction)onClickS1Record:(id)sender {
    self.currentStep = 1;
    [self showRecordViewAnimated:YES];
}
- (IBAction)onClickS1Write:(id)sender {
    self.currentStep = 1;
    [self showWriteViewAnimated:YES];
}

////////////////////////////////
#pragma mark Step 2 actions
////////////////////////////////
- (IBAction)onClickS2Record:(id)sender {
}
- (IBAction)onClickS2RecordPlay:(id)sender {
}
- (IBAction)onClick2WritePlay:(id)sender {
    [self convertTextToSpeech];
    [self playTextToSpeech];
}
- (IBAction)onClickS2Next:(id)sender {
    self.currentStep = 3;
    [self convertTextToSpeech];

    
}

////////////////////////////////
#pragma mark Step 3 actions
////////////////////////////////
- (IBAction)onClick3Play:(id)sender {
}

////////////////////////////////
#pragma mark Step 5 actions
////////////////////////////////
- (IBAction)onClickBuy:(id)sender {
}

////////////////////////////////
#pragma mark - Helpers
////////////////////////////////
- (void) showRecordViewAnimated:(BOOL)animated{
    if(!self.writeVisible)return;
    
    self.writeVisible = NO;
    self.step2RecordView.hidden = NO;
    self.step2WriteView.hidden = YES;
    
    [self.btStep1Write setSelected:NO];
    [self.btStep1Record setSelected:YES];
    
    
    
}
- (void) showWriteViewAnimated:(BOOL)animated{
    if(self.writeVisible)return;
    
    self.writeVisible = YES;
    self.step2RecordView.hidden = YES;
    self.step2WriteView.hidden = NO;
    
    [self.btStep1Write setSelected:YES];
    [self.btStep1Record setSelected:NO];
}
- (void)updateStep{
    switch (self.currentStep) {
        case 1:
        case 2:
            self.step1View.hidden = NO;
            self.step2View.hidden = NO;
            self.step3View.hidden = YES;
            self.step4View.hidden = YES;
            self.step5View.hidden = YES;
            break;
        case 3:
        case 4:
        case 5:
            self.step1View.hidden = NO;
            self.step2View.hidden = NO;
            self.step3View.hidden = NO;
            self.step4View.hidden = NO;
            self.step5View.hidden = NO;
            break;
    }
}
- (void)convertTextToSpeech{
    NSString *text = self.tfStep2Write.text;
    if(![text isEqualToString:self.currentTextToSpeechString]){
        self.currentTextToSpeechString = text;
        
        NSString *fileName =[NSString stringWithFormat:@"%@.wav",self.gapSong.title];
        NSString *path = [RecordingsPath() stringByAppendingPathComponent:fileName];
        [self.textToSpeachService textToSpeech:text WithLanguage:@"en" AndGender:@"fe" ToFile:path];
    }
}
- (void)playTextToSpeech{
    NSString *fileName =[NSString stringWithFormat:@"%@.wav",self.gapSong.title];
    NSString *path = [RecordingsPath() stringByAppendingPathComponent:fileName];
    [self audioPlayerWithPath:path];
    [self.audioPlayer play];
}
@end
