//
//  LXAppDelegate.m
//  Luxor
//
//  Created by Daniel Ericsson on 2013-04-26.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import "LXAppDelegate.h"
#import "LXFeedsViewController.h"

@implementation LXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UIViewController *viewController = [[LXFeedsViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    navigationController.navigationBarHidden = YES;
    
    self.viewController = navigationController;

    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
