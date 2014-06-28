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
@property (nonatomic) CALayer *innerRecord;
@property (nonatomic) CALayer *innerStop;
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
    
    self.innerRecord = [CALayer layer];
    self.innerRecord.backgroundColor = [UIColor greenColor].CGColor;
    self.innerRecord.cornerRadius=11.0;
    self.innerRecord.frame = CGRectMake(10, 10, 22, 22);
    [self.layer addSublayer:self.innerRecord];
    
    self.innerStop = [CALayer layer];
    self.innerStop.backgroundColor = [UIColor redColor].CGColor;
    self.innerStop.frame = CGRectMake(10, 10, 22, 22);
    [self.layer addSublayer:self.innerStop];
    
    [self setSelected:NO];
}
- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self updateView];
}
- (void)updateView{
    [self.innerStop setHidden:!self.isSelected];
    [self.innerRecord setHidden:self.isSelected];
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
