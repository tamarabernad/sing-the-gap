//
//  TBWDataService.h
//  sing-the-gap
//
//  Created by mariachi on 09/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPSessionManager.h"
@interface TBWDataService : AFHTTPSessionManager

+ (instancetype)sharedClient;
@end
