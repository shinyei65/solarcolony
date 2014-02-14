//
//  WorldColissionsManager.m
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "WorldColissionsManager.h"


@implementation WorldColissionsManager
@synthesize soldiers;
@synthesize towers;

- (id)init
{
    self = [super init];
    if (self) {
        towers= [[NSMutableArray alloc] init];
        soldiers= [[NSMutableArray alloc] init];
        
        
    }
    return self;
}

-(void) surveliance{
    CGPoint towerpoint;
    CGPoint soldierpoint;
    CGPoint soldierpointtest;
    for (TowerBasic* tower in towers) {
        towerpoint=[tower getLocation];
        //need add is attacking
        
       
            //tower is not attacking
            //[tower setIsAttacking:true];
            
            for (NSValue* soldier in soldiers) {
           
            //[yourCGPointsArray addObject:[NSValue valueWithCGPoint:CGPointMake(100, 10
          
                soldierpoint = soldier.CGPointValue;
                soldierpointtest = soldier.CGPointValue;
                soldierpoint = [[CCDirector sharedDirector] convertToGL: soldierpoint];
                if ( (towerpoint.x>=soldierpoint.x-60&&towerpoint.x<=soldierpoint.x+60)&&(towerpoint.y>=soldierpoint.y-60&& towerpoint.y<=soldierpoint.y+60)&&[tower isAttacking]==false) {
                     CCLOG(@"PREPARE SHOT ONE POINT");
                //reduce energy in soldier
                
                //animate attack from soldier
                
                //animate attack from tower
                   
                    [tower attackTest:soldierpoint];
                    [soldiers removeObject:soldier];
                    break;
            //animates deaths is possible
                }
            
            }
       
        // do stuff
    }
}
-(void) makeTowerSoldierFight:(TowerBasic*) tower :(Soldier*) soldier{
    
}
-(void) makeTowerSoldierFightTest:(TowerBasic*) tower :(CGPoint) soldier{
    
}


-(void)addSoldierTest:(CGPoint)soldier{
    NSValue* soldierr= [NSValue valueWithCGPoint:soldier];
    [soldiers addObject:soldierr];
}

-(void)addSoldier:(Soldier*)soldier{
    [soldier addObject:soldier];

}
-(void)addTower:(TowerBasic*)towerr{
    [towers addObject:towerr];
}

-(void)removeSoldier:(Soldier*)soldier{
    
}

-(void)removeTower:(TowerBasic*)tower{
    
}


@end
