//
//  TBWCreationFormViewController.m
//  sing-the-gap
//
//  Created by Tamara Bernad on 17/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWCreationFormViewController.h"
#import "TBWTextToSpeechService.h"
#import "TBWRecordingService.h"
#import "TBWAudioManager.h"
#import "TBWRecordButton.h"

#import  <AVFoundation/AVFoundation.h>
@interface TBWCreationFormViewController ()<UIGestureRecognizerDelegate, TBWRecordingServiceDelegate>
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
@property (weak, nonatomic) IBOutlet TBWRecordButton *btRecord;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (nonatomic, strong)TBWTextToSpeechService *textToSpeachService;
@property (nonatomic, strong)TBWRecordingService *recordingService;
@property (nonatomic, strong)TBWAudioManager *audioMixerService;

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
    _audioPlayer  = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    return _audioPlayer;
}
- (TBWAudioManager *)audioMixerService{
    if(!_audioMixerService){
        _audioMixerService = [[TBWAudioManager alloc] init];
    }
    return _audioMixerService;
}
- (TBWRecordingService *)recordingService{
    if(!_recordingService){
        _recordingService = [[TBWRecordingService alloc] init];
        _recordingService.delegate = self;
    }
    return _recordingService;
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
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];

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
    UIButton *bt = (UIButton *)sender;
    if([bt isSelected]){
        [self.recordingService stopRecording];
    }else{
        NSString *path = [self getRecordingPathCurrentGapSong];
        NSTimeInterval time = self.gapSong.duration/1000.0;
        [self.recordingService recordAudioWithDuration:time ToFileWithName:path];
    }
}
- (IBAction)onClickS2RecordPlay:(id)sender {
    [self playRecordedFile];
    
}
- (IBAction)onClickRecordNext:(id)sender {
    self.currentStep = 3;
    [self createMixWithRecording];
}
- (IBAction)onClick2WritePlay:(id)sender {
    [self convertTextToSpeech];
    [self playTextToSpeech];
}
- (IBAction)onClickS2Next:(id)sender {
    self.currentStep = 3;
    [self convertTextToSpeech];
    [self createMixWithTextToSpeach];
    
}

////////////////////////////////
#pragma mark Step 3 actions
////////////////////////////////
- (IBAction)onClick3Play:(id)sender {
    [self playCreation];
}

////////////////////////////////
#pragma mark Step 5 actions
////////////////////////////////
- (IBAction)onClickBuy:(id)sender {
    [self buySong];
}

////////////////////////////////
#pragma mark - Logic
////////////////////////////////
- (void)convertTextToSpeech{
    NSString *text = self.tfStep2Write.text;
    if(![text isEqualToString:self.currentTextToSpeechString]){
        self.currentTextToSpeechString = text;
        
        NSString *path = [self getRecordingPathCurrentGapSong];
        [self.textToSpeachService textToSpeech:text WithLanguage:@"en" AndGender:@"fe" ToFileWithName:path];
    }
}
- (void)playTextToSpeech{
    NSString *fileName =[NSString stringWithFormat:@"%@.%@",self.gapSong.title, [self.textToSpeachService getFileExtension]];
    NSString *path = [RecordingsPath() stringByAppendingPathComponent:fileName];
    [self audioPlayerWithPath:path];
    [self.audioPlayer play];
}

-(void)playRecordedFile{
    NSString *fileName =[NSString stringWithFormat:@"%@.%@",self.gapSong.title, [self.recordingService getFileExtension]];
    NSString *path = [RecordingsPath() stringByAppendingPathComponent:fileName];
    [self audioPlayerWithPath:path];
    [self.audioPlayer play];
}
-(void)playCreation{
    NSString *fileName =[NSString stringWithFormat:@"%@.%@",self.gapSong.title, [self.audioMixerService getFileExtension]];
    NSString *path = [CreationsTemporalPath() stringByAppendingPathComponent:fileName];
    [self audioPlayerWithPath:path];
    [self.audioPlayer play];
}
- (void)createMixWithRecording{
    NSString *fileName =[NSString stringWithFormat:@"%@.%@",self.gapSong.title, [self.recordingService getFileExtension]];
    NSString *path = [RecordingsPath() stringByAppendingPathComponent:fileName];
    
    NSString *destinationPath = [CreationsTemporalPath() stringByAppendingPathComponent:self.gapSong.title];
    
    self.gapSong.path = [GapSongsPath() stringByAppendingPathComponent:@"test.m4a"];
    [self.audioMixerService createAudioMixWithBaseAudio:self.gapSong.path GapAudio:path AndDestinationPath:destinationPath AndMarkerMiliseconds:self.gapSong.markers];
}
- (void)createMixWithTextToSpeach{
    NSString *fileName =[NSString stringWithFormat:@"%@.%@",self.gapSong.title, [self.textToSpeachService getFileExtension]];
    NSString *path = [RecordingsPath() stringByAppendingPathComponent:fileName];
    
    NSString *destinationPath = [CreationsTemporalPath() stringByAppendingPathComponent:self.gapSong.title];
    
    self.gapSong.path = [GapSongsPath() stringByAppendingPathComponent:@"test.m4a"];
    //TODO use the downloaded path
    [self.audioMixerService createAudioMixWithBaseAudio:self.gapSong.path GapAudio:path AndDestinationPath:destinationPath AndMarkerMiliseconds:self.gapSong.markers];
}
- (void)buySong{
    NSString *fileName =[NSString stringWithFormat:@"%@.%@",self.gapSong.title, [self.audioMixerService getFileExtension]];
    NSString *path = [CreationsTemporalPath() stringByAppendingPathComponent:fileName];
    NSURL *sourceUrl = [NSURL fileURLWithPath:path];
    
    NSString *destinationPath = [CreationsBaughtPath() stringByAppendingPathComponent:fileName];
    NSURL *destinationUrl = [NSURL fileURLWithPath:destinationPath];
    
    if ( [[NSFileManager defaultManager] isReadableFileAtPath:path] ){
        [[NSFileManager defaultManager] copyItemAtURL:sourceUrl toURL:destinationUrl error:nil];
    }
    
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
-(void)hideKeyBoard {
    [self.tfStep2Write resignFirstResponder];
    [self.tfStep4Name resignFirstResponder];
}
- (NSString *)getRecordingPathCurrentGapSong{
    NSString *fileName =[NSString stringWithFormat:@"%@",self.gapSong.title];
    NSString *path = [RecordingsPath() stringByAppendingPathComponent:fileName];

    return path;
}

////////////////////////////////////////////////////////////////
#pragma mark - TBWRecordingServiceDelegate methods
////////////////////////////////////////////////////////////////
- (void)TBWRecordingService:(TBWRecordingService *)service updateWithProgress:(float)progress{
    NSLog(@"Did stop updateWithProgress %f",progress);
}
- (void)TBWRecordingServiceDidStopRecording:(TBWRecordingService *)service{
    NSLog(@"Did stop recording");
}


@end
