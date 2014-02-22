//
//  WorldColissionsManager.m
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "WorldColissionsManager.h"


@implementation WorldColissionsManager
{
    GridMap *grid;
}
@synthesize soldiers;
@synthesize towers;

- (id)init:(GridMap *) gridMap
{
    self = [super init];
    if (self) {
        gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
        grid=gridMap;
        
    }
    return self;
}

+Controller:(GridMap *) gridMap{
    return ([[WorldColissionsManager alloc]init:gridMap]);
}


-(void) surveliance{
    CGPoint towerpoint;
    CGPoint soldierpoint;

     //   CCLOG(@"entering x %f", towerpoint.x);
    //for (TowerHuman* tower in towers) {
    for (TowerHuman* tower in gameStatusEssentialsSingleton.towers) {
        towerpoint=[tower getLocation];
        //need add is attacking
     //   CCLOG(@"Addres tower x %f", towerpoint.x);
     //   CCLOG(@"addres tower y %f", towerpoint.y);
        
        //tower is not attacking
        //[tower setIsAttacking:true];
        //tower attacking
        for (Soldier* soldier in gameStatusEssentialsSingleton.soldiers) {
            if (![soldier visible]) {
                   continue;
            }
            
            soldierpoint = [soldier getPOSITION];
            //soldierpoint=[self convertToWorldSpace:soldierpoint];
            soldierpoint=[grid convertMapIndexToGL:soldierpoint];
           // soldierpoint = [[CCDirector sharedDirector] convertToGL: soldierpoint];
          //  CCLOG(@"Addres soldier x %f", soldierpoint.x);
           // CCLOG(@"addres soldier y %f", soldierpoint.y);
        if ( (towerpoint.x>=soldierpoint.x-80&&towerpoint.x<=soldierpoint.x+80)&&(towerpoint.y>=soldierpoint.y-80&& towerpoint.y<=soldierpoint.y+80)&&[tower isAttacking]==false) {
                CCLOG(@"PREPARE SHOT ONE POINT");
                //reduce energy in soldier
                                //animate attack from soldier
                
                //animate attack from tower
                
                [tower attackTest:soldierpoint];
                [soldier beingAttacked:10];
                break;
                //animates deaths is possible
            }
            
        }
        
        //soldier attacking
        for (Soldier* soldier in gameStatusEssentialsSingleton.soldiers) {
            if (![soldier visible] || [soldier getAttackCD] < [soldier getAttackTime] || ![soldier getATTACK_FLAG]) {
                continue;
            }
            
            soldierpoint = [soldier getPOSITION];
            soldierpoint=[grid convertMapIndexToGL:soldierpoint];
            
            if ( (towerpoint.x>=soldierpoint.x-50&&towerpoint.x<=soldierpoint.x+50)&&(towerpoint.y>=soldierpoint.y-50&& towerpoint.y<=soldierpoint.y+50)) {
                CCLOG(@"soldier attack!!!!!");
                [soldier attack:towerpoint];
            }
        }
        
        
        // do stuff
    }
}
-(void) makeTowerSoldierFight:(TowerHuman*) tower :(Soldier*) soldier{
    
}
-(void) makeTowerSoldierFightTest:(TowerHuman*) tower :(CGPoint) soldier{
    
}


-(void)addTower:(CCNode*)towerr{
   // [towers addObject:towerr];
    [gameStatusEssentialsSingleton.towers addObject:towerr];
}

-(void)removeSoldier:(Soldier*)soldier{
    
}

-(void)removeTower:(TowerHuman*)tower{
    
}


@end
