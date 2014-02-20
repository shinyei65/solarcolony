//
//  defense.m
//  SolarColony
//
//  Created by Student on 2/10/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "defense.h"
#import "Soldier.h"
#import "SoldierController.h"
#import "WaveController.h"
#import "TowerMenu.h"
#import "TowerRobot.h"
#import "WorldColissionsManager.h"
#import "GridMap.h"
#import "WaveQueue.h"

@implementation defense{
    SoldierController *solController;
    WaveController *waveController;
    GridMap *grid;
    //eder dont delete
    WorldColissionsManager* colissionsManager;
    
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
    CGSize gsize = [grid getCellSize];
    NSLog(@"grid size(%f, %f)", gsize.width, gsize.height);
    [self addChild:grid];
    
    // initialize wave queue layer
    WaveQueue *wqueue = [WaveQueue layer];
    [self addChild:wqueue];
    
    //EDER DONT DELETE THIS!
    //register self observer, will recieve notifications when a tower was created
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotificationTower:) name:@"TowerBasic" object:nil];
    

    
    /*for (int i=0; i<5; i++) {
        Soldier *temp = [Soldier runner:(int)100 ATTACK:(int)80 Speed:(int)50 ATTACK_SP:(int)50];
        [temp setPOSITION:2 Y:0];
        [temp setPosition:[grid convertMapIndexToGL:ccp(2, 0)]];
        [grid addChild:temp];
        [solController addSoldier:temp];
    }*/
    
    // initialize wave controller
    waveController = [WaveController controller];
    
    //sets up world colision manager
    colissionsManager= [WorldColissionsManager Controller:grid];
   // [colissionsManager setSoldierArray:];
    colissionsManager.soldiers=[solController getSoldierArray];
   // CCLOG(@"number of soldier: %d",[solController getArraylength]);
    [self scheduleUpdate];
    
    

    return self;
}

//creates tower and adds it to current active towers queue
- (void)receivedNotificationTower:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"TowerBasic"]) {
     
       /* //gets incomming point as string formatted point
        NSString *interface = [notification.userInfo objectForKey:@"point"];
        
        //re format incomming string nd separated x and y coordinates
        interface = [interface stringByReplacingOccurrencesOfString:@"{" withString:@""];
        interface = [interface stringByReplacingOccurrencesOfString:@"}" withString:@""];
        NSArray* myArray = [interface  componentsSeparatedByString:@","];
        //X and  coordinates are separated
        NSString* firstString = [myArray objectAtIndex:0];
        NSString* secondString = [myArray objectAtIndex:1];
        
        float pointX=[firstString floatValue];
        float pointY=[secondString floatValue];*/
       // CCLOG(@"location at %@",firstString);
        
        //TowerBasic* t3=[[TowerBasic alloc] initTower:[self convertToNodeSpace:ccp( pointX,pointY)]];
        float pointX=grid.menuLocation.x;
        float pointY=grid.menuLocation.y;
        
        CCLOG(@"End location.x %f", pointX);   //I just get location.x = 0
        CCLOG(@"End location.y %f", pointY);   //I just get location.y = 0
        
        TowerHuman* t3=[[TowerHuman alloc] initTower:[self convertToWorldSpace:ccp(pointX,pointY)]];
         
        [colissionsManager addTower:t3];
        
        [grid addTower:t3 index:[t3 position] z:1];
        //GET CELL INDEX
        
        [[grid getTowerMenu] setVisible:FALSE];
    } else if ([[notification name] isEqualToString:@"TowerDestroyer"]) { 

        float pointX=grid.menuLocation.x;
        float pointY=grid.menuLocation.y;
        
        CCLOG(@"End location.x %f", pointX);   //I just get location.x = 0
        CCLOG(@"End location.y %f", pointY);   //I just get location.y = 0
        
        TowerRobot* t3=[[TowerRobot alloc] initTower:[self convertToWorldSpace:ccp(pointX,pointY)]];
        [colissionsManager addTower:t3];
        [grid addChild:t3];
        
       

    }
}

- (void)update:(ccTime)delta
{
    
    //tower surveliance
     [colissionsManager surveliance];
    
    //update soldiers
    [solController updateSoldier:delta];
    [waveController update];
    
    
 //   [colissionsManager setSoldierArray:[solController getSoldierArray]];
     colissionsManager.soldiers=[solController getSoldierArray];
   /* for (Soldier* s in [solController getSoldierArray] ) {
        CCLOG(@"End location.x %f", [s getPOSITION].x);
        CCLOG(@"End location.y %f", [s getPOSITION].x);
    }*/
   // CCLOG(@"[solController getSoldierArray]  %f", [[[solController getSoldierArray] objectAtIndex:0] getPOSITION].x);
    
   
    
     
    
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
