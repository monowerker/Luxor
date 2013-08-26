//
//  LXButtonFactory.m
//  Luxor
//
//  Created by Daniel Ericsson on 2013-08-25.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import "LXButtonFactory.h"
// -- Utils
#import "UIControl+IAExtras.h"
#import "LXFontLibrary.h"
#import <QuartzCore/QuartzCore.h>

@implementation LXButtonFactory

+ (UIButton *)buttonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.backgroundColor = [UIColor blackColor];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    button.titleLabel.font = [LXFontLibrary buttonFont16];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[LXButtonFactory backgroundImage] forState:UIControlStateHighlighted];
    
    button.layer.borderWidth = 1.f;
    button.layer.cornerRadius = 4.f;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.masksToBounds = YES;
    
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    return button;
}

+ (UIImage *)backgroundImage {
    static UIImage *image = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGSize imageSize = CGSizeMake(16, 16);
        
        UIGraphicsBeginImageContextWithOptions(imageSize, YES, 1.0);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [[UIColor whiteColor] setFill];
        CGContextFillRect(ctx, CGRectMake(0, 0, imageSize.width, imageSize.height));
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    });
    
    return image;
}

@end
