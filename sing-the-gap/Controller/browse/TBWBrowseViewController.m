//
//  TBWBrowseViewController.m
//  sing-the-gap
//
//  Created by Tamara Bernad on 27/05/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWBrowseViewController.h"
#import "TBWGapSong.h"
#import "TBWBrowseCell.h"
#import "TBWAudioPlayerConstants.h"
#import "TBWCreationFormViewController.h"

@interface TBWBrowseViewController ()<UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate, TBWBrowseCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *gapSongs;

@end

@implementation TBWBrowseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated{
    [TBWGapSong retrieveGapSongsWithBlock:^(NSArray *gapSongs, NSError *error) {
        self.gapSongs = gapSongs;
        [self.tableView reloadData];
    }];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
}

//////////////////////////////////////////////////
#pragma mark - UITableViewDelegate methods
//////////////////////////////////////////////////

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.gapSongs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    TBWBrowseCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    TBWGapSong *gapSong =(TBWGapSong *)[self.gapSongs objectAtIndex:indexPath.row];
    
    if(!cell){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TBWBrowseCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        [cell setDelegate:self];
    }
    CGFloat pric = (gapSong.price/(float)100);
    NSString *pr = [NSString stringWithFormat:@"%.2f", pric];
    [cell setTitle:gapSong.title];
    [cell setIsNew:gapSong.isNew];
    [cell setPriceValue:gapSong.price != 0 ? pr: @"Free"];
    return cell;
}

//////////////////////////////////////////////////
#pragma mark - TBWBrowseCellDelegate methods
//////////////////////////////////////////////////
- (void)TBWBrowseCellDidClickCreate:(TBWBrowseCell *)cell{
    [[NSNotificationCenter defaultCenter] postNotificationName:TBWAudioPlayerPauseNotification object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:TBWAudioPlayerHideNotification object:nil];
    
    
    TBWCreationFormViewController *cfvc = [[TBWCreationFormViewController alloc] init];
    [self.navigationController pushViewController:cfvc animated:YES];
}
- (void)TBWBrowseCellDidClickPlay:(TBWBrowseCell *)cell{
    TBWGapSong *gs = [self.gapSongs objectAtIndex:[self.tableView indexPathForCell:cell].row];
    [[NSNotificationCenter defaultCenter] postNotificationName:TBWAudioPlayerPlayNotification object:nil userInfo:@{@"contentUrl":gs.url}];
}

@end
