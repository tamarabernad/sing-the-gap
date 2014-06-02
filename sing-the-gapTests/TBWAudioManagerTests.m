//
//  TBWAudioManagerTests.m
//  sing-the-gap
//
//  Created by mariachi on 01/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TBWAudioManager.h"
#import "TBWTextToSpeechService.h"

@interface TBWAudioManagerTests : XCTestCase

@end

@implementation TBWAudioManagerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAudioFileCreation
{
    NSError *error = nil;
    
    NSURL *recordingsDirectory = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"recordings"] isDirectory:YES];
                                  
    [[NSFileManager defaultManager] createDirectoryAtURL:recordingsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSURL *gapSongsDirectory = [NSURL fileURLWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"gap-songs"] isDirectory:YES];
    
    [[NSFileManager defaultManager] createDirectoryAtURL:gapSongsDirectory withIntermediateDirectories:YES attributes:nil error:&error];

    NSURL *creationsDirectory = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"creations"] isDirectory:YES];
    
    [[NSFileManager defaultManager] createDirectoryAtURL:creationsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    
    NSString *songPath = [[gapSongsDirectory path] stringByAppendingPathComponent:@"test.m4a"];
    NSString *recordingPath = [[recordingsDirectory path] stringByAppendingPathComponent:@"campechano.wav"];
    NSString* file = [[creationsDirectory path] stringByAppendingPathComponent:@"mymp3.m4a"];
    
    TBWAudioManager *sut = [[TBWAudioManager alloc] init];
    [sut createAudioMixWithBaseAudio:songPath GapAudio:recordingPath AndDestinationPath:file AndMarkerMiliseconds:@[]];
    

    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:file];
    XCTAssertTrue(fileExists);
}
- (void)testTextToSpeech{
    NSError *error = nil;
    NSURL *recordingsDirectory = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"recordings"] isDirectory:YES];
    
    [[NSFileManager defaultManager] createDirectoryAtURL:recordingsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSString *recordingPath = [[recordingsDirectory path] stringByAppendingPathComponent:@"record.wav"];
 
    TBWTextToSpeechService *sut = [[TBWTextToSpeechService alloc] init];
    [sut textToSpeech:@"how are you?" WithLanguage:@"en" AndGender:@"male" ToFile:recordingPath];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:recordingPath];
    XCTAssertTrue(fileExists);
    
}
@end
