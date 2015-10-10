//
//  EntryCell.h
//  GoJournal
//
//  Created by Elber Carneiro on 10/10/15.
//  Copyright © 2015 Elber Carneiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
