//
//  TBWCreationFormViewController.m
//  sing-the-gap
//
//  Created by Tamara Bernad on 17/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWCreationFormViewController.h"

@interface TBWCreationFormViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *step1View;
@property (weak, nonatomic) IBOutlet UIView *step2View;
@property (weak, nonatomic) IBOutlet UIView *step3View;
@property (weak, nonatomic) IBOutlet UIView *step4View;
@property (weak, nonatomic) IBOutlet UIView *step5View;
@property (weak, nonatomic) IBOutlet UIView *step2WriteView;
@property (weak, nonatomic) IBOutlet UIView *step2RecordView;
@property (weak, nonatomic) IBOutlet UITextField *tfStep2Write;
@property (weak, nonatomic) IBOutlet UILabel *tfStep4Name;
@property (weak, nonatomic) IBOutlet UIButton *btStep1Write;
@property (weak, nonatomic) IBOutlet UIButton *btStep1Record;

@property (nonatomic) BOOL writeVisible;
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
    [self showWriteViewAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////////////////////////
#pragma mark - Actions
////////////////////////////////

////////////////////////////////
#pragma mark Step 1 actions
////////////////////////////////
- (IBAction)onClickS1Record:(id)sender {
    [self showRecordViewAnimated:YES];
}
- (IBAction)onClickS1Write:(id)sender {
    [self showWriteViewAnimated:YES];
}

////////////////////////////////
#pragma mark Step 2 actions
////////////////////////////////
- (IBAction)onClickS2Record:(id)sender {
}
- (IBAction)onClickS2RecordPlay:(id)sender {
}
- (IBAction)onClick2WritePlay:(id)sender {
}

////////////////////////////////
#pragma mark Step 3 actions
////////////////////////////////
- (IBAction)onClick3Play:(id)sender {
}

////////////////////////////////
#pragma mark Step 5 actions
////////////////////////////////
- (IBAction)onClickBuy:(id)sender {
}

////////////////////////////////
#pragma mark - Helpers
////////////////////////////////
- (void) showRecordViewAnimated:(BOOL)animated{
    if(!self.writeVisible)return;
    
    self.writeVisible = NO;
    self.step2RecordView.hidden = NO;
    self.step2WriteView.hidden = YES;
    
    [self.btStep1Write setSelected:NO];
    [self.btStep1Record setSelected:YES];
}
- (void) showWriteViewAnimated:(BOOL)animated{
    if(self.writeVisible)return;
    
    self.writeVisible = YES;
    self.step2RecordView.hidden = YES;
    self.step2WriteView.hidden = NO;
    
    [self.btStep1Write setSelected:YES];
    [self.btStep1Record setSelected:NO];
}

@end
