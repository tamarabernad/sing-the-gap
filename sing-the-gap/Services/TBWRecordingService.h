//
//  TBWRecordingService.h
//  sing-the-gap
//
//  Created by mariachi on 02/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol TBWRecordingServiceDelegate;
@interface TBWRecordingService : NSObject
@property (nonatomic, weak) NSObject<TBWRecordingServiceDelegate> *delegate;
- (NSString *)getFileExtension;
- (void)stopRecording;
- (void)recordAudioWithDuration:(NSTimeInterval)duration ToFileWithName:(NSString *)fileName;

@end

@protocol TBWRecordingServiceDelegate <NSObject>
@required
- (void)TBWRecordingService:(TBWRecordingService *)service updateWithProgress:(float)progress;
- (void)TBWRecordingServiceDidStopRecording:(TBWRecordingService *)service;

@end
