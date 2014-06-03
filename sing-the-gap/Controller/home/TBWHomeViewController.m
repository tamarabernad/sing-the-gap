//
//  TBWHomeViewController.m
//  sing-the-gap
//
//  Created by Tamara Bernad on 27/05/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWHomeViewController.h"
#import "TBWBrowseViewController.h"
#import "TBWMyCreationsViewController.h"
#import "TBWAudioPlayerConstants.h"
@interface TBWHomeViewController ()

@end

@implementation TBWHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)onClickMyCreations:(id)sender {
    TBWMyCreationsViewController *mcc = [[TBWMyCreationsViewController alloc] init];
    [self.navigationController pushViewController:mcc animated:YES];
}
- (IBAction)onExampleClick:(id)sender {
    UIButton *bt = (UIButton *)sender;
    NSString *playUrl = @"";
    switch (bt.tag) {
        case 1:
            playUrl = @"1";
            break;
        case 2:
            playUrl = @"2";
        case 3:
            playUrl = @"3";
            break;
    }

    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:TBWAudioPlayerPlayNotification
     object:self userInfo:@{@"contentUrl":playUrl}];
}
- (IBAction)onBrowseClick:(id)sender {
    TBWBrowseViewController *bvc = [[TBWBrowseViewController alloc] init];
    [self.navigationController pushViewController:bvc animated:YES];

}

@end
