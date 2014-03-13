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
#import "TowerMenu.h"

@interface GridMap : CCLayer

+ (GridMap *) map;
- (instancetype) init;
- (void) setMap:(char) target X:(int) x Y:(int) y;
- (char) getStatusAtX:(int) x Y:(int) y;
- (BOOL) canBuildTowerAtX:(int) x Y:(int) y;
- (BOOL) canPassAtX:(int) x Y:(int) y;
- (char) getFullMap;
- (CGSize) getCellSize;
- (CGPoint) convertMapIndexToGL: (CGPoint) index;
- (CGPoint) convertMapIndexToCenterGL: (CGPoint) index;
- (TowerMenu*) getTowerMenu;
- (void) hideTowerMenu;
- (CGPoint) getTowerMenuPosition;
- (void) setTowerMenuPosition:(CGPoint) loc;
- (void) addTower: (id) tower index: (CGPoint) idx z: (NSInteger) z;
- (CGPoint) getStartIndex;
- (CGPoint) getGoalIndex;
- (void) showMessage: (NSString *) str;
@property(nonatomic,assign) CGPoint menuLocation;
@end

@interface GridLinesLayer : CCLayer
+(instancetype) layer;
-(instancetype) init;
@end