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
    float nextMoveTime;
    float currentTime;
}

+Controller{
    return ([[SoldierController alloc]init]);
}

-init{
    soldierarray = [[NSMutableArray alloc] init];
    nextMoveTime = 0;
    currentTime = 0;
    
    return self;
}


-(void)addSoldier:(Soldier *) newSoldier{
    [soldierarray addObject:newSoldier];
    
}

-(void)updateSoldier:(ccTime) time{
    currentTime += time;
    if (currentTime > nextMoveTime) {
            for (int i=0; i < [soldierarray count];i++) {
            Soldier *sol = (Soldier *)[soldierarray objectAtIndex:i];
            GridMap *map = (GridMap *)[sol parent];
            char status = 'R';
            //[map getStatusAtX:[sol getPOSITION].x Y:[sol getPOSITION].y];
            if(status == GOAL)
                [sol dealloc];
            else
                [sol move:status gridSize:[map getCellSize]];
            nextMoveTime += 1;
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
