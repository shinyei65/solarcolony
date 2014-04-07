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

    //remove towers
    for (TowerGeneric* tower in gameStatusEssentialsSingleton.towers) {
        if ([tower isDeath]) {
            [grid removeTower:tower];
           // [gameStatusEssentialsSingleton.towers removeObject:tower];
        }
    }
    
    for (TowerGeneric* tower in gameStatusEssentialsSingleton.towers) {
        if (![tower visible]) {
            continue;
        }
        
        towerpoint=[tower getLocation];
        //need add is attacking

        for (Soldier* soldier in gameStatusEssentialsSingleton.soldiers) {
            if (![soldier visible]) {
                   continue;
            }
            
            soldierpoint = [soldier getPOSITION];
            soldierpoint=[grid convertMapIndexToGL:soldierpoint];
            
            if (tower.towerTowerId==1) {
                
                if ( (towerpoint.x>=soldierpoint.x-80&&towerpoint.x<=soldierpoint.x+80)&&(towerpoint.y>=soldierpoint.y-80&& towerpoint.y<=soldierpoint.y+80)&&[tower isAttacking]==false) {
                [tower attackTest:soldierpoint];
                
                [soldier beingAttacked:2];
                break;
                     }
            } else if(tower.towerTowerId==2) {
                if ( (towerpoint.x>=soldierpoint.x-80&&towerpoint.x<=soldierpoint.x+80)&&(towerpoint.y>=soldierpoint.y-80&& towerpoint.y<=soldierpoint.y+80)&&[tower isAttacking]==false) {

                    if (tower.isCharging) {
                       
                    } else {
                        [tower attackTest:soldierpoint];
                        [tower  reloadAnimation];
                        [soldier beingAttacked:5];                      
                        break;
     
                    }
                    
               }
            } else if (tower.towerTowerId==3)  {                
           
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
                [tower beignattacked];
            }
        }
        
        
        
    }

}
-(void) makeTowerSoldierFight:(TowerGeneric*) tower :(Soldier*) soldier{
    
}
-(void) makeTowerSoldierFightTest:(TowerGeneric*) tower :(CGPoint) soldier{
    
}


-(void)addTower:(CCNode*)towerr{
   // [towers addObject:towerr];
    [gameStatusEssentialsSingleton.towers addObject:towerr];
}

-(void)removeSoldier:(Soldier*)soldier{
    
}

-(void)removeTower:(TowerGeneric*)tower{
    
}


@end
