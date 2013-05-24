//
//  NSObject+IAExtras.h
//  IACoreKit
//
//  Copyright iDeal Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IACoreKitGlobals.h"

@interface NSObject (IAExtras)

// Associated Object
- (void)associateValue:(id)value withKey:(void *)key;
- (void)associateCopyOfValue:(id)value withKey:(void *)key;
- (void)weaklyAssociateValue:(id)value withKey:(void *)key;
- (id)associatedValueForKey:(void *)key;

// The instance class' name
- (NSString*)className;

// [[copy] autorelease]
- (id)freeze;

// Executes a block after a given delay on the reciever
- (id)performBlock:(IASenderBlock)block afterDelay:(NSTimeInterval)delay;

// Executes a block after a given delay
+ (id)performBlock:(IABlock)block afterDelay:(NSTimeInterval)delay;

// Cancels the potential execution of a block
+ (void)cancelBlock:(id)block;

@end
