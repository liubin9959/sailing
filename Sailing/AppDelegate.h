//
//  AppDelegate.h
//  Sailing
//
//  Created by tomaszbrue on 02.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Wind.h"
#import "Boat.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// physical
@property Boat *boat;
@property Wind *wind;

@end
