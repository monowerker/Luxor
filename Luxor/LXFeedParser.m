//
//  LXFeedParser.m
//  Luxor
//
//  Created by Daniel Ericsson on 2013-04-27.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import "LXFeedParser.h"
// Models
#import "LXItem.h"
#import "LXFeed.h"

@interface LXFeedParser ()

@property (nonatomic, readwrite, strong) LXFeed *feed;
@property (nonatomic, readwrite, strong) id currentItem;
@property (nonatomic, readwrite, strong) NSString *currentKey;
@property (nonatomic, readwrite, strong) NSMutableString *currentString;
@property (nonatomic, readwrite, strong) NSMutableArray *items;
@property (nonatomic, readwrite, assign) BOOL channelCtx;
@property (nonatomic, readwrite, assign) BOOL itemCtx;
@property (nonatomic, readwrite, assign) BOOL imageCtx;

@end

@implementation LXFeedParser

- (id)initWithData:(NSData *)data {
    if (self = [super initWithData:data]) {
        self.delegate = self;
        self.items = [[NSMutableArray alloc] init];
        self.currentString = [[NSMutableString alloc] init];
        self.imageCtx = NO;
        self.itemCtx = NO;
        self.channelCtx = NO;
    }

    return self;
}


#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {

    self.currentKey = elementName;
    
    if ([elementName isEqualToString:@"channel"]) {
        self.channelCtx = YES;
        self.feed = [[LXFeed alloc] init];
        self.currentItem = self.feed;
    }

    if ([elementName isEqualToString:@"item"]) {
        self.itemCtx = YES;
        self.currentItem = [[LXItem alloc] init];
    }
    
    if ([elementName isEqualToString:@"image"]) {
        self.imageCtx = YES;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

    NSString *trimmedString =
    [self.currentString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // Channel elements
    if (self.channelCtx && !self.itemCtx && !self.imageCtx) {
        [self.feed setValue:trimmedString forKey:self.currentKey];
    }
    
    // Item elements
    if (![elementName isEqualToString:@"channel"] && ![elementName isEqualToString:@"item"] && self.itemCtx) {
        [self.currentItem setValue:trimmedString forKey:self.currentKey];
    }
    
    if (self.imageCtx && [elementName isEqualToString:@"url"]) {
        self.feed.imageLink = trimmedString;
    }
    
    if ([elementName isEqualToString:@"item"]) {
        self.itemCtx = NO;
        [self.items addObject:self.currentItem];
    }

    if ([elementName isEqualToString:@"channel"]) {
        self.channelCtx = NO;
        self.feed.items = self.items;
    }
    
    if ([elementName isEqualToString:@"image"]) {
        self.imageCtx = NO;
    }

    self.currentString = [[NSMutableString alloc] init];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.currentString appendString:string];
}

@end
