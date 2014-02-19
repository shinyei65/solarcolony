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

+Controller{
    return ([[WorldColissionsManager alloc]init]);
}
/*
-(void) surveliance{
    CGPoint towerpoint;
    CGPoint soldierpoint;
    CGPoint soldierpointtest;
    for (TowerHuman* tower in towers) {
        towerpoint=[tower getLocation];
        //need add is attacking
        
       
            //tower is not attacking
            //[tower setIsAttacking:true];
            
            for (NSValue* soldier in soldiers) {
           
            //[yourCGPointsArray addObject:[NSValue valueWithCGPoint:CGPointMake(100, 10
          
                soldierpoint = soldier.CGPointValue;
                soldierpointtest = soldier.CGPointValue;
                soldierpoint = [[CCDirector sharedDirector] convertToGL: soldierpoint];
                if ( (towerpoint.x>=soldierpoint.x-160&&towerpoint.x<=soldierpoint.x+160)&&(towerpoint.y>=soldierpoint.y-160&& towerpoint.y<=soldierpoint.y+160)&&[tower isAttacking]==false) {
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
}*/

-(void) surveliance{
    CGPoint towerpoint;
    CGPoint soldierpoint;
    CGPoint soldierpointtest;
     //   CCLOG(@"entering x %f", towerpoint.x);
    for (TowerHuman* tower in towers) {
        towerpoint=[tower getLocation];
        //need add is attacking
     //   CCLOG(@"Addres tower x %f", towerpoint.x);
     //   CCLOG(@"addres tower y %f", towerpoint.y);
        
        //tower is not attacking
        //[tower setIsAttacking:true];
        
        for (Soldier* soldier in soldiers) {
            
            //[yourCGPointsArray addObject:[NSValue valueWithCGPoint:CGPointMake(100, 10
            
            soldierpoint = [soldier getPOSITION];
            soldierpoint=[self convertToWorldSpace:soldierpoint];
           // soldierpoint = [[CCDirector sharedDirector] convertToGL: soldierpoint];
          //  CCLOG(@"Addres soldier x %f", soldierpoint.x);
       //     CCLOG(@"addres soldier y %f", soldierpoint.y);
            if ( (towerpoint.x>=soldierpoint.x-160&&towerpoint.x<=soldierpoint.x+160)&&(towerpoint.y>=soldierpoint.y-160&& towerpoint.y<=soldierpoint.y+160)&&[tower isAttacking]==false) {
                CCLOG(@"PREPARE SHOT ONE POINT");
                //reduce energy in soldier
                
                //animate attack from soldier
                
                //animate attack from tower
                
                [tower attackTest:soldierpoint];
                
                
                //[soldiers removeObject:soldier];
                break;
                //animates deaths is possible
            }
            
        }
        
        
        // do stuff
    }
}
-(void) makeTowerSoldierFight:(TowerHuman*) tower :(Soldier*) soldier{
    
}
-(void) makeTowerSoldierFightTest:(TowerHuman*) tower :(CGPoint) soldier{
    
}


-(void)addSoldierTest:(CGPoint)soldier{
    NSValue* soldierr= [NSValue valueWithCGPoint:soldier];
    [soldiers addObject:soldierr];
}

-(void)addSoldierTestB:(Soldier*)soldier{
    [soldiers addObject:soldier];
}

-(void)addSoldier:(Soldier*)soldier{
    
    [soldier addObject:soldier];

}

-(void)setSoldierArray:(NSMutableArray*) soldiersIncome{

    [soldiers removeAllObjects];
    [soldiers addObjectsFromArray:soldiersIncome];
    //soldiers=soldiersIncome;
 
    
}
-(void)addTower:(TowerHuman*)towerr{
    [towers addObject:towerr];
}

-(void)removeSoldier:(Soldier*)soldier{
    
}

-(void)removeTower:(TowerHuman*)tower{
    
}


@end
