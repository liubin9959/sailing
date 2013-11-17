//
//  TBBearing.m
//  Sailing
//
//  Created by tomaszbrue on 17.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import "TBBearing.h"
#import <math.h>

@implementation TBBearing

/*
 inits with a value
 */
- (id)initWithValue:(double)value
{
    self.value = value;
    return self;
}

/*
 calculates the absolute angle between to courses
 */
- (double)angleTo:(TBBearing *)other
{
    double a = fabs(self.value - other.value);
    double b = fabs(other.value - self.value);
    
    if (a <= 180 && b > 180)
    {
        return a;
    }
    else
    {
        return b;
    }
}

/*
 displays the bearing in an human readable direction
 */
- (NSString *)toDirection
{
    NSArray *directions = [NSArray arrayWithObjects:@"N", @"NE", @"E", @"SE", @"S", @"SW", @"W", @"NW", nil];
    int i = ceil(fmod(((self.value - 22.5) / 45), 8));
    if (i == 8)
    {
        i = 0;
    }
    
    return directions[i];
}

@end
