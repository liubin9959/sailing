//
//  Boat.m
//  Sailing
//
//  Created by tomaszbrue on 02.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import "TBBoat.h"

@implementation TBBoat

- (id)init
{
    self.bearing = [[TBBearing alloc] initWithValue:0];
    self.position = [[TBPoint alloc] init];
    
    return self;
}

// returns the position of the boom
- (enum SIDE)getBoom
{
    double wind_bearing = 0;
    if (self.wind != nil)
    {
        wind_bearing = self.wind.bearing.value;
    }
    
    // compute boom position
    if (self.bearing.value >= 315 + wind_bearing && self.bearing.value <= 45 + wind_bearing)
    {
        return Spilling;
    }
    else if(self.bearing.value > 45 + wind_bearing && self.bearing.value <= 175 + wind_bearing)
    {
        return Starboard;
    }
    else if(self.bearing.value > 175 + wind_bearing && self.bearing.value < 185 + wind_bearing)
    {
        return Either;
    }
    else
    {
        return Portside;
    }
}

@end
