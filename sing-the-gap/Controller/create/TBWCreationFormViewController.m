//
//  TBWCreationFormViewController.m
//  sing-the-gap
//
//  Created by Tamara Bernad on 17/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWCreationFormViewController.h"

@interface TBWCreationFormViewController ()<UIGestureRecognizerDelegate>

@end

@implementation TBWCreationFormViewController

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
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
