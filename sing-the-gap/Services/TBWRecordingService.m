//
//  TBWRecordingService.m
//  sing-the-gap
//
//  Created by mariachi on 02/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWRecordingService.h"
#import  <AVFoundation/AVFoundation.h>
@interface TBWRecordingService()

@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSTimer *recordTimer;


@end

@implementation TBWRecordingService


- (void)recordAudioWithDuration:(NSTimeInterval)duration ToFile:(NSString *)filePath{
    NSURL *url = [NSURL fileURLWithPath:filePath];

    
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                              [NSNumber numberWithInt: kAudioFormatMPEG4AAC],   AVFormatIDKey,
                              [NSNumber numberWithInt: 2],                         AVNumberOfChannelsKey,
                              nil];
    
    NSError *error;
    
  	self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    
    [self.recorder prepareToRecord];
    [self.recorder record];

    
    self.recordTimer = [NSTimer scheduledTimerWithTimeInterval: duration target: self selector: @selector(stopRecording) userInfo: nil repeats: NO];

}
- (void)stopRecording{
    [self.recorder stop];
}
@end
