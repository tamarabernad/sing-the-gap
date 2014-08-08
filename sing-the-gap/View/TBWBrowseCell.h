//
//  TBWBrowseCell.h
//  sing-the-gap
//
//  Created by Tamara Bernad on 16/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TBWBrowseCellDelegate;

@interface TBWBrowseCell : UITableViewCell
@property (nonatomic, weak) NSObject<TBWBrowseCellDelegate> *delegate;

- (void)setTitle:(NSString *)title;
- (void)setIsNew:(BOOL)isNew;
- (void)setPriceValue:(NSString *)priceValue;
@end

@protocol TBWBrowseCellDelegate <NSObject>

@required
- (void) TBWBrowseCellDidClickPlay:(TBWBrowseCell *)cell;
- (void) TBWBrowseCellDidClickCreate:(TBWBrowseCell *)cell;

@end
