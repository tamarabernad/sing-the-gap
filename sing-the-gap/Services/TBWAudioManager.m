//
//  TBWAudioManager.m
//  sing-the-gap
//
//  Created by mariachi on 01/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWAudioManager.h"
#import  <AVFoundation/AVFoundation.h>

@implementation TBWAudioManager
- (NSString *)getFileExtension{
    return @"m4a";
}
- (void)createAudioMixWithBaseAudio:(NSString *)baseUrl GapAudio:(NSString *)gapUrl AndDestinationPath:(NSString *)destinationPath AndMarkerMiliseconds:(NSArray *)markers{
    destinationPath = [destinationPath stringByAppendingFormat:@".%@",[self getFileExtension]];
    
    NSString *as1str = baseUrl;
    AVURLAsset *asset1 = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:as1str] options:nil];
    
    NSString *as2str = gapUrl;
    AVURLAsset *asset2 = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:as2str] options:nil];
    
    
    AVMutableComposition *mc = [[AVMutableComposition alloc] init];
    
    AVMutableCompositionTrack *composition1 = [mc addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    AVAssetTrack *clipAudioTrack1 = [[asset1 tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
    [composition1 insertTimeRange:CMTimeRangeMake(kCMTimeZero, [asset1 duration])  ofTrack:clipAudioTrack1 atTime:kCMTimeZero error:nil];
    
    for (NSNumber *marker in markers) {
        
        Float64 seconds = [marker integerValue]/1000.0;
        AVMutableCompositionTrack *composition2 = [mc addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
        AVAssetTrack *clipAudioTrack2 = [[asset2 tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
        [composition2 insertTimeRange:CMTimeRangeMake(kCMTimeZero, [asset2 duration])  ofTrack:clipAudioTrack2 atTime:CMTimeMakeWithSeconds(seconds, 600) error:nil];
    
    }
    
    NSString *output = destinationPath;
    if([[NSFileManager defaultManager] fileExistsAtPath:output])
    {
        [[NSFileManager defaultManager] removeItemAtPath:output error:nil];
    }
    NSURL *url = [[NSURL alloc] initFileURLWithPath: output];
    
    AVAssetExportSession *es = [[AVAssetExportSession alloc] initWithAsset:mc presetName:AVAssetExportPresetAppleM4A];
    [es setOutputFileType:AVFileTypeAppleM4A];
    
    [es setOutputURL:url];
    
    [es exportAsynchronouslyWithCompletionHandler:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{

        });
        
    }];
}
@end
