//
//  TBWAudioManager.h
//  sing-the-gap
//
//  Created by mariachi on 01/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TBWAudioManager : NSObject

- (void)createAudioMixWithBaseAudio:(NSString *)baseUrl GapAudio:(NSString *)gapUrl AndDestinationPath:(NSString *)destinationPath AndMarkerMiliseconds:(NSArray *)markers;
@end
