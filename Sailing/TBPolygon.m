//
//  TBPolygon.m
//  Sailing
//
//  Created by tomaszbrue on 12.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import "TBPolygon.h"
#import <float.h>

@implementation TBPolygon

- (id)init
{
    self.outer = [[NSMutableArray alloc] init];
    self.inner = [[NSMutableArray alloc] init];
    return self;
}

- (id)initWithOuter:(NSArray *)points
{
    self.outer = [[NSMutableArray alloc] initWithArray:points];
    self.inner = [[NSMutableArray alloc] init];

    return self;
}

- (id)initWithOuter:(NSArray *)outerPoints andInner:(NSArray *)innerPolygons
{
    self.outer = [[NSMutableArray alloc] initWithArray:outerPoints];
    self.inner = [[NSMutableArray alloc] initWithArray:innerPolygons];
    
    return self;
}

/* 
 add polygon member 
 */
- (void)addOuter:(TBPoint *)point
{
    [self.outer addObject:point];
}

- (void)addInner:(TBPolygon *)polygon
{
    [self.inner addObject:polygon];
}

/* 
 get the coordinate at an index of the polygon
 vertex array 
 */
- (TBPoint *)getPointAt:(int)index
{
    return ((TBPoint *)[self.outer objectAtIndex:index]);
}

/*
 calculates the closest member of the outer
 polygon to a reference point 
 */
- (TBPoint *)getClosestTo:(TBPoint *)point
{
    TBPoint *min;
    double min_dist = DBL_MAX;
    
    for (TBPoint *candid in self.outer)
    {
        double dist = [candid distanceToPoint:point];
        if (dist < min_dist) {
            min_dist = dist;
            min = candid;
        }
    }
    
    return min;
}

/*
 tests if a point is in the polygon or not;
 even considers that polygons can have inner
 polygons and excludes them
 */
- (BOOL)isPointInPolygon:(TBPoint *)p
{
    int i, j, c = 0;
    for (i = 0, j = self.outer.count - 1; i < self.outer.count; j = i++)
    {
        TBPoint *a = [self getPointAt:i];
        TBPoint *b = [self getPointAt:j];
        if ((([a getLongitude] > [p getLongitude]) != ([b getLongitude] > [p getLongitude])) &&
            ([p getLatitude] < ([b getLatitude] - [a getLatitude]) * ([p getLongitude] - [a getLongitude]) / ([b getLongitude] - [a getLongitude]) + [a getLatitude]))
        {
            c = !c;
        }
    }
    
    // lies inside if c == 1
    BOOL result = (c == 1);
    
    // if ithe point lies inside, we have to check if there are inner
    // polygons and exclude them from the calculation
    if (result == NO)
    {
        return NO;
    }
    else
    {
        if (self.inner.count == 0)
        {
            return YES;
        }
        else
        {
            // check if the point lies in any of the inner polygons.
            // if YES, then the answer of this function is: NO
            // if NO, then the answer of this function is: YES
            for(TBPolygon *innerPolygon in self.inner)
            {
                if ([innerPolygon isPointInPolygon:p])
                {
                    return NO;
                }
            }
            
            return YES;
        }
    }
}

@end
