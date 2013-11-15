//
//  TBPolygon.h
//  Sailing
//
//  Created by tomaszbrue on 12.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBPoint.h"

@interface TBPolygon : NSObject

@property (nonatomic, retain) NSMutableArray *outer;
@property (nonatomic, retain) NSMutableArray *inner;
@property TBPoint *centroid;

- (id)init;
- (id)initWithOuter:(NSArray *)points;
- (id)initWithOuter:(NSArray *)outerPoints andInner:(NSArray *)innerPoints;

- (void)add:(TBPoint *)point;
- (TBPoint *)computeCentroid;
- (TBPoint *)getPointAt:(int)index;
- (int)onWhichSideOfTheLineThrough:(TBPoint *)p0 and:(TBPoint *)p1 is:(TBPoint *)p2;
- (BOOL)isPointInPolygon:(TBPoint *)p;

@end
