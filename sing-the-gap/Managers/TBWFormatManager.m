//
//  CDAFormatManager.m
//  kpi-dashboard
//
//  Created by Tamara Bernad on 22/09/14.
//  Copyright (c) 2014 Code d'Azur. All rights reserved.
//

#import "TBWFormatManager.h"

#pragma mark - Screentext
#define  FORMATTING_ORDINARY_SUFFIX_TH NSLocalizedStringFromTableInBundle(@"FORMATTING_ORDINARY_SUFFIX_TH", @"General", [CDASettingsManager currentLanguageResourceBundle],@"Formatting - th sufix for numeric values")

#define  FORMATTING_ORDINARY_SUFFIX_ST NSLocalizedStringFromTableInBundle(@"FORMATTING_ORDINARY_SUFFIX_ST", @"General", [CDASettingsManager currentLanguageResourceBundle],@"Formatting - st sufix for numeric values")

#define  FORMATTING_ORDINARY_SUFFIX_ND NSLocalizedStringFromTableInBundle(@"FORMATTING_ORDINARY_SUFFIX_ND", @"General", [CDASettingsManager currentLanguageResourceBundle],@"Formatting - nd sufix for numeric values")

#define  FORMATTING_ORDINARY_SUFFIX_RD NSLocalizedStringFromTableInBundle(@"FORMATTING_ORDINARY_SUFFIX_RD", @"General", [CDASettingsManager currentLanguageResourceBundle],@"Formatting - rd sufix for numeric values")

@interface TBWFormatManager()
@property (nonatomic, strong) NSNumberFormatter *currencyFormatter;


@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDateFormatter *timeFormatter;
@property (nonatomic, strong) NSNumberFormatter *scoreFormatter;
@property (nonatomic, strong) NSNumberFormatter *valueFormatter;
@property (nonatomic, strong) NSNumberFormatter *integerFormatter;


@property (nonatomic, strong) NSNumberFormatter *yAxisPercentageFormatter;
@property (nonatomic, strong) NSNumberFormatter *yAxisValueL10Formatter;
@property (nonatomic, strong) NSNumberFormatter *yAxisValueH10Formatter;
@property (nonatomic, strong) NSNumberFormatter *yAxisBigNumbersFormatter;
@property (nonatomic, strong) NSNumberFormatter *yAxisValueCurrencyFormatter;
@property (nonatomic, strong) NSDateFormatter *yearFormatter;
@end
@implementation TBWFormatManager
static TBWFormatManager *sharedInstance;


///////////////////////////////////////
#pragma mark - Public methods
///////////////////////////////////////
+ (NSString *) formatCurrency:(NSNumber *)value{
    return [sharedInstance.currencyFormatter stringFromNumber:value];
}

+ (NSString *) dateToString:(NSDate *)date {
    return [sharedInstance.dateFormatter stringFromDate:date];
}
+ (NSString *) timeToString:(NSDate *)date {
    return [sharedInstance.timeFormatter stringFromDate:date];
}
+ (NSString *) yearToString:(NSNumber *)value{
    NSDateComponents *components =[[NSDateComponents alloc] init];
    [components setYear:[value integerValue]];
    //TODO not use current calendar needs to come from settings gregorian
    NSDate *d = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    return [sharedInstance.yearFormatter stringFromDate:d];
}
+ (NSString *) yAxisValueToString:(NSNumber *)value WithType:(NSString *) valueType{
    
    NSNumberFormatter *formatter;
    formatter = sharedInstance.yAxisBigNumbersFormatter;
    return [formatter stringFromNumber:value];
    
}
+ (NSString *) indicatorValueToString:(NSNumber *)value WithType:(NSString *) valueType{
    NSNumberFormatter *formatter;    formatter = sharedInstance.valueFormatter;
    return [formatter stringFromNumber:value];
}
+ (NSString *) percentageToString:(NSNumber *) value {
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithDecimal:[value decimalValue]];
    value = (NSNumber *) [decNumber decimalNumberByMultiplyingByPowerOf10:2];
    
    return [sharedInstance.valueFormatter stringFromNumber:value];
}
+ (NSString *) integerNumber:(NSNumber *)number {
    return [sharedInstance.integerFormatter stringFromNumber:number];
}

/////////////////////////////
#pragma mark - Lazy getters
/////////////////////////////
- (NSNumberFormatter *)currencyFormatter{
    if(!_currencyFormatter){
        _currencyFormatter = [[NSNumberFormatter alloc]  init];
        [_currencyFormatter setLocale:[NSLocale currentLocale]];
        [_currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    }
    return _currencyFormatter;
}

- (NSDateFormatter *)yearFormatter{
    if (!_yearFormatter) {
        _yearFormatter = [[NSDateFormatter alloc] init];
        [_yearFormatter setDateFormat:@"yyyy"];
        //        [_yearFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        //        [_yearFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    }
    [_yearFormatter setLocale:[NSLocale currentLocale]];
    return _yearFormatter;
}
- (NSDateFormatter *) dateFormatter {
    if(!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
    }
    
    [_dateFormatter setLocale:[NSLocale currentLocale]];
    return _dateFormatter;
}
- (NSDateFormatter *) timeFormatter {
    if (!_timeFormatter) {
        _timeFormatter = [[NSDateFormatter alloc] init];
        [_timeFormatter setDateFormat:@"h:mm a"];
        // Not using a custom symbol for AM/PM like p.m. as the design in order to take advantage of the localisation system (arabic symbos for AM/PM are completely different
    }
    
    [_timeFormatter setLocale:[NSLocale currentLocale]];
    return _timeFormatter;
}
- (NSNumberFormatter *) scoreFormatter {
    if (!_scoreFormatter) {
        _scoreFormatter = [[NSNumberFormatter alloc] init];
        [_scoreFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [_scoreFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
        [_scoreFormatter setMinimumFractionDigits:1];
        [_scoreFormatter setMaximumFractionDigits:1];
        [_scoreFormatter setMinimumIntegerDigits:1];
        [_scoreFormatter setMaximumIntegerDigits:2];
    }
    
    [_scoreFormatter setLocale:[NSLocale currentLocale]];
    return _scoreFormatter;
}
- (NSNumberFormatter *)valueFormatter{
    if (!_valueFormatter) {
        _valueFormatter = [[NSNumberFormatter alloc] init];
        [_valueFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [_valueFormatter setMaximumFractionDigits:0];
        [_valueFormatter setMaximumFractionDigits:2];
    }
    
    [_valueFormatter setLocale:[NSLocale currentLocale]];
    return _valueFormatter;
    
}
- (NSNumberFormatter *) integerFormatter {
    if (!_integerFormatter) {
        _integerFormatter = [[NSNumberFormatter alloc] init];
        [_integerFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [_integerFormatter setMinimumFractionDigits:0];
        [_integerFormatter setMaximumFractionDigits:0];
        [_integerFormatter setMinimumIntegerDigits:1];
    }
    
    [_integerFormatter setLocale:[NSLocale currentLocale]];
    return _integerFormatter;
}
- (NSNumberFormatter *)yAxisPercentageFormatter{
    if(!_yAxisPercentageFormatter){
        _yAxisPercentageFormatter = [[NSNumberFormatter alloc] init];
        [_yAxisPercentageFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [_yAxisPercentageFormatter setMinimumFractionDigits:0];
        [_yAxisPercentageFormatter setMaximumFractionDigits:3];
        
    }
    
    [_yAxisPercentageFormatter setLocale:[NSLocale currentLocale]];
    return _yAxisPercentageFormatter;
}
- (NSNumberFormatter *)yAxisValueL10Formatter{
    if (!_yAxisValueL10Formatter) {
        _yAxisValueL10Formatter = [[NSNumberFormatter alloc] init];
        [_yAxisValueL10Formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [_yAxisValueL10Formatter setMinimumFractionDigits:0];
        [_yAxisValueL10Formatter setMaximumFractionDigits:2];//Finance & Economy ->Commercial bank branches
    }
    
    [_yAxisValueL10Formatter setLocale:[NSLocale currentLocale]];
    return _yAxisValueL10Formatter;
}
- (NSNumberFormatter *)yAxisValueH10Formatter{
    if (!_yAxisValueH10Formatter) {
        _yAxisValueH10Formatter = [[NSNumberFormatter alloc] init];
        [_yAxisValueH10Formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [_yAxisValueH10Formatter setMinimumFractionDigits:0 ];
        [_yAxisValueH10Formatter setMaximumFractionDigits:2];
    }
    
    [_yAxisValueH10Formatter setLocale:[NSLocale currentLocale]];
    return _yAxisValueH10Formatter;
}
- (NSNumberFormatter *)yAxisValueCurrencyFormatter{
    if (!_yAxisValueCurrencyFormatter) {
        _yAxisValueCurrencyFormatter = [[NSNumberFormatter alloc] init];
        [_yAxisValueCurrencyFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [_yAxisValueCurrencyFormatter setMinimumFractionDigits:2];
        [_yAxisValueCurrencyFormatter setMaximumFractionDigits:2];
    }
    
    [_yAxisValueCurrencyFormatter setLocale:[NSLocale currentLocale]];
    return _yAxisValueCurrencyFormatter;
}
- (NSNumberFormatter *)yAxisBigNumbersFormatter{
    if (!_yAxisBigNumbersFormatter) {
        _yAxisBigNumbersFormatter = [[NSNumberFormatter alloc] init];
        [_yAxisBigNumbersFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [_yAxisBigNumbersFormatter setMinimumFractionDigits:0];
        [_yAxisBigNumbersFormatter setMaximumFractionDigits:3];
    }
    
    [_yAxisBigNumbersFormatter setLocale:[NSLocale currentLocale]];
    return _yAxisBigNumbersFormatter;
}
///////////////////////////////////////
#pragma mark - Life cycle methods
///////////////////////////////////////
- (void)dealloc{
}
/*!
 The runtime sends initialize to each class in a program exactly one time just before the class, or any class that inherits from it, is sent its first message from within the program. (Thus the method may never be invoked if the class is not used.) The runtime sends the initialize message to classes in a thread-safe manner. Superclasses receive this message before their subclasses.
 
 */
+ (void)initialize
{
    static BOOL initialized = NO;
    if(!initialized)
    {
        initialized = YES;
        sharedInstance = [[TBWFormatManager alloc] init];
    }
}

/*!
 Init method should only be called from inside the class, this is checked via the sharedInstance. In case sharedInstance already existed this would mean that
 init was called from outside the class and therefor tried to be instantiated.
 In case tried to be instantiated an exception is rised.
 
 */
- (id)init{
    if(sharedInstance){
        [NSException raise:@"Invalid instantiation" format:@"CDAFormatManager can not be instantiated"];
    }
    
    if(self = [super init]){
        
    }
    return self;
}

@end
