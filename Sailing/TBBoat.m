//
//  Boat.m
//  Sailing
//
//  Created by tomaszbrue on 02.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import "TBBoat.h"

@implementation TBBoat

// returns the position of the boom
- (enum SIDE)getBoom
{
    double wind_heading = 0;
    if (self.wind != nil)
    {
        wind_heading = self.wind.heading;
    }
    
    // compute boom position
    if (self.heading >= 315 + wind_heading && self.heading <= 45 + wind_heading)
    {
        return Spilling;
    }
    else if(self.heading > 45 + wind_heading && self.heading <= 175 + wind_heading)
    {
        return Starboard;
    }
    else if(self.heading > 175 + wind_heading && self.heading < 185 + wind_heading)
    {
        return Either;
    }
    else
    {
        return Portside;
    }
}

@end
