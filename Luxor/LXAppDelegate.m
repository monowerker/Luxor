//
//  LXAppDelegate.m
//  Luxor
//
//  Created by Daniel Ericsson on 2013-04-26.
//  Copyright (c) 2013 Monowerks. All rights reserved.
//

#import "LXAppDelegate.h"

// -- Controllers
#import "LXFeedsViewController.h"
// -- Utils
#import "LXFontLibrary.h"

@implementation LXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIViewController *viewController = [[LXFeedsViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];

    { // Navigation Bar
        navigationController.navigationBar.barStyle = UIBarStyleBlack;
        navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
