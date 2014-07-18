//
//  TBWGapSong.h
//  sing-the-gap
//
//  Created by mariachi on 01/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBWGapSong : NSObject
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *path;
@property (nonatomic) NSInteger characters;
@property (nonatomic) NSInteger duration;
@property (nonatomic) NSArray *markers;
@property (nonatomic) NSArray *categories;
@property (nonatomic) BOOL isNew;
@property (nonatomic) NSInteger price;

+ (NSURLSessionDataTask *)retrieveGapSongsWithBlock:(void (^)(NSArray *gapSongs, NSError *error))block;
+ (NSURLSessionDataTask *)retrieveGapSongById:(NSString *)uid WithBlock:(void (^)(TBWGapSong *gapSong, NSError *error))block;
+ (NSURLSessionDownloadTask *) downloadGapSongFileWithGapsong:(TBWGapSong *)gapsong WithBlock:(void (^)(TBWGapSong *gapsong,NSURL *filePath, NSError *error))block;
@end
