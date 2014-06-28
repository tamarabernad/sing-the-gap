//
//  TBWCreation.h
//  sing-the-gap
//
//  Created by mariachi on 28/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TBWCreation : NSManagedObject

@property (nonatomic, retain) NSString * gapSongId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * fileName;

@end
