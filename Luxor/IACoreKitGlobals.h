//
//  IACoreKitGlobals.h
//  IACoreKit
//
//  Copyright iDeal Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

#define returnStatic(THING) \
static id thing = nil; \
if (!thing) \
thing = THING; \
return thing

typedef void(^IABlock)(void); // compatible with dispatch_block_t
typedef void(^IASenderBlock)(id sender);
typedef void(^IAGestureRecognizerBlock)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location);
typedef void (^UITableViewInitializationBlock)(id cell);
typedef void (^IAObservationBlock)(id obj, NSDictionary *change);