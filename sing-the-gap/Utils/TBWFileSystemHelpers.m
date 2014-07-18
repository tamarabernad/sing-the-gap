//
//  TBWFileSystemHelpers.m
//  sing-the-gap
//
//  Created by mariachi on 22/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWFileSystemHelpers.h"

NSString *RecordingsPath(){
    
    NSError *error;
    NSURL *recordingsDirectory = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"recordings"] isDirectory:YES];
    [[NSFileManager defaultManager] createDirectoryAtURL:recordingsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    return [recordingsDirectory path];
}
NSString *GapSongsPath(){
    NSError *error;
    
    NSURL *gapSongsDirectory = [NSURL fileURLWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"gap-songs"] isDirectory:YES];
    
    [[NSFileManager defaultManager] createDirectoryAtURL:gapSongsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    return [gapSongsDirectory path];
}
NSString *CreationsTemporalPath(){
    NSError *error;
    
    NSURL *creationsDirectory = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"creations"] isDirectory:YES];
    [[NSFileManager defaultManager] createDirectoryAtURL:creationsDirectory withIntermediateDirectories:YES attributes:nil error:&error];

    return [creationsDirectory path];
}
NSString *CreationsBaughtPath(){
    NSError *error;
    
    NSURL *creationsDirectory = [NSURL fileURLWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"creations"] isDirectory:YES];
    [[NSFileManager defaultManager] createDirectoryAtURL:creationsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    return [creationsDirectory path];
}
BOOL doesFileExist(NSString *filePath){
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}