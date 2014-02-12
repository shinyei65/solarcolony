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
#import "cocos2d.h"

@interface GridMap : CCLayer

+ (instancetype) map;
- (instancetype) init;
- (void) setMap:(char) target X:(int) x Y:(int) y;
- (char) getStatusAtX:(int) x Y:(int) y;
- (BOOL) canBuildTowerAtX:(int) x Y:(int) y;
- (BOOL) canPassAtX:(int) x Y:(int) y;
- (char) getFullMap;

@end
