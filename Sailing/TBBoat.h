//
//  Boat.h
//  Sailing
//
//  Created by tomaszbrue on 02.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBWind.h"
#import "TBEnums.h"
#import "TBPoint.h"

@interface TBBoat : NSObject

// hard facts
@property (nonatomic, retain) TBBearing *bearing;
@property double speed;
@property (nonatomic, retain) TBPoint *position;

// sail facts
@property int course;

// wind facts
@property (nonatomic, retain) TBWind *wind;

// Methods
- (enum SIDE)getBoom;
- (id)init;

@end
