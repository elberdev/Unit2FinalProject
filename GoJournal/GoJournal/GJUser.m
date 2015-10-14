//
//  GJUser.m
//  GoJournal
//
//  Created by Varindra Hart on 10/13/15.
//  Copyright © 2015 Elber Carneiro. All rights reserved.
//

#import "GJUser.h"

@implementation GJUser

@dynamic outingsArray;
@dynamic username;
@dynamic password;

- (instancetype)initWithNewOutingsArray{
    
    if (self = [super init]) {
        self.outingsArray = [NSMutableArray new];
        return self;
    }
    else
        return nil;
}

@end
