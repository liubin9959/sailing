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
- (id)initWithDB:(NSString *)path
{
    self.polygons = [[NSMutableArray alloc] init];
    
    NSMutableArray *wayIds = [[NSMutableArray alloc] init];
    
    SQLiteManager *db = [[SQLiteManager alloc] initWithDatabaseNamed:path];
    
    // get all relations (= MultiPolygons)
    for (NSDictionary *relation in [db getRowsForQuery:@"SELECT * FROM Relation"])
    {
        // get all ways from this relation
        int relationId = [[relation objectForKey:@"Id"] integerValue];
        
        NSMutableArray *innerWayIds = [[NSMutableArray alloc] init];
        TBPolygon *polygon = [[TBPolygon alloc] init];
        
        for (NSDictionary *relationway in [db getRowsForQuery:[NSString stringWithFormat:@"SELECT * FROM RelationWay WHERE RelationId = %i", relationId]])
        {
            // get and store way id
            [wayIds addObject:[relationway objectForKey:@"WayId"]];
            
            if ([[relationway objectForKey:@"Role"] isEqualToString:@"outer"])
            {
                // get all nodes of this way
                int wayId = [[relationway objectForKey:@"WayId"] integerValue];
                for (NSDictionary *waynode in [db getRowsForQuery:[NSString stringWithFormat:@"SELECT * FROM WayNode WHERE WayId = %i", wayId]])
                {
                    // get node
                    int nodeId = [[waynode objectForKey:@"NodeId"] integerValue];
                    for (NSDictionary *node in [db getRowsForQuery:[NSString stringWithFormat:@"SELECT * FROM Node WHERE Id = %i", nodeId]])
                    {
                        double lat = [[node objectForKey:@"Lat"] doubleValue];
                        double lon = [[node objectForKey:@"Lon"] doubleValue];
                        TBPoint *point = [[TBPoint alloc] initWithLatitude:lat longitude:lon];
                        [polygon addOuter:point];
                    }
                }
            }
            else
            {
                [innerWayIds addObject:[relationway objectForKey:@"WayId"]];
            }
        }
        
        // loop the inner polygon way candidates
        for (id way in innerWayIds)
        {
            // get all nodes of this way
            int wayId = [way integerValue];
            
            TBPolygon *outer = [[TBPolygon alloc] init];
            
            for (NSDictionary *waynode in [db getRowsForQuery:[NSString stringWithFormat:@"SELECT * FROM WayNode WHERE WayId = %i", wayId]])
            {
                // get node
                int nodeId = [[waynode objectForKey:@"NodeId"] integerValue];
                for (NSDictionary *node in [db getRowsForQuery:[NSString stringWithFormat:@"SELECT * FROM Node WHERE Id = %i", nodeId]])
                {
                    double lat = [[node objectForKey:@"Lat"] doubleValue];
                    double lon = [[node objectForKey:@"Lon"] doubleValue];
                    TBPoint *point = [[TBPoint alloc] initWithLatitude:lat longitude:lon];
                    [outer addOuter:point];
                }
            }
            
            [polygon addInner:outer];
        }
        
        // add to sphere
        [self.polygons addObject:polygon];
    }
    
    NSLog(@"Used Way IDs %i", wayIds.count);
    
    // Query all the Ways that are not yet queried
    for (NSDictionary *way in [db getRowsForQuery:@"SELECT * FROM Way"])
    {
        // way is not used yet
        if (![wayIds containsObject:[way objectForKey:@"Id"]])
        {
            int wayId = [[way objectForKey:@"Id"] integerValue];
            TBPolygon *polygon = [[TBPolygon alloc] init];
            
            for (NSDictionary *waynode in [db getRowsForQuery:[NSString stringWithFormat:@"SELECT * FROM WayNode WHERE WayId = %i", wayId]])
            {
                // get node
                int nodeId = [[waynode objectForKey:@"NodeId"] integerValue];
                for (NSDictionary *node in [db getRowsForQuery:[NSString stringWithFormat:@"SELECT * FROM Node WHERE Id = %i", nodeId]])
                {
                    double lat = [[node objectForKey:@"Lat"] doubleValue];
                    double lon = [[node objectForKey:@"Lon"] doubleValue];
                    TBPoint *point = [[TBPoint alloc] initWithLatitude:lat longitude:lon];
                    [polygon addOuter:point];
                }
            }
            
            [self.polygons addObject:polygon];
        }
    }
    
    NSLog(@"%i polygons available", self.polygons.count);
    
    
    return self;
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
        TBPoint *first_c = [first getClosestTo:point];
        TBPoint *seconds_c = [second getClosestTo:point];
        
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
