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

@implementation defense

+ (instancetype)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (instancetype)init
{
    self = [super init];
    if (!self) return(nil);
    
    glClearColor(0, 0, 0, 1.0);
    Soldier *sol1 = [Soldier runner:(int)100 ATTACK:(int)80 Speed:(int)50 ATTACK_SP:(int)50];
    sol1.position = ccp(50, 50);
    [self addChild:sol1];
    
    [self scheduleUpdate];
    
    // test square cell
    GridMap *grid = [GridMap map];
    [self addChild:grid z:1];
    
    return self;
}

- (void)update:(ccTime)delta
{
    for (CCNode *node in self.children)
    {
        if([node isKindOfClass:[Soldier class]]){
            Soldier *soldier = (Soldier *)node;

    //  float time = ;
            

        if(lroundf(delta)%2 == 0){
            if(soldier.position.x < [[CCDirector sharedDirector] winSize].width)
                soldier.position = ccpAdd(soldier.position, ccp(1,0));
        }
        
        else{
            if(soldier.position.y < [[CCDirector sharedDirector] winSize].height)
                soldier.position = ccpAdd(soldier.position, ccp(0,1));
            
        }
        }

    }
}


@end
