//
//  AppDelegate.m
//  PlayingWithUIKitDynamics
//
//  Created by Michael Vilabrera on 8/11/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "AppDelegate.h"

#import "GravityViewController.h"

@interface AppDelegate()

@property (nonatomic, strong) GravityViewController *gravityVC;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.gravityVC = [[GravityViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = self.gravityVC;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
