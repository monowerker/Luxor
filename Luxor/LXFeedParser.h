//
//  LXFeedParser.h
//  Luxor
//
//  Created by Daniel Ericsson on 2013-04-27.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LXFeed;

@interface LXFeedParser : NSXMLParser <NSXMLParserDelegate>

@property (nonatomic, readonly) LXFeed *feed;

@end
