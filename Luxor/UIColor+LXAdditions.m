//
//  UIColor+LXAdditions.m
//  Luxor
//
//  Created by Daniel Ericsson on 2013-05-26.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import "UIColor+LXAdditions.h"

@implementation UIColor (LXAdditions)

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    const char *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
                           cStringUsingEncoding:NSASCIIStringEncoding];
    
    if (cString[0] != '#' || strlen(cString) != 7) {
        return nil;
    }
    
    int redValue, greenValue, blueValue;
    
    if(!(sscanf(&cString[1], "%2x", &redValue) == 1)) {
        return nil;
    }
    
    if(!(sscanf(&cString[3], "%2x", &greenValue) == 1)) {
        return nil;
    }
    
    if(!(sscanf(&cString[5], "%2x", &blueValue) == 1)) {
        return nil;
    }
    
    return [UIColor colorWithRed:redValue/255.f
                           green:greenValue/255.f
                            blue:blueValue/255.f alpha:1.0];
}

+ (UIColor *)randomColor {
    // The saturation and brightness is offset by .5 to make the colors look a bit nicer
    return [UIColor colorWithHue:(arc4random()%256 / 256.)
                      saturation:(arc4random()%128 / 256.) + .5
                      brightness:(arc4random()%128 / 256.) + .5
                           alpha:1.];
}

@end
