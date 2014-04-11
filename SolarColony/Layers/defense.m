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
#import "GameStatsLoader.h"

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
    
    gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
    // initialize stats
    GameStatsLoader *statsLoader = [GameStatsLoader loader];
    
    // initial grid map
    grid = [GridMap map];
    [grid setPosition:ccp(0,0)];
    CGSize gsize = [grid getCellSize];
    NSLog(@"grid size(%f, %f)", gsize.width, gsize.height);
    [self addChild:grid];
    
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
    
    //USED FOR THE FACTORY OF TOWERS
    factoryTowers=[TowerFactory factory];

    [self addChild:supportCavas z:50];
    [self scheduleUpdate];
    
    

    return self;
}

//creates tower and adds it to current active towers queue
- (void)receivedNotificationTower:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"TowerOption"]) {
        
    NSString *interface = [notification.userInfo objectForKey:@"point"];
    NSString *race = gameStatusEssentialsSingleton.raceType;
    NSMutableDictionary *stats = [GameStatsLoader loader].stats;
    
    
    if ([interface isEqualToString:@"TowerA"] && [player getResource]>=humanPrice) {
        int newResource = [player getResource] - humanPrice;
        [player setResource:newResource];
        
        float pointX=grid.menuLocation.x;
        float pointY=grid.menuLocation.y;
        
        CCNode<Tower>* t3=[factoryTowers towerForKey:@"Support" Location:[self convertToWorldSpace:ccp(pointX,pointY)]];
        [t3 setMapLocation:[[grid getTowerMenu] getMapLocation]];
        [colissionsManager addTower:t3];
        [grid addTower:t3 index:[[grid getTowerMenu] getMapLocation] z:1];
       
    } else if ([interface isEqualToString:@"TowerB"] && [player getResource]>=robotPrice) {

        float pointX=grid.menuLocation.x;
        float pointY=grid.menuLocation.y;
        int newResource = [player getResource] - robotPrice;
        [player setResource:newResource];

        CCNode<Tower>* tower=[factoryTowers towerForKey:@"Special" Location:[self convertToWorldSpace:ccp(pointX,pointY)]];
        [tower setMapLocation:[[grid getTowerMenu] getMapLocation]];
        [colissionsManager addTower:tower];
        [grid addTower:tower index:[[grid getTowerMenu] getMapLocation]  z:1];

    }else if ([interface isEqualToString:@"TowerC"] && [player getResource]>=[stats[race][@"Tower1"][@"price"] integerValue]) {
        
        float pointX=grid.menuLocation.x;
        float pointY=grid.menuLocation.y;
        int newResource = [player getResource] - [stats[race][@"Tower1"][@"price"] integerValue];
        [player setResource:newResource];

        CCNode<Tower>* tower=[factoryTowers towerForKey:@"Attackv1" Location:[self convertToWorldSpace:ccp(pointX,pointY)]];
        [tower setMapLocation:[[grid getTowerMenu] getMapLocation]];
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

     colissionsManager.soldiers=[solController getSoldierArray];
 
    if ([player getLife]==0) {
        [gameStatusEssentialsSingleton setPaused:true];
        [[CCDirector sharedDirector] pushScene:[PauseScene node]];
        [[CCDirector sharedDirector] pause];
    }
    
}

-(void) resume{
    
    [gameStatusEssentialsSingleton setPaused:false];
}


@end
