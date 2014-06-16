//
//  TBWBrowseViewController.m
//  sing-the-gap
//
//  Created by Tamara Bernad on 27/05/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWBrowseViewController.h"
#import "TBWGapSong.h"

@interface TBWBrowseViewController ()<UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *gapSongs;

@end

@implementation TBWBrowseViewController

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
    
    [self.tableView setDataSource:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated{
    [TBWGapSong retrieveGapSongsWithBlock:^(NSArray *gapSongs, NSError *error) {
        self.gapSongs = gapSongs;
        [self.tableView reloadData];
    }];
}

//////////////////////////////////////////////////
#pragma UITableViewDelegate methods
//////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.gapSongs count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc] init];
    }
    [cell.textLabel setText: [(TBWGapSong *)[self.gapSongs objectAtIndex:indexPath.row] title]];
    return cell;
}
@end
