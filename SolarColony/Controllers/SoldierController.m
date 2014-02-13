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




@implementation SoldierController{
    NSMutableArray *soldierarray;
    
}

+Controller{
    return ([[SoldierController alloc]init]);
}

-init{
   soldierarray = [NSMutableArray array];
    
    
    return self;
}


-addSoldier:(Soldier *) newSoldier{
    [soldierarray addObject:newSoldier];
    
}

-updateSoldier:(ccTime) time{
    for (Soldier *sol in soldierarray) {
        GridMap *map = (GridMap *)[sol parent];
        char status = [map getStatusAtX:[sol getPOSITION].x Y:[sol getPOSITION].y];
        if(status == ' ')
            ;
    }
    
    
}


-(int)getArraylength{
    return [soldierarray count];
}

@end
