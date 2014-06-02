//
//  TBWRecordingService.h
//  sing-the-gap
//
//  Created by mariachi on 02/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBWRecordingService : NSObject
- (void)stopRecording;
- (void)recordAudioWithDuration:(NSTimeInterval)duration ToFile:(NSString *)filePath;
@end
