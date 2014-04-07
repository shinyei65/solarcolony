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
#import "TowerFactory.h"
#import "WorldColissionsManager.h"
#import "GridMap.h"
#import "ArmyQueue.h"
#import "PlayerInfo.h"
#import "PauseScene.h"
#import "TowerFactory.h"
#import "SupportTowerTouch.h"

@implementation defense{
    SoldierController *solController;
    WaveController *waveController;
    GridMap *grid;
    //eder dont delete
    WorldColissionsManager* colissionsManager;
    GameStatusEssentialsSingleton * gameStatusEssentialsSingleton;
    PlayerInfo* player;
    CCLabelTTF *resource_label;
    CCLabelTTF *resource_number;
    CCLabelTTF *life_label;
    CCLabelTTF *life_number;
    int humanPrice;
    int robotPrice;
    CCLayerColor *pauseLayer;
    TowerFactory* factoryTowers;
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
    humanPrice = 300;
    robotPrice = 400;
    //Tower Support toucahble canvas
    SupportTowerTouch *supportCavas= [[SupportTowerTouch alloc] init];
    // test square cell
    player = [PlayerInfo Player];
    [player setResource:1000];
    [player setLife:10];
    solController = [SoldierController Controller];
    [self addChild:solController];
    grid = [GridMap map];
    [grid setPosition:ccp(0,0)];
    CGSize gsize = [grid getCellSize];
    NSLog(@"grid size(%f, %f)", gsize.width, gsize.height);
    [self addChild:grid];
    gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
    // initialize wave queue layer
    ArmyQueue *aqueue = [ArmyQueue layer];
    [aqueue setPosition:ccp([[CCDirector sharedDirector] winSize].width-165,25)];
    [self addChild:aqueue z:2];
    
    //EDER DONT DELETE THIS!
    //register self observer, will recieve notifications when a tower was created
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotificationTower:) name:@"TowerOption" object:nil];
    
    
    // initialize wave controller
    waveController = [WaveController controller];
    
    //sets up world colision manager
    colissionsManager= [WorldColissionsManager Controller:grid];

    //Jimmy test life and resource layer

    resource_label = [CCLabelTTF labelWithString:@"Resource: " fontName:@"Outlier.ttf" fontSize:15];
    [self addChild:resource_label];
    resource_label.position = ccp(80,300);
    resource_number = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", [player getResource]] fontName:@"Outlier.ttf" fontSize:15];
    [self addChild:resource_number];
    resource_number.position = ccp(170,300);
    life_label = [CCLabelTTF labelWithString:@"Life: " fontName:@"Outlier.ttf" fontSize:15];
    [self addChild:life_label];
    life_label.position = ccp(400,300);
    
    life_number = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", [player getLife]] fontName:@"Outlier.ttf" fontSize:15];
    [self addChild:life_number];
    life_number.position = ccp(440,300);
    //used to position the text, in this case the bottom left screen
    /*
    [label2 setScale:0.5];
    [label2 setPosition:ccp(0,0)];
    [label2 setOpacity:200];
    
    */
   // [label2 setAnchorPoint:ccp(10, 100)];
    
    //USED FOR THE FACTORY OF TOWERS
    factoryTowers=[TowerFactory factory];

    [self addChild:supportCavas];
    [self scheduleUpdate];
    
    

    return self;
}

//creates tower and adds it to current active towers queue
- (void)receivedNotificationTower:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"TowerOption"]) {
        
    NSString *interface = [notification.userInfo objectForKey:@"point"];
    
    if ([interface isEqualToString:@"TowerA"] && [player getResource]>=humanPrice) {
        int newResource = [player getResource] - humanPrice;
        [player setResource:newResource];
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
        
        CCNode<Tower>* t3=[factoryTowers towerForKey:@"Support" Location:[self convertToWorldSpace:ccp(pointX,pointY)]];
         
        [colissionsManager addTower:t3];
        
        [grid addTower:t3 index:[[grid getTowerMenu] getMapLocation] z:1];
       
    } else if ([interface isEqualToString:@"TowerB"] && [player getResource]>=robotPrice) {

        float pointX=grid.menuLocation.x;
        float pointY=grid.menuLocation.y;
        int newResource = [player getResource] - robotPrice;
        [player setResource:newResource];
        CCLOG(@"End location.x in B %f", pointX);   //I just get location.x = 0
        CCLOG(@"End location.y in B %f", pointY);   //I just get location.y = 0       
        
        //TowerRobot* t3=[[TowerRobot alloc] initTower:[self convertToWorldSpace:ccp(pointX,pointY)]];
        CCNode<Tower>* tower=[factoryTowers towerForKey:@"Special" Location:[self convertToWorldSpace:ccp(pointX,pointY)]];
        [colissionsManager addTower:tower];
        [grid addTower:tower index:[[grid getTowerMenu] getMapLocation]  z:1];

    }else if ([interface isEqualToString:@"TowerC"] && [player getResource]>=robotPrice) {
        
        float pointX=grid.menuLocation.x;
        float pointY=grid.menuLocation.y;
        int newResource = [player getResource] - robotPrice;
        [player setResource:newResource];
        CCLOG(@"End location.x in C %f", pointX);   //I just get location.x = 0
        CCLOG(@"End location.y in C %f", pointY);   //I just get location.y = 0

        CCNode<Tower>* tower=[factoryTowers towerForKey:@"Attackv1" Location:[self convertToWorldSpace:ccp(pointX,pointY)]];
        [colissionsManager addTower:tower];
        [grid addTower:tower index:[[grid getTowerMenu] getMapLocation]  z:1];
        
    }
    [grid hideTowerMenu];
        
    }
}

- (void)update:(ccTime)delta
{
    [player increaseResource:delta];
    [resource_number setString:[NSString stringWithFormat:@"%d", [player getResource]]];
    [life_number setString:[NSString stringWithFormat:@"%d", [player getLife]]];

    //tower surveliance
     [colissionsManager surveliance];
    
    //update soldiers
    [solController updateSoldier:delta];
    
    
 //   [colissionsManager setSoldierArray:[solController getSoldierArray]];
     colissionsManager.soldiers=[solController getSoldierArray];
 
    if ([player getLife]==0) {
        

        
        
        [gameStatusEssentialsSingleton setPaused:true];
        /*CCLayerColor *pauseLayer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 75)];
         //add menu;
         CCMenuItemFont *item1 = [CCMenuItemFont itemWithString:@"BACK!" target:self selector:@selector(resume)];
         
         CCMenu *menu = [CCMenu menuWithItems:item1, nil];
         [pauseLayer addChild:menu z:110];
         
         [self addChild:pauseLayer z:15];*/
        
        // PauseScene* p=[[PauseScene alloc] init];
        //  [[CCDirector sharedDirector] replaceScene:[PauseScene scene]];
        //
        [[CCDirector sharedDirector] pushScene:[PauseScene node]];
        [[CCDirector sharedDirector] pause];
        // [[CCDirector sharedDirector] replaceScene:[PauseScene scene]];
        

    }
    
}

-(void) resume{
    
    [gameStatusEssentialsSingleton setPaused:false];
}


@end
