//
//  SoldierController.m
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "SoldierController.h"
#import "Soldier.h"
#import "GridMap.h"
#import "ModelsConstants.h"




@implementation SoldierController{
    NSMutableArray *soldierarray;
    float currentTime;
}

+Controller{
    return ([[SoldierController alloc]init]);
}

-init{
    soldierarray = [[NSMutableArray alloc] init];
    currentTime = 0;
    
    return self;
}


-(void)addSoldier:(Soldier *) newSoldier{
    [soldierarray addObject:newSoldier];
    
}

-(void)updateSoldier:(ccTime) time Map:(GridMap *) map{
    Soldier *sol;
    currentTime += time;
    
    for (int i=0; i < [soldierarray count];i++) {
        sol = (Soldier *)[soldierarray objectAtIndex:i];
        if (currentTime > [sol getNextMoveTime]) {
            char status = [map getStatusAtX:[sol getPOSITION].x Y:[sol getPOSITION].y];
            if(status == GOAL)
                [sol setVisible:FALSE];
            else
                [sol move:status gridSize:[map getCellSize] currentTime:currentTime];
        }
    }
    
    //simulate being attacked
    if (currentTime > 12 && currentTime < 23) {
        CCLOG(@"set Health");
        for (int i=0; i < [soldierarray count];i++) {
            sol = (Soldier *)[soldierarray objectAtIndex:i];
            [sol setHEALTH:45];
        }
    }
}


-(int)getArraylength{
    
    return [soldierarray count];
}

-(NSMutableArray*)getSoldierArray{
    
    return soldierarray;
}


@end
