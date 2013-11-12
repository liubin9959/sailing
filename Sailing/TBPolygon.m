//
//  TBPolygon.m
//  Sailing
//
//  Created by tomaszbrue on 12.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import "TBPolygon.h"

@implementation TBPolygon

- (id)init
{
    self.members = [[NSMutableArray alloc] init];
    return self;
}

/* 
 add polygon member 
 */
- (void)add:(TBPoint *)point
{
    [self.members addObject:point];
}

/* 
 get the coordinate at an index of the polygon
 vertex array 
 */
- (TBPoint *)getPointAt:(int)index
{
    return ((TBPoint *)[self.members objectAtIndex:index]);
}

/* 
 compute the gravity centroid of the polygon 
 */
- (TBPoint *)computeCentroid
{
    // if there is already a centroid computed, just
    // return this one
    if (self.centroid != nil)
    {
        return self.centroid;
    }
    
    double signedArea = 0.0;
    CLLocationCoordinate2D current = CLLocationCoordinate2DMake(0, 0);
    CLLocationCoordinate2D next = CLLocationCoordinate2DMake(0, 0);
    CLLocationCoordinate2D c_loc = CLLocationCoordinate2DMake(0, 0);
    double a = 0.0;
    
    // for all vertices except last one
    int i = 0;
    for(i = 0; i < self.members.count - 1; i++)
    {
        current = [[self getPointAt:i] getCoordinate];
        next = [[self getPointAt:i + 1] getCoordinate];
        a = (current.latitude * next.longitude) - (next.latitude * current.longitude);
        signedArea += a;
        
        c_loc = CLLocationCoordinate2DMake(
            (current.latitude + next.latitude) * a,
            (current.longitude + next.longitude) * a
        );
    }
    
    // do last vertex
    current = [[self getPointAt:i] getCoordinate];
    next = [[self getPointAt:0] getCoordinate];
    a = (current.latitude * next.longitude) - (next.latitude * current.longitude);
    signedArea += a;
    
    c_loc = CLLocationCoordinate2DMake(
       (current.latitude + next.latitude) * a,
       (current.longitude + next.longitude) * a
    );
    
    // final adjustments
    signedArea *= 0.5;
    double c_lat = c_loc.latitude / (6.0 * signedArea);
    double c_lon = c_loc.longitude / (6.0 * signedArea);
    self.centroid = [[TBPoint alloc] initWithCoordinate:CLLocationCoordinate2DMake(c_lat, c_lon)];
    
    return self.centroid;
}

/* 
 tests if a point is left|on|right of an infinite line.
 > 0 for p2 left of the line through p0 and p1
 = 0 for p2 on the line
 < 0 for p2 right of the line
 */
- (int)onWhichSideOfTheLineThrough:(TBPoint *)p0 and:(TBPoint *)p1 is:(TBPoint *)p2
{
    return (([p1 getLatitude] - [p0 getLatitude]) * ([p2 getLongitude] - [p0 getLongitude])
            - ([p2 getLatitude] - [p0 getLatitude]) * ([p1 getLongitude] - [p0 getLongitude]));
}

/*
 winding number test for a point in a polygon
 */
- (BOOL)isPointInPolygon:(TBPoint *)p
{

    int wn = 0;
    TBPoint *current;
    TBPoint *next;
    
    // loop through all edges of the polygon
    for(int i = 0; i < self.members.count; i++)
    {
        current = [self getPointAt:i];
        next = [self getPointAt:i + 1];
        
        // start y <= p.y
        if ([current getLongitude] <= [p getLongitude])
        {
            // an upward crossing
            if ([next getLongitude] > [p getLongitude])
            {
                // p left of edge
                if ([self onWhichSideOfTheLineThrough:current and:next is:p] > 0)
                {
                    // hava a valid up intersect
                    wn++;
                }
            }
        }
        // start y > p.y (no test needed)
        else
        {
            if ([next getLongitude] <= [p getLongitude])
            {
                if ([self onWhichSideOfTheLineThrough:current and:next is:p] < 0)
                {
                    // java valid down intersect
                    wn--;
                }
            }
        }
    }
    
    return (wn != 0);
}

@end
