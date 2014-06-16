//
//  TBWBrowseCell.h
//  sing-the-gap
//
//  Created by Tamara Bernad on 16/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBWBrowseCell : UITableViewCell
- (void)setTitle:(NSString *)title;
- (void)setIsNew:(BOOL)isNew;
- (void)setPriceValue:(NSString *)priceValue;
@end
