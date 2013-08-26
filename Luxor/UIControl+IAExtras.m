//
//  UIControl+IAExtras.m
//  IACoreKit
//
//  Created by Simon Blommegård on 2011-09-29.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIControl+IAExtras.h"
#import "NSObject+IAExtras.h"

static char *kControlHandlersKey = "UIControlBlockHandlers";

#pragma mark - Private

@interface IAControlWrapper : NSObject <NSCopying>
@property (nonatomic, copy) IASenderBlock handler;
@property (nonatomic, assign) UIControlEvents controlEvents;
- (id)initWithHandler:(IASenderBlock)aHandler forControlEvents:(UIControlEvents)someControlEvents;
- (void)invoke:(id)sender;
@end

@implementation IAControlWrapper

@synthesize handler = _handler;
@synthesize controlEvents = _controlEvents;

- (id)initWithHandler:(IASenderBlock)aHandler forControlEvents:(UIControlEvents)someControlEvents {
	if ((self = [super init])) {
		self.handler = aHandler;
		self.controlEvents = someControlEvents;
	}
	return self;
}

- (id)copyWithZone:(NSZone *)zone {
	return [[IAControlWrapper alloc] initWithHandler:self.handler forControlEvents:self.controlEvents];
}

- (void)invoke:(id)sender {
	IASenderBlock block = self.handler;
	if (block) dispatch_async(dispatch_get_main_queue(), ^{ block(sender); });
}

- (void)dealloc {
	[self setHandler:nil];
	[super dealloc];
}
@end

@implementation UIControl (IAExtras)

- (void)addEventHandler:(IASenderBlock)handler forControlEvents:(UIControlEvents)controlEvents {
	NSMutableDictionary *events = [self associatedValueForKey:&kControlHandlersKey];
	if (!events) {
		events = [NSMutableDictionary dictionary];
		[self associateValue:events withKey:&kControlHandlersKey];
	}
	
	NSNumber *key = [NSNumber numberWithUnsignedInteger:controlEvents];
	NSMutableSet *handlers = [events objectForKey:key];
	if (!handlers) {
		handlers = [NSMutableSet set];
		[events setObject:handlers forKey:key];
	}
	
	IASenderBlock blockCopy = [[handler copy] autorelease];
	IAControlWrapper *target = [[IAControlWrapper alloc] initWithHandler:blockCopy forControlEvents:controlEvents];
	[handlers addObject:target];
	[self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
	[target release];
}

- (void)removeEventHandlersForControlEvents:(UIControlEvents)controlEvents {
	NSMutableDictionary *events = [self associatedValueForKey:&kControlHandlersKey];
	if (!events) {
		events = [NSMutableDictionary dictionary];
		[self associateValue:events withKey:&kControlHandlersKey];
	}
	
	NSNumber *key = [NSNumber numberWithUnsignedInteger:controlEvents];
	NSSet *handlers = [events objectForKey:key];
	
	if (!handlers)
		return;
	
	for (id sender in handlers)
		[self removeTarget:sender action:NULL forControlEvents:controlEvents];
	
	[events removeObjectForKey:key];
}

- (BOOL)hasEventHandlersForControlEvents:(UIControlEvents)controlEvents {
	NSMutableDictionary *events = [self associatedValueForKey:&kControlHandlersKey];
	if (!events) {
		events = [NSMutableDictionary dictionary];
		[self associateValue:events withKey:&kControlHandlersKey];
	}
	
	NSNumber *key = [NSNumber numberWithUnsignedInteger:controlEvents];
	NSSet *handlers = [events objectForKey:key];
	
	if (!handlers)
		return NO;
	
	return (handlers.count);
}

@end
