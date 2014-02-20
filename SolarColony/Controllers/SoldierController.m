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
    float currentTime;
}

+Controller{
    if(sharedSoldierController == nil){
    sharedSoldierController = [[super allocWithZone:nil] init];
    }
    return sharedSoldierController;
}

-init{
    soldierarray = [[NSMutableArray alloc] init];
    currentTime = 0;
    
    return self;
}


-(void)addSoldier:(Soldier *) newSoldier{
    [soldierarray addObject:newSoldier];
    
}

-(void)updateSoldier:(ccTime) time{
    Soldier *sol;
    currentTime += time;
    
    for (int i=0; i < [soldierarray count];i++) {
        sol = (Soldier *)[soldierarray objectAtIndex:i];
        if (currentTime > [sol getNextMoveTime]) {
            char status = [[GridMap map] getStatusAtX:[sol getPOSITION].x Y:[sol getPOSITION].y];
            if(status == GOAL)
                [sol setVisible:FALSE];
            else
                [sol move:status gridSize:[[GridMap map] getCellSize] currentTime:currentTime];
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
