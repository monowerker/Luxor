//
//  LXFeedCell.m
//  Luxor
//
//  Created by Daniel Ericsson on 2013-05-24.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import "LXFeedCell.h"
// Models
#import "LXFeed.h"
// Utils
#import <MAKVONotificationCenter/MAKVONotificationCenter.h>
#import <QuartzCore/QuartzCore.h>
#import "UIFont+LXAdditions.h"
#import "UIColor+LXAdditions.h"
#import "IADrawingUtilities.h"

@interface LXFeedCell ()

//@property (nonatomic, readwrite, strong) CATextLayer    *titleTextLayer;
//@property (nonatomic, readwrite, strong) CALayer        *feedImageLayer;
@property (nonatomic, readwrite, strong) UILabel    *titleLabel;
@property (nonatomic, readwrite, strong) UIFont     *titleFont;

@end

#define RIGHT_MARGIN  8.f
#define BOTTOM_MARGIN 6.f

@implementation LXFeedCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //self.titleTextLayer = [[CATextLayer alloc] init];
        self.contentView.backgroundColor = [UIColor randomColor];
        
        self.titleFont = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:16.f];
        [self.contentView addSubview:self.titleLabel];
        
        /*UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.f, 200.f)];
        view.backgroundColor = [UIColor redColor];
        self.selectedBackgroundView = view;*/
        
        /*self.titleTextLayer.font = titleFont.CGFont;
        self.titleTextLayer.fontSize = titleFont.pointSize;
        self.titleTextLayer.alignmentMode = kCAAlignmentRight;*/
        
        /*[self.layer addSublayer:self.titleTextLayer];
        [self.layer addSublayer:self.feedImageLayer];*/
    }
    
    return self;
}

- (void)dealloc {
    if (_feed) {
        [_feed removeAllObservers];
    }
}

#pragma mark - Public properties

- (void)setFeed:(LXFeed *)feed {
    if (_feed) {
        [_feed removeAllObservers];
    }
    
    _feed = feed;

    /*self.feedImageLayer.contents = feed.image;
    [_feed addObserver:self keyPath:@"image" options:NSKeyValueObservingOptionNew block:
     ^(MAKVONotification *notification) {
         //NSLog(@"New image: %@ of kind %d", [notification newValue], [notification kind]);
         //self.feed
    }];*/
    
    self.titleLabel.text = feed.title;
}


#pragma mark - Private properties

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = self.titleFont;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.numberOfLines = 0;
    }
    
    return _titleLabel;
}

#pragma mark - Layout

- (void)layoutSubviews {
    { // titleLabel
        [self.titleLabel sizeToFit];
        
        CGFloat newX = self.contentView.frame.size.width - (self.titleLabel.frame.size.width + RIGHT_MARGIN);
        CGFloat newY = self.contentView.frame.size.height - (self.titleLabel.frame.size.height + BOTTOM_MARGIN);
        
        self.titleLabel.frame = CGRectSetOrigin(self.titleLabel.frame, CGPointMake(newX, newY));
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    static UIColor *unselectedColor;
    
    if (highlighted) {
        unselectedColor = self.contentView.backgroundColor;
        CGFloat hue, saturation, brigthness, alpha;
        [unselectedColor getHue:&hue saturation:&saturation brightness:&brigthness alpha:&alpha];
        self.contentView.backgroundColor = [UIColor colorWithHue:hue
                                                      saturation:saturation*0.75f
                                                      brightness:brigthness*0.75f
                                                           alpha:alpha];
    } else {
        self.contentView.backgroundColor = unselectedColor;
    }
    
    [super setHighlighted:highlighted];
}

@end
