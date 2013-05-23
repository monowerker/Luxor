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

@end

@implementation LXFeedParser

- (id)initWithData:(NSData *)data {
    if (self = [super initWithData:data]) {
        self.delegate = self;
        self.currentString = [[NSMutableString alloc] init];
    }

    return self;
}


#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {

    self.currentKey = elementName;
    
    if ([elementName isEqualToString:@"channel"]) {
        self.feed = [[LXFeed alloc] init];
        self.currentItem = self.feed;
    }

    if ([elementName isEqualToString:@"item"]) {
        self.currentItem = [[LXItem alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

    if (![elementName isEqualToString:@"channel"] && ![elementName isEqualToString:@"item"]) {
        NSString *trimmedString =
        [self.currentString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [self.currentItem setValue:trimmedString forKey:self.currentKey];
    }

    if ([elementName isEqualToString:@"item"]) {
        [self.items addObject:self.currentItem];
    }

    if ([elementName isEqualToString:@"channel"]) {
        self.feed.items = self.items;
    }

    self.currentString = [[NSMutableString alloc] init];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.currentString appendString:string];
}

@end
