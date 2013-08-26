//
//  LXItemsViewController.m
//  Luxor
//
//  Created by Daniel Ericsson on 2013-05-26.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import "LXItemsViewController.h"
// Models
#import "LXItem.h"
// Views
#import "LXButtonCellTableView.h"
#import "LXItemCell.h"
// Utils
#import "UIColor+LXAdditions.h"
#import "UIGestureRecognizer+IAExtras.h"
#import "UIControl+IAExtras.h"

@interface LXItemsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readwrite, strong) NSArray *items;
@property (nonatomic, readwrite, strong) UITableView *tableView;
@property (nonatomic, readwrite, assign) NSInteger *selectedRow;
@property (nonatomic, readwrite, strong) NSIndexPath *expandedIndexPath;
@property (nonatomic, readwrite, strong) NSMutableArray *expandedIndexPaths;

@end

#define MARGIN 6.f

static NSString *reuseIdentifier = @"LXItemsViewControllerReuseIdentifier";

@implementation LXItemsViewController


#pragma mark - Lifecycle

- (id)initWithItems:(NSArray *)items {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.items = items;
        [self.view addSubview:self.tableView];
        self.expandedIndexPath = nil;
    }
    
    return self;
}


#pragma mark - Layout

- (void)viewWillLayoutSubviews {
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}


#pragma mark - Private properties

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delaysContentTouches = NO;
        
        [_tableView registerClass:[LXItemCell class] forCellReuseIdentifier:reuseIdentifier];
    }
    
    return _tableView;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXItemCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    LXItem *item = [self.items objectAtIndex:indexPath.row];
    BOOL expanded = NO;
    
    if ([indexPath isEqual:self.expandedIndexPath]) {
        expanded = YES;
    }
    
    [self configureCell:cell withItem:item expanded:expanded forIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(LXItemCell *)cell withItem:(LXItem *)item expanded:(BOOL)expanded forIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = item.title;
    cell.descriptionLabel.text = item.description;
    
    [cell.playButton removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
    
	if (!expanded) {
        cell.expanded = NO;
		cell.descriptionLabel.hidden = YES;
        cell.contentView.backgroundColor = [self.baseColor shiftBrightness:indexPath.row*0.025];
	} else {
        cell.contentView.backgroundColor = [UIColor blackColor];
        cell.expanded = YES;
        cell.descriptionLabel.hidden = NO;
        
        [cell.playButton addEventHandler:^(id sender) {
            [self playItem:item];
        } forControlEvents:UIControlEventTouchUpInside];
    }
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = 44.f;
    
    if ([indexPath isEqual:self.expandedIndexPath]) {
        LXItem *item = [self.items objectAtIndex:indexPath.row];
        
        NSDictionary *attrs = @
        {
        NSFontAttributeName: [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:14.f],
        };
        
        CGSize constrainToSize = CGSizeMake(self.view.frame.size.width-2*15.f, CGFLOAT_MAX);
        
        CGRect descriptionLabelRect = [item.description boundingRectWithSize:constrainToSize
                                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                                  attributes:attrs
                                                                     context:nil];
        
        height = height + descriptionLabelRect.size.height+44.f+22.f;
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath isEqual:self.expandedIndexPath]) {
        self.expandedIndexPath = nil;
        [self collapseRowAtIndexPath:indexPath];
    } else {
        [self expandRowAtIndexPath:indexPath];
    }
}


#pragma mark - Private methods

- (void)playItem:(LXItem *)item {
    NSLog(@"%@", item.link);
}


#pragma mark - Transitions

- (void)expandRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView beginUpdates];
    
    //[self.expandedIndexPaths addObject:indexPath];
    if (self.expandedIndexPath) {
        [self.tableView reloadRowsAtIndexPaths:@[indexPath, self.expandedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    self.expandedIndexPath = indexPath;
    
    
    [self.tableView endUpdates];
    
    { // Calculate and scroll expanded cell into view if needed
        CGRect rowRect = [self.tableView rectForRowAtIndexPath:indexPath];
        CGFloat viewHeight = self.tableView.contentOffset.y + self.tableView.contentSize.height;
        CGFloat cellHeight = self.tableView.contentOffset.y + rowRect.origin.y + rowRect.size.height;
        
        if (cellHeight > viewHeight) {
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }
}

- (void)collapseRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

@end
