//
//  LXFeed.h
//  Luxor
//
//  Created by Daniel Ericsson on 2013-04-26.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXFeed : NSObject

@property (nonatomic, readwrite, strong) NSString   *title;
@property (nonatomic, readwrite, strong) NSString   *link;
@property (nonatomic, readwrite, strong) NSString   *pubDate;
@property (nonatomic, readwrite, strong) NSString   *lastBuildDate;
@property (nonatomic, readwrite, strong) NSString   *docs;
@property (nonatomic, readwrite, strong) NSString   *description;
@property (nonatomic, readwrite, strong) NSString   *language;
@property (nonatomic, readwrite, strong) NSArray    *items;
@property (nonatomic, readwrite, strong) NSString   *imageURLString;
@property (nonatomic, readwrite, strong) NSString   *imageTitle;
@property (nonatomic, readwrite, strong) NSString   *imageLink;
@property (nonatomic, readonly,  strong) UIImage    *image;

+ (id)feedFromURL:(NSURL *)url;

@end
