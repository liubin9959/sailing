//
//  Routing.h
//  Sailing
//
//  Created by tomaszbrue on 05.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wind.h"
#import "Boat.h"

@interface Routing : NSObject

@property CLLocationCoordinate2D destination;
@property (nonatomic, retain) Wind *wind;
@property (nonatomic, retain) Boat *boat;

- (id)initWithBoat:(Boat *)boat andWind:(Wind *)wind andFinalDestination:(CLLocationCoordinate2D)destination;
- (NSArray *)start;

@end
