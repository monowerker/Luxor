#import "UIGestureRecognizer+IAExtras.h"
#import "NSObject+IAExtras.h"

static char *kGestureRecognizerBlockKey = "IAGestureRecognizerBlock";
static char *kGestureRecognizerDelayKey = "IAGestureRecognizerDelay";
static char *kGestureRecognizerCancelRefKey = "IAGestureRecognizerCancellationBlock";

@interface UIGestureRecognizer (IAExtrasInternal)
- (void)handleAction:(id)sender;
- (void)handleActionUsingDelay:(id)sender;
@end

@implementation UIGestureRecognizer (IAExtrasInternal)

- (void)handleAction:(id)sender {
	IAGestureRecognizerBlock block = self.handler;
	if (block) {
		UIGestureRecognizerState state = self.state;
		CGPoint location = [self locationInView:self.view];
		block(self, state, location);
	}
}

- (void)handleActionUsingDelay:(id)sender {
	IAGestureRecognizerBlock block = self.handler;
	if (block) {
		UIGestureRecognizerState state = self.state;
		CGPoint location = [self locationInView:self.view];
		
		id cancel = [NSObject performBlock:^{
			block(self, state, location);
		} afterDelay:self.delay];
		[self associateCopyOfValue:cancel withKey:kGestureRecognizerCancelRefKey];
	}
}

@end

@implementation UIGestureRecognizer (IAExtras)

+ (id)recognizerWithHandler:(IAGestureRecognizerBlock)block delay:(NSTimeInterval)delay {
    return [[[self class] alloc] initWithHandler:block delay:delay];
}

- (id)initWithHandler:(IAGestureRecognizerBlock)block delay:(NSTimeInterval)delay {
	if ((self = [self init])) {
    [self setHandler:block];
    [self setDelay:delay];
	}
	return self;
}

+ (id)recognizerWithHandler:(IAGestureRecognizerBlock)block {
    return [self recognizerWithHandler:block delay:0.0];
}

- (id)initWithHandler:(IAGestureRecognizerBlock)block {
    return [self initWithHandler:block delay:0.0];
}

- (void)setHandler:(IAGestureRecognizerBlock)handler {
    [self associateCopyOfValue:handler withKey:kGestureRecognizerBlockKey];
}

- (IAGestureRecognizerBlock)handler {
    return [self associatedValueForKey:kGestureRecognizerBlockKey];
}

- (void)setDelay:(NSTimeInterval)delay {
    [self removeTarget:self action:NULL];
    if (delay)
        [self addTarget:self action:@selector(handleActionUsingDelay:)];
    else
        [self addTarget:self action:@selector(handleAction:)];
    [self associateValue:[NSNumber numberWithDouble:(delay) ? delay : 0.0] withKey:kGestureRecognizerDelayKey];
}

- (NSTimeInterval)delay {
    NSNumber *delay = [self associatedValueForKey:kGestureRecognizerDelayKey];
    if (delay)
        return [delay doubleValue];
    else
        return 0.0;
}

- (void)cancel {
    id cancel = [self associatedValueForKey:kGestureRecognizerCancelRefKey];
    if (cancel)
        [NSObject cancelBlock:cancel];
}

@end
