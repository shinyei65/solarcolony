//
//  GameStatusEssentialsSingleton.h
//  SolarColony
//
//  Created by Student on 2/19/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ModelsConstants.h"
#import "WaveController.h"
#import "SoldierController.h"
#import "GridMap.h"
#import "Soldier.h"
#import "Army.h"
#import "WaveQueue.h"


@interface GameStatusEssentialsSingleton : CCNode
+ (id)sharedInstance;
- (void) addTower:(CCNode*) tower;
- (void) addSoldier:(CCNode*) tower;
- (void) removeTowerAt:(int) index;
- (void) removeSoldierAt:(int) index;
- (CCNode*) getTowerAt:(int) index;
- (CCNode*) getSoldierAt:(int) index;
- (void) removeAllSoldiers;
- (void) removeAllTowers;

// map property
- (NSString *) getGameMapName;
- (NSString *) getGameMapImagename;


@property(assign, nonatomic) NSMutableArray *soldiers;
@property(assign, nonatomic) NSMutableArray *towers;
@end
