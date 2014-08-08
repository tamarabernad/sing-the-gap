//
//  TBWDataServiceTests.m
//  sing-the-gap
//
//  Created by Tamara Bernad on 16/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TBWGapSong.h"
@interface TBWDataServiceTests : XCTestCase

@end

@implementation TBWDataServiceTests

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

- (void)testRetrieveData{
    [TBWGapSong retrieveGapSongsWithBlock:^(NSArray *gapSongs, NSError *error) {
        XCTAssertTrue([gapSongs count] > 0);
    }];
}

@end
