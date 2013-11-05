//
//  Routing.m
//  Sailing
//
//  Created by tomaszbrue on 05.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import "Routing.h"

@implementation Routing

- (id)initWithBoat:(Boat *)boat andWind:(Wind *)wind andFinalDestination:(CLLocationCoordinate2D)destination
{
    self.boat = boat;
    self.wind = wind;
    self.destination = destination;
    
    return self;
}

- (NSArray *)start
{
    
    return nil;
}

@end
