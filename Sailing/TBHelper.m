//
//  Helper.m
//  Sailing
//
//  Created by tomaszbrue on 04.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import "TBHelper.h"
#import <math.h>

@implementation TBHelper

+ (NSString *)courseToDirection:(double)course
{
    NSArray *directions = [NSArray arrayWithObjects:@"N", @"NE", @"E", @"SE", @"S", @"SW", @"W", @"NW", nil];
    int i = ceil(fmod(((course - 22.5) / 45), 8));
    if (i == 8) {
        i = 0;
    }
    
    return directions[i];
}

@end
