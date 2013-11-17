//
//  TBBearing.h
//  Sailing
//
//  Created by tomaszbrue on 17.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBBearing : NSObject

@property double value;

- (id)initWithValue:(double)value;
- (double)angleTo:(TBBearing *)other;
- (NSString *)toDirection;

@end
