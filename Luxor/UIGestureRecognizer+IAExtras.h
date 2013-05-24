//
//  UIGestureRecognizer+IAExtras.h
//  IACoreKit
//
//  Copyright iDeal Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IACoreKitGlobals.h"

@interface UIGestureRecognizer (IAExtras)

// An autoreleased gesture recognizer that will, on firing, call the given block asynchronously after a number of seconds
+ (id)recognizerWithHandler:(IAGestureRecognizerBlock)block delay:(NSTimeInterval)delay;

// Initializes an allocated gesture recognizer that will call the given block after a given delay
- (id)initWithHandler:(IAGestureRecognizerBlock)block delay:(NSTimeInterval)delay;

// An autoreleased gesture recognizer that will call the given block
+ (id)recognizerWithHandler:(IAGestureRecognizerBlock)block;

// Initializes an allocated gesture recognizer that will call the given block
- (id)initWithHandler:(IAGestureRecognizerBlock)block;

// Allows the block that will be fired by the gesture recognizer to be modified after the fact
@property (nonatomic, copy) IAGestureRecognizerBlock handler;

// Allows the length of the delay after which the gesture recognizer will be fired to modify
@property (nonatomic, assign) NSTimeInterval delay;

// If the recognizer happens to be fired, calling this method, only when delayed
- (void)cancel;

@end