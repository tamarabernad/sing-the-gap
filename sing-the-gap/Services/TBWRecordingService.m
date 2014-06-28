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
@property (nonatomic, strong) NSTimer *progressTimer;
@property (nonatomic) NSInteger progressCount;
@property (nonatomic) NSTimeInterval duration;


@end

@implementation TBWRecordingService

- (NSString *)getFileExtension{
    return @"m4a";
}
- (void)recordAudioWithDuration:(NSTimeInterval)duration ToFileWithName:(NSString *)fileName{
    self.duration = duration;
    NSString *filePath = [NSString  stringWithFormat:@"%@.%@", fileName, [self getFileExtension]];
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
    
    self.progressCount = 0;
    self.progressTimer =[NSTimer scheduledTimerWithTimeInterval: 0.001 target: self selector: @selector(updateProgress) userInfo: nil repeats: YES];

}
- (void)stopRecording{
    [self.recordTimer invalidate];
    self.recordTimer = nil;
    
    [self.progressTimer invalidate];
    self.progressTimer = nil;
    
    [self.recorder stop];
    
    if(self.delegate){
        [self.delegate TBWRecordingServiceDidStopRecording:self];
    }
}
- (void)updateProgress{
    self.progressCount++;
    float progress = (self.progressCount * 0.001)/self.duration;

    if(self.delegate){
        [self.delegate TBWRecordingService:self updateWithProgress:progress];
    }
}
@end
