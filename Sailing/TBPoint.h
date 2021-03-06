//
//  TBPoint.h
//  Sailing
//
//  Created by tomaszbrue on 12.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface TBPoint : CLLocation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;
- (CLLocationCoordinate2D)getCoordinate;
- (CLLocationDegrees)getLatitude;
- (CLLocationDegrees)getLongitude;
- (CLLocationDistance)distanceToPoint:(TBPoint *)point;

@end
