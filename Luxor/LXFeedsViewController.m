//
//  LXFeedsViewController.m
//  Luxor
//
//  Created by Daniel Ericsson on 2013-05-24.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import "LXFeedsViewController.h"
// Models
#import "LXFeed.h"
// Views
#import "LXFeedsCollectionViewLayout.h"
#import "LXFeedCell.h"
// Controllers
#import "LXItemsViewController.h"

@interface LXFeedsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, readwrite, strong) UICollectionView *collectionView;
@property (nonatomic, readwrite, strong) LXFeedsCollectionViewLayout *collectionViewLayout;
@property (nonatomic, readwrite, strong) NSMutableArray *feeds;

@end

static NSString *LXFeedsViewReuseIdentifier = @"LXFeedsViewReuseIdentifier";

@implementation LXFeedsViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    { // Property init
        self.collectionViewLayout = [[LXFeedsCollectionViewLayout alloc] init];
        self.feeds = [[NSMutableArray alloc] init];
        
        LXFeed *feed = [LXFeed feedFromURL:[NSURL URLWithString:@"http://giardello.local/channel.xml"]];
        if (feed) {
            [self.feeds addObject:feed];
        }
    }
    
    { // View setup
        [self.view addSubview:self.collectionView];
    }
    
    { // Navigation item
        self.navigationItem.title = @"Channels";
    }
}


#pragma mark - Private properties

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                             collectionViewLayout:self.collectionViewLayout];

        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.delaysContentTouches = NO;
        [_collectionView registerClass:[LXFeedCell class] forCellWithReuseIdentifier:LXFeedsViewReuseIdentifier];
    }

    return _collectionView;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.feeds.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LXFeedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LXFeedsViewReuseIdentifier
                                                                 forIndexPath:indexPath];
    
    LXFeed *feed = [self.feeds objectAtIndex:indexPath.item];
    cell.feed = feed;
    
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LXFeed *feed = [self.feeds objectAtIndex:indexPath.item];
    
    LXItemsViewController *itemsViewController = [[LXItemsViewController alloc] initWithItems:feed.items];
    itemsViewController.baseColor = [[self.collectionView cellForItemAtIndexPath:indexPath] contentView].backgroundColor;
    itemsViewController.navigationItem.title = feed.title;
    
    [self.navigationController pushViewController:itemsViewController animated:YES];
}

@end
