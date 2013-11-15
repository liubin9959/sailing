//
//  TBSphere.m
//  Sailing
//
//  Created by tomaszbrue on 12.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import "TBSphere.h"
#import "SQLiteManager.h"

@implementation TBSphere

/*
 creates a new sphere with polygons
 */
- (id)initWithPolygons:(NSArray *)members
{
    self.polygons = [[NSMutableArray alloc] initWithArray:members];
    return self;
}

/*
 loads the sphere data from open street map data in
 form oh a sqlite database 
 */
- (void)loadFromDB:(NSString *)path
{
    SQLiteManager *dbManager = [[SQLiteManager alloc] initWithDatabaseNamed:@"osm.db"];
}

/* 
 returns a YES if the provided point is in water 
 */
- (BOOL)isWater:(TBPoint *)point
{
    // there are no polygons
    if (self.polygons.count <= 0)
    {
        return NO;
    }
    
    // sort the polygons with the closest to point first
    NSArray *sortedPolygons = [self.polygons sortedArrayUsingComparator:^NSComparisonResult(id a, id b)
    {
        // get polygons to compare
        TBPolygon *first = (TBPolygon*) a;
        TBPolygon *second = (TBPolygon*) b;
        
        // calculate their centroids
        TBPoint *first_c = [first computeCentroid];
        TBPoint *seconds_c = [second computeCentroid];
        
        if ([first_c distanceToPoint:point] > [seconds_c distanceToPoint:point])
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        else if ([first_c distanceToPoint:point] < [seconds_c distanceToPoint:point])
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        else
        {
            return (NSComparisonResult)NSOrderedSame;
        }
    }];
    
    // test every polygon in the sorted array
    for (TBPolygon *polygon in sortedPolygons)
    {
        if ([polygon isPointInPolygon:point] == YES)
        {
            return YES;
        }
    }
    
    return NO;
}

@end
