//
//  LXItem.h
//  Luxor
//
//  Created by Daniel Ericsson on 2013-05-23.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXItem : NSObject

@property (nonatomic, readwrite, strong) NSString *title;
@property (nonatomic, readwrite, strong) NSString *link;
@property (nonatomic, readwrite, strong) NSString *description;
@property (nonatomic, readwrite, strong) NSString *pubDate;
@property (nonatomic, readwrite, strong) NSString *guid;

@end
