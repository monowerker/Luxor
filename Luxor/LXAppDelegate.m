//
//  LXAppDelegate.m
//  Luxor
//
//  Created by Daniel Ericsson on 2013-04-26.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import "LXAppDelegate.h"

#import "LXViewController.h"

@implementation LXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[LXViewController alloc] init];
    } else {
        self.viewController = [[LXViewController alloc] init];
    }

    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
