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

@interface WorldColissionsManager : CCNode
+(instancetype) Controller;
-(void) surveliance;
-(void) makeTowerSoldierFight:(TowerHuman*) tower :(Soldier*) soldier;
-(void) makeTowerSoldierFightTest:(TowerHuman*) tower :(CGPoint) soldier;
-(void)addSoldier:(Soldier*)soldier;
-(void)addSoldierTest:(CGPoint)soldier;
-(void)addSoldierTestB:(Soldier*)soldier;
-(void)addTower:(TowerHuman*)tower;
-(void)removeSoldier:(Soldier*)soldier;
-(void)removeTower:(TowerHuman*)tower;
-(void)setSoldierArray:(NSMutableArray*) soldiersIncome;
@property(assign, nonatomic) NSMutableArray *soldiers;
@property(assign, nonatomic) NSMutableArray *towers;
@end
