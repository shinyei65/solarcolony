//
//  defense.m
//  SolarColony
//
//  Created by Student on 2/10/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "defense.h"
#import "Soldier.h"
#import "GridMap.h"
#import "SoldierController.h"

@implementation defense{
    SoldierController *solController;
    GridMap *grid;
    
}

+ (instancetype)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (instancetype)init
{
    self = [super init];
    if (!self) return(nil);
    
    // test square cell
    solController = [SoldierController Controller];
    [self addChild:solController];
    grid = [GridMap map];
    CGSize cellSize = [grid getCellSize];
    NSLog(@"Cell(%g,%g)", cellSize.width, cellSize.height);
    [self addChild:grid];
    
    //glClearColor(0, 0, 0, 1.0);
    Soldier *sol1 = [Soldier runner:(int)100 ATTACK:(int)80 Speed:(int)50 ATTACK_SP:(int)50];
    [sol1 setPOSITION:2 Y:0];
    [sol1 setPosition:[grid convertMapIndexToGL:ccp(2, 0)]];
    [grid addChild:sol1];
    
    
    for (int i=0; i<5; i++) {
        Soldier *temp = [Soldier runner:(int)100 ATTACK:(int)80 Speed:(int)50 ATTACK_SP:(int)50];
        [temp setPOSITION:2 Y:0];
        [temp setPosition:[grid convertMapIndexToGL:ccp(2, 0)]];
        [grid addChild:temp];
        [solController addSoldier:temp];
    }
    
    
    
    
   // CCLOG(@"number of soldier: %d",[solController getArraylength]);
    [self scheduleUpdate];
    return self;
}

- (void)update:(ccTime)delta
{
        [solController updateSoldier:delta];
    
    
  /*
    for (CCNode *node in grid.children)
    {
        if([node isKindOfClass:[Soldier class]]){
            Soldier *soldier = (Soldier *)node;
            [soldier move:'R' gridSize:[grid getCellSize]];
   

        if(lroundf(delta)%2 == 0){
            if(soldier.position.x < [[CCDirector sharedDirector] winSize].width)
                soldier.position = ccpAdd(soldier.position, ccp(1,0));
        }
        
        else{
            if(soldier.position.y < [[CCDirector sharedDirector] winSize].height)
                soldier.position = ccpAdd(soldier.position, ccp(0,1));
            
        }
   
        }

    }*/
    
    
}


@end
