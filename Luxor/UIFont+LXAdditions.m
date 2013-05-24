//
//  UIFont+LXAdditions.m
//  Luxor
//
//  Created by Daniel Ericsson on 2013-05-26.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import "UIFont+LXAdditions.h"

@implementation UIFont (LXAdditions)

- (CGFontRef)CGFont {
    return CGFontCreateWithFontName((__bridge CFStringRef)(self.fontName));
}

@end
