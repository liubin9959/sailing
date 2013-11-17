//
//  Routing.h
//  Sailing
//
//  Created by tomaszbrue on 05.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBWind.h"
#import "TBSphere.h"
#import "TBBoat.h"

@interface TBRouting : NSObject

@property (nonatomic, retain) TBWind *wind;
@property (nonatomic, retain) TBBoat *boat;
@property (nonatomic, retain) TBSphere *sphere;

- (id)initWithBoat:(TBBoat *)boat andWind:(TBWind *)wind andSphere:(TBSphere *)sphere;
- (NSArray *)routeTo:(TBPoint *)point;

@end
