//
//  LXFeedCell.h
//  Luxor
//
//  Created by Daniel Ericsson on 2013-05-24.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXFeed;

@interface LXFeedCell : UICollectionViewCell

@property (nonatomic, readwrite, strong) LXFeed *feed;

@end
