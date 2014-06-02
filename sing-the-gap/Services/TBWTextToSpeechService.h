//
//  TBWTextToSpeechService.h
//  sing-the-gap
//
//  Created by mariachi on 02/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBWTextToSpeechService : NSObject
- (void) textToSpeech:(NSString *)text WithLanguage:(NSString *)language AndGender:(NSString *)gender ToFile:(NSString *)filePath;
@end
