//
//  TestViewController.m
//  GoJournal
//
//  Created by Elber Carneiro on 10/13/15.
//  Copyright © 2015 Elber Carneiro. All rights reserved.
//

#import "TestViewController.h"
#import "Entry.h"

@interface TestViewController ()
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (nonatomic) Entry *entry;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"vid" ofType:@"m4v"];
    NSLog(@"%@", path2);
    NSURL *url2 = [NSURL fileURLWithPath:path2];
    self.entry = [[Entry alloc] initWithVideoURL:url2];
    
    
    // ASYNC LOADING:
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    dispatch_async(queue, ^{
        
        AVAsset *asset = [AVAsset assetWithURL:self.entry.video];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
            
            AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
            NSLog(@"%@", CGRectCreateDictionaryRepresentation(self.videoView.bounds));
            layer.frame = self.videoView.bounds;
            layer.videoGravity = AVLayerVideoGravityResizeAspect;
            
            [player play];
            
            [self.videoView.layer addSublayer:layer];
        });
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
