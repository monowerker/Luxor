//
//  LXViewController.m
//  Luxor
//
//  Created by Daniel Ericsson on 2013-04-26.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import "LXViewController.h"
// Models
#import "LXFeed.h"

@interface LXViewController ()

@property (nonatomic, readwrite, strong) NSMutableArray *videos;
@property (nonatomic, readwrite, strong) UITableView *tableView;

@property (nonatomic, readwrite, strong) LXFeed *feed;

@end

@implementation LXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://localhost/channel.xml"];

    self.feed = [LXFeed feedFromURL:url];
}

@end
