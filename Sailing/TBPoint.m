//
//  TBPoint.m
//  Sailing
//
//  Created by tomaszbrue on 12.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import "TBPoint.h"

@implementation TBPoint

/* 
 initializes a point form a coordinate
 */
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    return [self initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
}

/* 
 returns the coordinate
 */
- (CLLocationCoordinate2D)getCoordinate
{
    return self.coordinate;
}

/*
 returns the latitude
 */
- (double)getLatitude
{
    return self.coordinate.latitude;
}

/* 
 returns the longitude
 */
- (double)getLongitude
{
    return self.coordinate.longitude;
}

/*
 returns the distance to the point in meters
 */
- (double)distanceToPoint:(TBPoint *)point
{
    return [self distanceFromLocation:point];
}

@end
