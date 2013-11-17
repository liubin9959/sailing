//
//  Wind.m
//  Sailing
//
//  Created by tomaszbrue on 02.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import "TBWind.h"

@implementation TBWind

- (id)init
{
    self.bearing = [[TBBearing alloc] initWithValue:0];
    return self;
}

@end
