//
//  TBWMyCreationsViewController.m
//  sing-the-gap
//
//  Created by mariachi on 03/06/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import "TBWMyCreationsViewController.h"
#import "TBWMyCreationsCell.h"
#import "TBWCreation.h"
#import "TBWCreationFormViewController.h"
#import "TBWAudioPlayerConstants.h"
#import "TBWGapSong.h"

@interface TBWMyCreationsViewController ()<NSFetchedResultsControllerDelegate, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate, TBWMyCreationsCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation TBWMyCreationsViewController

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
    [self.tableView setDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.tableView setBackgroundColor:[UIColor clearColor]];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TBWCreation" inManagedObjectContext:[[CoreDataStack coreDataStack] managedObjectContext]];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:10];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];

    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[[CoreDataStack coreDataStack] managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Error fetching MyCreations %@, %@", error, [error userInfo]);
    }
    
    return _fetchedResultsController;
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
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:0];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"TBWMyCreationsCell";
    TBWMyCreationsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    TBWCreation *creation =(TBWCreation *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if(!cell){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
        [cell setDelegate:self];
    }
    [cell setTitle:creation.name];
    return cell;
}

//////////////////////////////////////////////////
#pragma mark - TBWMyCreationsCellDelegate methods
//////////////////////////////////////////////////
- (void)TBWMyCreationsCellClickCreate:(TBWMyCreationsCell *)cell{
    [[NSNotificationCenter defaultCenter] postNotificationName:TBWAudioPlayerPauseNotification object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:TBWAudioPlayerHideNotification object:nil];
    
    TBWCreation *creation =(TBWCreation *)[self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForCell:cell]];
    
    [TBWGapSong retrieveGapSongById:creation.gapSongId WithBlock:^(TBWGapSong *gapSong, NSError *error) {
       //TODO gapsong might be not available anymore
        TBWCreationFormViewController *cfvc = [[TBWCreationFormViewController alloc] init];
        cfvc.gapSong = gapSong;
        [self.navigationController pushViewController:cfvc animated:YES];
    }];
}
- (void)TBWMyCreationsCellDidClickPlay:(TBWMyCreationsCell *)cell{
    TBWCreation *creation =(TBWCreation *)[self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForCell:cell]];
    NSString *path = [CreationsBaughtPath() stringByAppendingPathComponent:creation.fileName];
    [[NSNotificationCenter defaultCenter] postNotificationName:TBWAudioPlayerPlayNotification object:nil userInfo:@{@"contentUrl":path}];
}

@end
