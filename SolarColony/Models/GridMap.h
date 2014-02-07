//
//  GridMap.h
//  SolarColony
//
//  Created by Student on 2/7/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//
//
//

#import <Foundation/Foundation.h>

@interface GridMap : NSObject

+ (instancetype) map;
- (instancetype) init;
- (void) setTower:(int) val X:(int) x Y:(int) y;
- (BOOL) hasTowerAtX:(int) x Y:(int) y;
- (int) getTowerAtX:(int) x Y:(int) y;

@end
