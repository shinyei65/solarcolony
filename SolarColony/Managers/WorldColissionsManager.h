//
//  WorldColissionsManager.h
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TowerBasic.h"
#import "Soldier.h"

@interface WorldColissionsManager : NSObject
-(void) surveliance;
-(void) makeTowerSoldierFight:(TowerBasic*) tower :(Soldier*) soldier;
-(void) makeTowerSoldierFightTest:(TowerBasic*) tower :(CGPoint) soldier;
-(void)addSoldier:(Soldier*)soldier;
-(void)addSoldierTest:(CGPoint)soldier;
-(void)addTower:(TowerBasic*)tower;
-(void)removeSoldier:(Soldier*)soldier;
-(void)removeTower:(TowerBasic*)tower;
@property(assign, nonatomic) NSMutableArray *soldiers;
@property(assign, nonatomic) NSMutableArray *towers;
@end
