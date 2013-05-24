#import "NSObject+IAExtras.h"
#import <objc/runtime.h>

typedef void(^IAInternalWrappingBlock)(BOOL cancel);

static inline dispatch_time_t dTimeDelay(NSTimeInterval time) {
	int64_t delta = (NSEC_PER_SEC * time);
	return dispatch_time(DISPATCH_TIME_NOW, delta);
}

@implementation NSObject (IAExtras)

- (void)associateValue:(id)value withKey:(void *)key {
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)associateCopyOfValue:(id)value withKey:(void *)key {
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY);
}

- (void)weaklyAssociateValue:(id)value withKey:(void *)key {
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id)associatedValueForKey:(void *)key {
	return objc_getAssociatedObject(self, key);
}

- (NSString*)className {
	return NSStringFromClass([self class]);
}

- (id)freeze {
	return [self copy];
}

- (id)performBlock:(IASenderBlock)block afterDelay:(NSTimeInterval)delay {
	if (!block) return nil;
	
	__block BOOL cancelled = NO;
	
	IAInternalWrappingBlock wrapper = ^(BOOL cancel) {
		if (cancel) {
			cancelled = YES;
			return;
		}
		if (!cancelled) block(self);
	};
	
	dispatch_after(dTimeDelay(delay), dispatch_get_main_queue(), ^{  wrapper(NO); });
	
	return [wrapper freeze];
}

+ (id)performBlock:(IABlock)block afterDelay:(NSTimeInterval)delay {
	if (!block) return nil;
	
	__block BOOL cancelled = NO;
	
	IAInternalWrappingBlock wrapper = ^(BOOL cancel) {
		if (cancel) {
			cancelled = YES;
			return;
		}
		if (!cancelled) block();
	};
	
	dispatch_after(dTimeDelay(delay), dispatch_get_main_queue(), ^{ wrapper(NO); });
	
	return [wrapper freeze];
}

+ (void)cancelBlock:(id)block {
	if (!block) return;
	IAInternalWrappingBlock wrapper = block;
	wrapper(YES);
}

@end
