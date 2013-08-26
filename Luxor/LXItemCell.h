//
//  LXItemCell.h
//  Luxor
//
//  Created by Daniel Ericsson on 2013-05-26.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXItemCell : UITableViewCell

@property (nonatomic, readwrite, strong) UIColor *backgroundColor;
@property (nonatomic, readwrite, strong) UIButton *playButton;
@property (nonatomic, readwrite, strong) UILabel *descriptionLabel;
@property (nonatomic, readwrite, assign) BOOL expanded;

@end
