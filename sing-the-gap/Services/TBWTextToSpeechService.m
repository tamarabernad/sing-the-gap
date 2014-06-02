//
//  TBWTextToSpeechService.m
//  sing-the-gap
//
//  Created by mariachi on 02/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWTextToSpeechService.h"
#import  <AVFoundation/AVFoundation.h>
#import "ESpeakEngine.h"

@interface TBWTextToSpeechService()

@property (nonatomic, strong) ESpeakEngine *engine;


@end
@implementation TBWTextToSpeechService
- (ESpeakEngine *)engine{
    if(!_engine){
        // Custom initialization
        _engine = [[ESpeakEngine alloc] init];
        _engine.volume = 1;
        
        NSArray * languages = [_engine supportedLanguages];
        for (NSString *lang in languages) {
            NSLog(@"%@", lang);
        }
        [_engine setLanguage:@"en"];

    }
    return _engine;
}

- (void) textToSpeech:(NSString *)text WithLanguage:(NSString *)language AndGender:(NSString *)gender ToFile:(NSString *)filePath{
    ESpeakEngineGener speakGender = [gender isEqualToString:@"female"] ? kESpeakEngineGenerFemale : kESpeakEngineGenerMale;
    [self.engine setGender:speakGender];
    [self.engine setLanguage:language];
	[self.engine speek:text ToFile:filePath];
}
@end
