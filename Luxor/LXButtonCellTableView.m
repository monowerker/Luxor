//
//  LXButtonCellTableView.m
//  Luxor
//
//  Created by Daniel Ericsson on 2013-08-26.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import "LXButtonCellTableView.h"

@implementation LXButtonCellTableView

/*
 http://www.charlesharley.com/2013/programming/uibutton-in-uitableviewcell-has-no-highlight-state/
 
*/
- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    // Because we set delaysContentTouches = NO, we return YES for UIButtons
    // so that scrolling works correctly when the scroll gesture
    // starts in the UIButtons.
    NSLog(@"%d", self.delaysContentTouches);
    
    if ([view isKindOfClass:[UIButton class]]) {
        return YES;
    }
    
    return [super touchesShouldCancelInContentView:view];
}

@end
