//
//  GJUser.h
//  GoJournal
//
//  Created by Varindra Hart on 10/13/15.
//  Copyright © 2015 Elber Carneiro. All rights reserved.
//

#import "PFUser.h"
#import "GJOutings.h"

@interface GJUser : PFUser <PFSubclassing>

@property (nonatomic) NSMutableArray <GJOutings *> * outingsArray;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *password;

- (instancetype)initWithNewOutingsArray;

@end
