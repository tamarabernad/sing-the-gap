//
//  TBWMyCreationsCell.m
//  sing-the-gap
//
//  Created by mariachi on 28/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWMyCreationsCell.h"
@interface TBWMyCreationsCell()

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@end

@implementation TBWMyCreationsCell

- (void)awakeFromNib
{
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setTitle:(NSString *)title{
    [self.lbTitle setText:title];
}

//////////////////////////////////////////////////
#pragma mark - Actions
//////////////////////////////////////////////////

- (IBAction)onCreationClick:(id)sender {
    [self.delegate TBWMyCreationsCellClickCreate:self];
}
- (IBAction)onPlayClick:(id)sender {
    [self.delegate TBWMyCreationsCellDidClickPlay:self];
}
@end
