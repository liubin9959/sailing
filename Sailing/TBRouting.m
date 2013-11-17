//
//  Routing.m
//  Sailing
//
//  Created by tomaszbrue on 05.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import "TBRouting.h"
#import "TBLine.h"

@implementation TBRouting

- (id)initWithBoat:(TBBoat *)boat andWind:(TBWind *)wind andSphere:(TBSphere *)sphere
{
    self.boat = boat;
    self.wind = wind;
    self.sphere = sphere;
    
    return self;
}

/*
 calculates a route from the boat position to
 a final destination
 */
- (NSArray *)routeTo:(TBPoint *)point
{
    NSMutableArray *elements = [[NSMutableArray alloc] init];
    
    // check direct line
    TBLine *direct = [[TBLine alloc] initWithStart:self.boat.position andDestination:point andSphere:self.sphere];
    if ([direct intersectsLandWithAccuracyInMeters:1])
    {
        [elements addObject:direct];
    }
    
    return elements;
}

@end
