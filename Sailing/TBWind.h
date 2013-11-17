//
//  Wind.h
//  Sailing
//
//  Created by tomaszbrue on 02.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBBearing.h"

@interface TBWind : NSObject

@property double speed;
@property (nonatomic, retain) TBBearing *bearing;

- (id)init;

@end
