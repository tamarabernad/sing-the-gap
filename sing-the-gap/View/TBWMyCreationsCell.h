//
//  TBWMyCreationsCell.h
//  sing-the-gap
//
//  Created by mariachi on 28/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TBWMyCreationsCellDelegate;

@interface TBWMyCreationsCell : UITableViewCell
@property (nonatomic, weak) NSObject<TBWMyCreationsCellDelegate> *delegate;

- (void)setTitle:(NSString *)title;
@end
@protocol TBWMyCreationsCellDelegate <NSObject>

@required
- (void) TBWMyCreationsCellDidClickPlay:(TBWMyCreationsCell *)cell;
- (void) TBWMyCreationsCellClickCreate:(TBWMyCreationsCell *)cell;

@end