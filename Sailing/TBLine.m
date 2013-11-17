//
//  TBLine.m
//  Sailing
//
//  Created by tomaszbrue on 16.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import "TBLine.h"
#import <math.h>

@implementation TBLine

/*
 init with start and destination
 */
- (id)initWithStart:(TBPoint *)start andDestination:(TBPoint *)destination andSphere:(TBSphere *)sphere
{
    self.start = start;
    self.destination = destination;
    self.sphere = sphere;
    
    return self;
}

/*
 returns the length of the line
 */
- (int)length
{
    return [self.start distanceToPoint:self.destination];
}

/*
 returns the point exactly in the center of
 the line
 */
- (TBPoint *)center
{
    double new_x = ([self.start getLatitude] + [self.destination getLatitude]) / 2;
    double new_y = ([self.start getLongitude] + [self.destination getLongitude]) / 2;
    
    return [[TBPoint alloc] initWithLatitude:new_x longitude:new_y];
}

/*
 does this line intersects land?
 checks will be performed with an accuracy that can
 be set in meters
 */
- (BOOL)intersectsLandWithAccuracyInMeters:(int)accuracy
{
    if ([self length] >= accuracy)
    {
        TBLine *left = [[TBLine alloc] initWithStart:self.start andDestination:[self center] andSphere:self.sphere];
        TBLine *right = [[TBLine alloc] initWithStart:[self center] andDestination:self.destination andSphere:self.sphere];
        return ([left intersectsLandWithAccuracyInMeters:accuracy] || [right intersectsLandWithAccuracyInMeters:accuracy]);
    }
    else
    {
        return [self.sphere isWater:[self center]];
    }
}

/*
 calculate the bearing of the line
 from start to destination
 */
- (TBBearing *)bearing
{
    double dLon = [self.destination getLongitude] - [self.start getLongitude];
    double x = sin(dLon) * cos([self.destination getLatitude]);
    double y = cos([self.start getLatitude]) * sin([self. destination getLatitude]) - sin([self.start getLatitude]) * cos([self.destination getLatitude]) * cos(dLon);
    double brng = fmod((atan2(y, x) + 180), 360);
    return [[TBBearing alloc] initWithValue:brng];
}

/*
 returns the course to the wind this line would
 be traveled at
 */
- (enum COURSE)courseToWind:(TBWind *)wind
{
    double angle = [[self bearing] angleTo:wind.bearing];
    
    // In irons
    if (angle < 45)
    {
        return InIrons;
    }
    else if (angle >= 45 && angle < 60)
    {
        return CloseHauled;
    }
    else if(angle >= 60 && angle < 100)
    {
        return BeamReach;
    }
    else if (angle >= 100 && angle < 170)
    {
        return BroadReach;
    }
    else {
        return Running;
    }
}

@end
