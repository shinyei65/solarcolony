//
//  WorldColissionsManager.h
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TowerHuman.h"
#import "Soldier.h"
#import "GridMap.h"
#import "GameStatusEssentialsSingleton.h"

@interface WorldColissionsManager : CCNode
{
    GameStatusEssentialsSingleton * gameStatusEssentialsSingleton;
}
+Controller:(GridMap *) gridMap;
-(void) surveliance;
-(void) makeTowerSoldierFight:(TowerHuman*) tower :(Soldier*) soldier;
-(void) makeTowerSoldierFightTest:(TowerHuman*) tower :(CGPoint) soldier;
-(void)addTower:(CCNode*)tower;
-(void)removeTower:(TowerHuman*)tower;
-(void)setSoldierArray:(NSMutableArray*) soldiersIncome;
@property(assign, nonatomic) NSMutableArray *soldiers;
@property(assign, nonatomic) NSMutableArray *towers;
@end
