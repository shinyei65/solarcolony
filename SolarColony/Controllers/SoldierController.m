//
//  SoldierController.m
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "SoldierController.h"
#import "GridMap.h"
#import "Soldier.h"
#import "ModelsConstants.h"


static SoldierController *sharedSoldierController = nil;

@implementation SoldierController{
    NSMutableArray *soldierarray;
    GameStatusEssentialsSingleton * gameStatusEssentialsSingleton;
}

+Controller{
    if(sharedSoldierController == nil){
    sharedSoldierController = [[super allocWithZone:nil] init];
    }
    return sharedSoldierController;
}

-init{
    soldierarray = [[NSMutableArray alloc] init];
    gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
    return self;
}


-(void)addSoldier:(Soldier *) newSoldier{
    [soldierarray addObject:newSoldier];
    
}

-(void)updateSoldier:(ccTime) time{
    
    for (Soldier* sol in gameStatusEssentialsSingleton.soldiers) {
        [sol acculMoveCD:time];
        [sol acculAttackCD:time];
        if ([sol getMoveCD] > [sol getMoveTime]) {
            char status = [[GridMap map] getStatusAtX:[sol getPOSITION].x Y:[sol getPOSITION].y];
            if(status == GOAL){
                if([sol visible]){
                [sol setVisible:FALSE];
                int newLife = [[PlayerInfo Player] getLife]-1;
                if(newLife >= 0)
                    [[PlayerInfo Player] setLife:newLife];
                }
            }
            else
                [sol move:status gridSize:[[GridMap map] getCellSize]];
        }
    }
    
    //simulate being attacked
    /*
    if (currentTime > 12 && currentTime < 23) {
        for (int i=0; i < [soldierarray count];i++) {
            sol = (Soldier *)[soldierarray objectAtIndex:i];
            [sol setHEALTH:45];
        }
    }
    */
}


-(int)getArraylength{
    
    return [soldierarray count];
}

-(NSMutableArray*)getSoldierArray{
    
    return soldierarray;
}


@end
