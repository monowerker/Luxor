//
//  LXFeedsCollectionViewLayout.m
//  Luxor
//
//  Created by Daniel Ericsson on 2013-05-24.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import "LXFeedsCollectionViewLayout.h"

@implementation LXFeedsCollectionViewLayout

- (id)init {
    if (self = [super init]) {
        self.itemSize = CGSizeMake(320.f, 200.f);
    }
    
    return self;
}

@end
