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
#import "LXItemCell.h"
// Utils
#import "UIColor+LXAdditions.h"
#import "UIGestureRecognizer+IAExtras.h"

@interface LXItemsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readwrite, strong) NSArray *items;
@property (nonatomic, readwrite, strong) UITableView *tableView;
@property (nonatomic, readwrite, assign) NSInteger *selectedRow;
@property (nonatomic, readwrite, strong) NSMutableArray *expandedIndexPaths;

@end

#define MARGIN 6.f

static NSString *reuseIdentifier = @"LXItemsViewControllerReuseIdentifier";

@implementation LXItemsViewController

- (id)initWithItems:(NSArray *)items {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.items = items;
        [self.view addSubview:self.tableView];
        self.expandedIndexPaths = [[NSMutableArray alloc] init];
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
        _tableView.allowsMultipleSelection = YES;
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
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = item.title;
    cell.textLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:16.f];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.descriptionLabel.text = item.description;
    cell.descriptionLabel.hidden = YES;
    
    for (NSIndexPath *idxPath in self.expandedIndexPaths) {
        if (indexPath.row == idxPath.row) {
            cell.expanded = YES;
            cell.descriptionLabel.hidden = NO;
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXItem *item = [self.items objectAtIndex:indexPath.row];
    
    CGFloat height = 44.f;
    
    for (NSIndexPath *idxPath in self.expandedIndexPaths) {
        if (indexPath.row == idxPath.row) {
            UIFont *font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:14.f];
            height = [item.description sizeWithFont:font constrainedToSize:CGSizeMake(320.f, MAXFLOAT)].height+44.f+MARGIN;
        }
    }
    
    return height;
}

/*- (void)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    unselectedColor = [tableView cellForRowAtIndexPath:indexPath].contentView.backgroundColor;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    CGFloat hue, saturation, brigthness, alpha;
    [unselectedColor getHue:&hue saturation:&saturation brightness:&brigthness alpha:&alpha];
    cell.contentView.backgroundColor = [UIColor colorWithHue:hue
                                                  saturation:saturation*0.75f
                                                  brightness:brigthness*0.75f
                                                       alpha:alpha];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.contentView.backgroundColor = unselectedColor;
}*/

/*- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (NSIndexPath *idxPath in self.expandedIndexPaths) {
        if (indexPath.row == idxPath.row) {
            [self collapseRowAtIndexPath:idxPath];
            return;
        }
    }
    
    [self expandRowAtIndexPath:indexPath];
}


#pragma mark - Transitions

- (void)expandRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView beginUpdates];
    [self.expandedIndexPaths addObject:indexPath];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

- (void)collapseRowAtIndexPath:(NSIndexPath *)indexPath {        
    NSIndexPath *indexPathToRemove;
    for (NSIndexPath *idxPath in self.expandedIndexPaths) {
        if (idxPath.row == indexPath.row) {
            indexPathToRemove = idxPath;
        }
    }
    
    [self.tableView beginUpdates];
    [self.expandedIndexPaths removeObject:indexPathToRemove];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

@end
