//
//  TBLine.h
//  Sailing
//
//  Created by tomaszbrue on 16.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBPoint.h"
#import "TBSphere.h"
#import "TBWind.h"
#import "TBEnums.h"

@interface TBLine : NSObject

@property (nonatomic, retain) TBPoint *start;
@property (nonatomic, retain) TBPoint *destination;
@property (nonatomic, retain) TBSphere *sphere;

- (id)initWithStart:(TBPoint *)start andDestination:(TBPoint *)destination andSphere:(TBSphere *)sphere;
- (int)length;
- (TBPoint *)center;
- (BOOL)intersectsLandWithAccuracyInMeters:(int)accuracy;
- (TBBearing *)bearing;
- (enum COURSE)courseToWind:(TBWind *)wind;

@end
