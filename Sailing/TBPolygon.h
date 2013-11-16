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

- (void)addOuter:(TBPoint *)point;
- (void)addInner:(TBPolygon *)polygon;

- (TBPoint *)getClosestTo:(TBPoint *)point;
- (TBPoint *)getPointAt:(int)index;
- (BOOL)isPointInPolygon:(TBPoint *)p;

@end
