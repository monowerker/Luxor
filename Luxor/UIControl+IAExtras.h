//
//  UIControl+IAExtras.h
//  IACoreKit
//
//  Copyright iDeal Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IACoreKitGlobals.h"

@interface UIControl (IAExtras)

// Adds a block for a particular event to an internal dispatch table
- (void)addEventHandler:(IASenderBlock)handler forControlEvents:(UIControlEvents)controlEvents;

// Removes all blocks for a particular event combination
- (void)removeEventHandlersForControlEvents:(UIControlEvents)controlEvents;

// Checks to see if the control has any blocks for a particular event combination
- (BOOL)hasEventHandlersForControlEvents:(UIControlEvents)controlEvents;

@end
