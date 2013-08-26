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
#import "LXButtonFactory.h"

#define MARGIN 6.f

@implementation LXItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.descriptionLabel];
        self.playButton = [LXButtonFactory buttonWithTitle:@"Play".uppercaseString];
        [self.contentView insertSubview:self.playButton atIndex:0];
        
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:16.f];
    }
    
    return self;
}


#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.textLabel sizeToFit];
    self.descriptionLabel.hidden = YES;
    self.playButton.hidden = YES;
    
    if (!self.expanded) {
        self.textLabel.frame = CGRectSetOrigin(self.textLabel.frame, CGPointMake(self.textLabel.frame.origin.x,
                                                                                 self.contentView.frame.size.height/2.f-
                                                                                 self.textLabel.frame.size.height/2.f));
    } else {
        self.descriptionLabel.hidden = NO;
        self.playButton.hidden = NO;
        
        self.textLabel.frame = CGRectSetOrigin(self.textLabel.frame, CGPointMake(self.textLabel.frame.origin.x,
                                                                                 (44.f-self.textLabel.frame.size.height)/2.f));
        NSDictionary *attrs = @
        {
            NSFontAttributeName: self.descriptionLabel.font,
        };
        
        CGSize constrainToSize = CGSizeMake(self.contentView.frame.size.width-2*self.textLabel.frame.origin.x, CGFLOAT_MAX);
        CGRect descriptionLabelRect = [self.descriptionLabel.text boundingRectWithSize:constrainToSize
                                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                                    attributes:attrs
                                                                       context:nil];
        
        CGPoint descriptionLabelOrigin = CGPointMake(self.textLabel.frame.origin.x,
                                                     self.textLabel.frame.origin.y+
                                                     self.textLabel.frame.size.height + MARGIN);
        
        self.descriptionLabel.frame = CGRectMake(descriptionLabelOrigin.x,
                                                 descriptionLabelOrigin.y,
                                                 descriptionLabelRect.size.width,
                                                 descriptionLabelRect.size.height);
        
        self.playButton.frame = CGRectSetSize(self.playButton.frame,
                                              CGSizeMake(self.contentView.frame.size.width -
                                                         self.textLabel.frame.origin.x*2, 44.f));
        
        self.playButton.frame = CGRectSetOrigin(self.playButton.frame,
                                                CGPointMake(self.textLabel.frame.origin.x,
                                                            self.descriptionLabel.frame.origin.y +
                                                            self.descriptionLabel.frame.size.height + 12.f));
    }
}


#pragma mark - Public properties

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _descriptionLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:14.f];
        _descriptionLabel.textColor = [UIColor whiteColor];
        _descriptionLabel.backgroundColor = [UIColor clearColor];
        _descriptionLabel.numberOfLines = 0;
    }
    
    return _descriptionLabel;
}

@end
