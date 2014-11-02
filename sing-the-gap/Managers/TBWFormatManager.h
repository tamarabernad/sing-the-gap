//
//  CDAFormatManager.h
//  kpi-dashboard
//
//  Created by Tamara Bernad on 22/09/14.
//  Copyright (c) 2014 Code d'Azur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBWFormatManager : NSObject
+ (NSString *) formatCurrency:(NSNumber *)value;

+ (NSString *) dateToString:(NSDate *)date;
+ (NSString *) timeToString:(NSDate *)date;
+ (NSString *) indicatorValueToString:(NSNumber *)value WithType:(NSString *) valueType;
+ (NSString *) percentageToString:(NSNumber *) value;
+ (NSString *) yAxisValueToString:(NSNumber *)value WithType:(NSString *) valueType;
+ (NSString *) yearToString:(NSNumber *)value;
+ (NSString *) integerNumber:(NSNumber *)number;
@end
