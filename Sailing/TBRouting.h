//
//  Routing.h
//  Sailing
//
//  Created by tomaszbrue on 05.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBWind.h"
#import "TBBoat.h"

@interface TBRouting : NSObject

@property CLLocationCoordinate2D destination;
@property (nonatomic, retain) TBWind *wind;
@property (nonatomic, retain) TBBoat *boat;

- (id)initWithBoat:(TBBoat *)boat andWind:(TBWind *)wind andFinalDestination:(CLLocationCoordinate2D)destination;
- (NSArray *)start;

@end
