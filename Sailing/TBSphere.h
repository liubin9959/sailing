//
//  TBSphere.h
//  Sailing
//
//  Created by tomaszbrue on 12.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBPolygon.h"

@interface TBSphere : NSObject

@property (nonatomic, retain) NSMutableArray *polygons;

- (id)initWithPolygons:(NSArray *)members;
- (BOOL)isWater:(TBPoint *)point;

@end
