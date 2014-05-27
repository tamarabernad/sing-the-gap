//
//  TBWHomeViewController.m
//  sing-the-gap
//
//  Created by Tamara Bernad on 27/05/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWHomeViewController.h"
#import "TBWBrowseViewController.h"
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
- (IBAction)onBrowseClick:(id)sender {
    TBWBrowseViewController *bvc = [[TBWBrowseViewController alloc] init];
    [self.navigationController pushViewController:bvc animated:YES];

}

@end
