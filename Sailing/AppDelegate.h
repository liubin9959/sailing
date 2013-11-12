//
//  AppDelegate.h
//  Sailing
//
//  Created by tomaszbrue on 02.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBWind.h"
#import "TBBoat.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// physical
@property TBBoat *boat;
@property TBWind *wind;

@end
