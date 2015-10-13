//
//  TripTableViewController.m
//  GoJournal
//
//  Created by Elber Carneiro on 10/10/15.
//  Copyright © 2015 Elber Carneiro. All rights reserved.
//

#import <AVKit/AVKit.h>
#import "TripTableViewController.h"
#import "EntryCell.h"
#import "Entry.h"

@interface TripTableViewController ()

@property (nonatomic) NSMutableArray <Entry *> *entries;

@end

@implementation TripTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.entries = [[NSMutableArray alloc] init];
    
    [self setupDemoContent];
    [self setupCells];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)setupDemoContent {
    
    UIImage *image1 = [UIImage imageNamed:@"wilderness1"];
    Entry *entryOne = [[Entry alloc] initWithImage:image1];
    [self.entries addObject:entryOne];
    
    UIImage *image2 = [UIImage imageNamed:@"wilderness2"];
    Entry *entryTwo = [[Entry alloc] initWithImage:image2];
    [self.entries addObject:entryTwo];
    
    NSString *text1 = @"It's a beautiful sunny day! I hear the birds in my ear and in my mind. Seriously, they won't stop chirping. On an on and on. All afternoon. I haven't seen another human being for two days now. The berries are getting harder and harder to find. I almost caught a squirrel. So hungry.";
    Entry *entryThree = [[Entry alloc] initWithText:text1];
    [self.entries addObject:entryThree];
    
    UIImage *image3 = [UIImage imageNamed:@"wilderness2"];
    Entry *entryFour = [[Entry alloc] initWithImage:image3];
    [self.entries addObject:entryFour];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"vid" ofType:@"m4v"];
    NSLog(@"%@", path);
    NSURL *url = [NSURL fileURLWithPath:path];
    Entry *entryFive = [[Entry alloc] initWithVideoURL:url];
    [self.entries addObject:entryFive];
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"vid2" ofType:@"m4v"];
    NSLog(@"%@", path2);
    NSURL *url2 = [NSURL fileURLWithPath:path2];
    Entry *entrySix = [[Entry alloc] initWithVideoURL:url2];
    [self.entries addObject:entrySix];
    [self.entries addObject:entrySix];
}

- (void)setupCells {
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"EntryCell" bundle:nil] forCellReuseIdentifier:@"entryCellIdentifier"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EntryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"entryCellIdentifier" forIndexPath:indexPath];
    
    if (self.entries[indexPath.row].image != nil) {
        cell.photoView.hidden = NO;
        cell.descriptionLabel.hidden = YES;
        cell.videoView.hidden = YES;
        cell.photoView.image = self.entries[indexPath.row].image;
    } else if (self.entries[indexPath.row].video != nil) {
        cell.photoView.hidden = YES;
        cell.descriptionLabel.hidden = YES;
        cell.videoView.hidden = NO;
        
        // ASYNC LOADING:
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        
        dispatch_async(queue, ^{
        
            AVAsset *asset = [AVAsset assetWithURL:self.entries[indexPath.row].video];
            AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
                
                AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
                NSLog(@"%@", CGRectCreateDictionaryRepresentation(cell.videoView.bounds));
                layer.frame = cell.videoView.bounds;
                layer.videoGravity = AVLayerVideoGravityResizeAspect;
                
                [player play];
                
                [cell.videoView.layer addSublayer:layer];
            });
        });
        
    } else {
        cell.photoView.hidden = YES;
        cell.descriptionLabel.hidden = NO;
        cell.videoView.hidden = YES;
        cell.descriptionLabel.text = self.entries[indexPath.row].text;
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
