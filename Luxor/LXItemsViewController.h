//
//  LXItemsViewController.h
//  Luxor
//
//  Created by Daniel Ericsson on 2013-05-26.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXItemsViewController : UIViewController

@property (nonatomic, readwrite, strong) UIColor *baseColor;

- (id)initWithItems:(NSArray *)items;

@end
