//
//  LXFeed.m
//  Luxor
//
//  Created by Daniel Ericsson on 2013-04-26.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import "LXFeed.h"
// Controllers
#import "LXFeedParser.h"
// Utils
#import <AFNetworking/AFNetworking.h>

@interface LXFeed ()

@property (nonatomic, readwrite, strong) UIImage *image;
@property (nonatomic, readwrite, assign) BOOL isFetchingImage;
@property (nonatomic, readwrite, strong) dispatch_queue_t lockqueue;

@end

@implementation LXFeed

@synthesize image = _image;


#pragma mark - Public methods

+ (id)feedFromURL:(NSURL *)url {
    LXFeedParser *parser = [[LXFeedParser alloc] initWithContentsOfURL:url];

    if (![parser parse]) {
        NSLog(@"Parser error: %@", [[parser parserError] localizedDescription]);
    } else {
        return parser.feed;
    }

    return nil;
}


#pragma mark - Public properties

- (UIImage *)image {
    if (!self.imageLink) {
        return nil;
    }
    
    if (_image) {
        return _image;
    } else {
        __weak LXFeed *weakSelf = self;
        dispatch_sync(self.lockqueue, ^{
            LXFeed *strongSelf = weakSelf;
            if (strongSelf.isFetchingImage) {
                return;
            }
            strongSelf.isFetchingImage = YES;
            
            NSURL *imageURL = [NSURL URLWithString:strongSelf.imageLink];
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:imageURL];
            
            AFImageRequestOperation *imageRequestOp =
            [AFImageRequestOperation imageRequestOperationWithRequest:urlRequest success:
             ^(UIImage *image) {
                strongSelf.image = image;
                 strongSelf.isFetchingImage = NO;
            }];
            
            [imageRequestOp start];
        });
    }
    
    return nil;
}


#pragma mark - Private properties

- (dispatch_queue_t)lockqueue {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _lockqueue = dispatch_queue_create("lockqueue", DISPATCH_QUEUE_SERIAL);
    });
    
    return _lockqueue;
}

#pragma mark - KVO

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%@: Trying to set undefined key: %@", NSStringFromClass([self class]), key);
}

@end
