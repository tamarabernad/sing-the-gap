//
//  TBWGapSong.m
//  sing-the-gap
//
//  Created by mariachi on 01/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWGapSong.h"
#import "TBWDataService.h"
@implementation TBWGapSong


- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.uid = [attributes valueForKeyPath:@"uid"];
    self.title = [attributes valueForKeyPath:@"title"];
    self.type = [attributes valueForKeyPath:@"type"];
    self.url = [attributes valueForKeyPath:@"url"];
    self.path = [attributes valueForKeyPath:@"path"];
    self.price = [[attributes valueForKeyPath:@"price"] integerValue];
    
    self.characters = (NSUInteger)[[attributes valueForKeyPath:@"characters"] integerValue];
    self.duration = (NSUInteger)[[attributes valueForKeyPath:@"duration"] integerValue];
    self.markers = [attributes valueForKeyPath:@"markers"];
    self.categories = [attributes valueForKeyPath:@"categories"];
    return self;
}

#pragma mark -

+ (NSURLSessionDataTask *)retrieveGapSongsWithBlock:(void (^)(NSArray *gapSongs, NSError *error))block {
    return [[TBWDataService sharedClient] GET:@"gap-songs" parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSArray *gapSongsFromResponse = JSON;
        NSMutableArray *mutableGapSongs = [NSMutableArray arrayWithCapacity:[gapSongsFromResponse count]];
        for (NSDictionary *attributes in gapSongsFromResponse) {
            TBWGapSong *gapSong = [[TBWGapSong alloc] initWithAttributes:attributes];
            [mutableGapSongs addObject:gapSong];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutableGapSongs], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}

+ (NSURLSessionDataTask *)retrieveGapSongById:(NSString *)uid WithBlock:(void (^)(TBWGapSong *gapSong, NSError *error))block {
    NSString *url = [NSString stringWithFormat:@"gap-songs/%@", uid];
    return [[TBWDataService sharedClient] GET:url parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSDictionary *gapSongFromResponse = JSON;
        TBWGapSong *gapSong = [[TBWGapSong alloc] initWithAttributes:gapSongFromResponse];

        if (block) {
            block(gapSong, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}
@end
