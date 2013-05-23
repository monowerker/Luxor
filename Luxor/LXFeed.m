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

@implementation LXFeed

+ (id)feedFromURL:(NSURL *)url {
    LXFeedParser *parser = [[LXFeedParser alloc] initWithContentsOfURL:url];

    if (![parser parse]) {
        NSLog(@"Parser error: %@", [[parser parserError] localizedDescription]);
    } else {
        return parser.feed;
    }

    return nil;
}

- (NSString *)description {
    return [super description];
}

@end
