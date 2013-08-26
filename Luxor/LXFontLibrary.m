//
//  LXFontLibrary.m
//  Luxor
//
//  Created by Daniel Ericsson on 2013-08-25.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import "LXFontLibrary.h"

@implementation LXFontLibrary

+ (UIFont *)navigationBarTitleFont {
    static UIFont *font = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        font = [UIFont fontWithName:@"AvenirNextCondensed-Demibold" size:16.f];
    });
    
    return font;
}

+ (UIFont *)buttonFont16 {
    UIFont *font = [UIFont fontWithName:@"AvenirNextCondensed-Demibold" size:16.f];
    
    return font;
}

@end
