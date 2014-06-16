//
//  TBWDataService.m
//  sing-the-gap
//
//  Created by mariachi on 09/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWDataService.h"

static NSString * const STGBaseURLString = @"http://sing-the-gap-api.localhost/v1/";

@implementation TBWDataService

+ (instancetype)sharedClient {
    static TBWDataService *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[TBWDataService alloc] initWithBaseURL:[NSURL URLWithString:STGBaseURLString]];
        
    });
    
    return _sharedClient;
}
@end
