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
    
    self.uid = [attributes valueForKeyPath:@"id"];
    self.title = [attributes valueForKeyPath:@"title_es"];
    self.gender = [attributes valueForKeyPath:@"gender"];
    self.url = [attributes valueForKeyPath:@"url"];
    self.path = [attributes valueForKeyPath:@"path"];
    
    self.characters = (NSUInteger)[[attributes valueForKeyPath:@"characters"] integerValue];
    self.duration = (NSUInteger)[[attributes valueForKeyPath:@"duration"] integerValue];
    self.markers = [[attributes valueForKeyPath:@"markers"] componentsSeparatedByString:@"|"];
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
@end
