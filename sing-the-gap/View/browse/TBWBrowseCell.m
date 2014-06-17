//
//  TBWBrowseCell.m
//  sing-the-gap
//
//  Created by Tamara Bernad on 16/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWBrowseCell.h"
@interface TBWBrowseCell()
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIButton *btPlay;
@property (weak, nonatomic) IBOutlet UIButton *btCreate;
@property (weak, nonatomic) IBOutlet UIView *viewPrice;
@property (weak, nonatomic) IBOutlet UIView *viewNew;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (nonatomic) BOOL isNew;

@end
@implementation TBWBrowseCell

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
}
- (void)setTitle:(NSString *)title {
    [self.lbTitle setText:title];
}
- (void)setIsNew:(BOOL)isNew{
    _isNew = isNew;
}
- (void)setPriceValue:(NSString *)priceValue
{
    [self.lbPrice setText:priceValue];
}

//////////////////////////////////////////////////
#pragma mark - Interactions
//////////////////////////////////////////////////

- (IBAction)onClickPlay:(id)sender {
    if(self.delegate){
        [self.delegate TBWBrowseCellDidClickPlay:self];
    }
}
- (IBAction)onClickCreate:(id)sender {
    if(self.delegate){
        [self.delegate TBWBrowseCellDidClickCreate:self];
    }
}

@end
