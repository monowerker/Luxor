//
//  UIColor+LXAdditions.h
//  Luxor
//
//  Created by Daniel Ericsson on 2013-05-26.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LXAdditions)

+ (UIColor *)colorFromHexString:(NSString *)hexString;
+ (UIColor *)randomColor;

@end
