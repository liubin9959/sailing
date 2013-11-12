//
//  AppDelegate.m
//  Sailing
//
//  Created by tomaszbrue on 02.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import "AppDelegate.h"
#import "TBPoint.h"
#import "TBPolygon.h"
#import "TBSphere.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // wind
    self.wind = [[TBWind alloc] init];
    
    // boat
    self.boat = [[TBBoat alloc] init];
    self.boat.wind = self.wind;
    
    // polygon test
    TBPoint *p1 = [[TBPoint alloc] initWithLatitude:1 longitude:1];
    TBPoint *p2 = [[TBPoint alloc] initWithLatitude:2 longitude:4];
    TBPoint *p3 = [[TBPoint alloc] initWithLatitude:5 longitude:5];
    TBPoint *p4 = [[TBPoint alloc] initWithLatitude:6 longitude:2];
    TBPoint *p5 = [[TBPoint alloc] initWithLatitude:3 longitude:1];
    
    TBPolygon *poly = [[TBPolygon alloc] initWithPoints:@[p1, p2, p3, p4, p5]];
    TBSphere *sphere = [[TBSphere alloc] initWithPolygons:@[poly]];
    
    TBPoint *test = [[TBPoint alloc] initWithLatitude:2 longitude:2];
    NSLog(@"%@", [sphere isWater:test]);

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
