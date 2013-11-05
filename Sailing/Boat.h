//
//  Boat.h
//  Sailing
//
//  Created by tomaszbrue on 02.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wind.h"
#import "Enums.h"

@interface Boat : NSObject

// hard facts
@property double heading;
@property double speed;
@property CLLocationCoordinate2D position;

// sail facts
@property int course;

// wind facts
@property (nonatomic, retain) Wind *wind;

// Methods
- (enum SIDE)getBoom;

@end
