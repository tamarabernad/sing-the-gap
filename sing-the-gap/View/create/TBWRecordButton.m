//
//  TBWRecordButton.m
//  sing-the-gap
//
//  Created by Tamara Bernad on 17/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWRecordButton.h"

typedef NS_OPTIONS(NSUInteger, RecordButtonState) {
    RecordButtonStateInactive       = 0,
    RecordButtonStateActive  = 1 << 0,
    RecorButtonStateFull     = 1 << 1,
};

@interface TBWRecordButton()
@property (nonatomic) CALayer *bg;
@property (nonatomic) CALayer *inner;
@property (nonatomic) CALayer *fill;
@end
@implementation TBWRecordButton


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}
- (void)awakeFromNib{
    [self setBackgroundColor:[UIColor clearColor]];
    [self setTitle:@"" forState:UIControlStateNormal];
    
    self.bg = [CALayer layer];
    self.bg.backgroundColor = [UIColor blueColor].CGColor;
    self.bg.cornerRadius=21.0;
    self.bg.frame = CGRectMake(0, 0, 42, 42);
    [self.layer addSublayer:self.bg];
    
    self.inner = [CALayer layer];
    self.inner.backgroundColor = [UIColor greenColor].CGColor;
    self.inner.cornerRadius=11.0;
    self.inner.frame = CGRectMake(10, 10, 22, 22);
    [self.layer addSublayer:self.inner];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
