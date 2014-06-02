//
//  TBWHomeViewController.m
//  sing-the-gap
//
//  Created by Tamara Bernad on 27/05/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWHomeViewController.h"
#import "TBWBrowseViewController.h"
#import "TBWRecordingService.h"
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
    NSError *error = nil;
    NSURL *recordingsDirectory = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"recordings"] isDirectory:YES];
    
    [[NSFileManager defaultManager] createDirectoryAtURL:recordingsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSString *recordingPath = [[recordingsDirectory path] stringByAppendingPathComponent:@"recording.m4a"];

    
    
    TBWRecordingService *r = [[TBWRecordingService alloc] init];
    [r recordAudioWithDuration:5.0 ToFile:recordingPath];
//    TBWBrowseViewController *bvc = [[TBWBrowseViewController alloc] init];
//    [self.navigationController pushViewController:bvc animated:YES];

}

@end
