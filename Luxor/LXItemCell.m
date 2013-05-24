//
//  LXItemCell.m
//  Luxor
//
//  Created by Daniel Ericsson on 2013-05-26.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import "LXItemCell.h"
// Utils
#import "IADrawingUtilities.h"
#import "UIColor+LXAdditions.h"

#define MARGIN 6.f

@implementation LXItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor darkGrayColor];
        [self.contentView addSubview:self.descriptionLabel];
        self.textLabel.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
    }
    
    return self;
}


#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.textLabel sizeToFit];
    self.textLabel.frame = CGRectSetOrigin(self.textLabel.frame, CGPointMake(6.f, 6.f));
    
    if (self.expanded) {
        //[self.descriptionLabel sizeToFit];
        
        CGFloat newX = self.textLabel.frame.origin.x;
        CGFloat newY = self.textLabel.frame.origin.y+self.textLabel.frame.size.height;
        
        UIFont *font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:14.f];
        CGSize size = [self.descriptionLabel.text sizeWithFont:font constrainedToSize:CGSizeMake(320.f-(2*MARGIN), MAXFLOAT)];
        
        self.descriptionLabel.frame = CGRectMake(newX, newY, 320.f-(2*MARGIN), size.height+MARGIN);
    } else {
        self.descriptionLabel.frame = CGRectZero;
    }
}


#pragma mark - Public properties

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:14.f];
        _descriptionLabel.textColor = [UIColor whiteColor];
        _descriptionLabel.backgroundColor = [UIColor clearColor];
        _descriptionLabel.numberOfLines = 0;
    }
    
    return _descriptionLabel;
}

@end
