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
#import "GameLandingScene.h"
static defense *sharedInstance = nil;
@implementation defense{
    SoldierController *solController;
    WaveController *waveController;
    GridMap *grid;
    //eder dont delete
    WorldColissionsManager* colissionsManager;
    GameStatusEssentialsSingleton * gameStatusEssentialsSingleton;
    PlayerInfo* player;
    //CCLabelTTF *resource_label;
    CCLabelTTF *resource_number;
    //CCLabelTTF *life_label;
    CCLabelTTF *life_number;
    int humanPrice;
    int robotPrice;
    CCLayerColor *pauseLayer;
    TowerFactory* factoryTowers;
    bool isCharging;
    CCProgressTimer *timeBar;
    int counter;
}

+ (instancetype)scene
{
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
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
    [player setResource:5000];
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
    NSString *bar_img = nil;
    if([[gameStatusEssentialsSingleton raceType] isEqualToString:@"Human"]){
        bar_img = @"human_resource.gif";
    }else if([[gameStatusEssentialsSingleton raceType] isEqualToString:@"Human"]){
        bar_img = @"robot_resource.gif";
    }else{
        bar_img = @"magic_resource.gif";
    }
    CCSprite *resource_bar = [CCSprite spriteWithFile:bar_img];
    [resource_bar setPosition:ccp(120, 300)];
    resource_bar.opacity = 200;
    [self addChild:resource_bar];
    //resource_label = [CCLabelTTF labelWithString:@"Resource: " fontName:@"Outlier.ttf" fontSize:15];
    //[self addChild:resource_label];
    //resource_label.position = ccp(80,300);
    resource_number = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", [player getResource]] fontName:@"Outlier.ttf" fontSize:15];
    [self addChild:resource_number];
    resource_number.position = ccp(100,300);
    //life_label = [CCLabelTTF labelWithString:@"Life: " fontName:@"Outlier.ttf" fontSize:15];
    //[self addChild:life_label];
    //life_label.position = ccp(400,300);
    CCSprite *life_bar = [CCSprite spriteWithFile:@"life_bar.jpg"];
    [life_bar setPosition:ccp(450, 300)];
    life_bar.opacity = 200;
    [self addChild:life_bar];
    life_number = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", [player getLife]] fontName:@"Outlier.ttf" fontSize:15];
    [self addChild:life_number];
    life_number.position = ccp(440,300);
    
    //USED FOR THE FACTORY OF TOWERS
    factoryTowers=[TowerFactory factory];
    
    // back button
    CCMenuItemFont *manuItemBack=[CCMenuItemFont itemWithString:@"back" target:self selector:@selector(moveToScene:)];
    [manuItemBack setFontName:@"Outlier.ttf"];
    [manuItemBack setFontSize:15];
    CCMenu *mainMenu=[CCMenu menuWithItems:manuItemBack, nil];
    [mainMenu setPosition:ccp(50,15)];
    [self addChild:mainMenu z:20];


    
    // passive button
    CCMenuItemImage *manuItemPassive=[CCMenuItemImage itemWithNormalImage:@"panic.png" selectedImage:@"panicOn.png" target:self selector:@selector(triggerPassiveAbilities:)];
    CCMenu *passiveMenu=[CCMenu menuWithItems:manuItemPassive, nil];
    [passiveMenu setPosition:ccp(550,15)];
    [self addChild:passiveMenu z:20];


    [self addChild:supportCavas z:50];
    [self scheduleUpdate];    

    return self;
}

-(void)moveToScene:(id)sender{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    if ([menuItem.label.string isEqualToString:@"back"]) {
        [[CCDirector sharedDirector] pushScene:[GameLandingScene scene] ];
    }
}

-(void)triggerPassiveAbilities:(id)sender{

    if (isCharging==false) {
        if([[gameStatusEssentialsSingleton raceType] isEqualToString:@"Human"])
        {
            //passive for human
        }
        else if([[gameStatusEssentialsSingleton raceType] isEqualToString:@"Robot"]){
             //passive for robot
            for (TowerGeneric* tower in gameStatusEssentialsSingleton.towers) {
                    [tower beignHealed];
            }
            [self reloadAnimation];
        }else {
            //passive for wizard
        }
        
    }
}


-(void) reloadAnimation
{
    
    if (isCharging==false) {
        isCharging=true;
        CCProgressFromTo *to1 = [CCProgressFromTo actionWithDuration:20 from:100 to:0];
        CCSprite* progressSprite = [CCSprite spriteWithFile:@"panicCharging.png"];
        timeBar = [CCProgressTimer progressWithSprite:progressSprite];
        //[timeBar setAnchorPoint:ccp(.8, 0.5)];
        [timeBar setPosition:ccp(550,15)];
        [self addChild:timeBar z:50];
        [timeBar runAction:to1];
        [self schedule: @selector(doNothingCharge:) interval:20];
    }
    
}

-(void) doNothingCharge: (ccTime) dt{
     NSLog(@"stopped 1st scheduler");
    isCharging=false;
    [self unschedule:@selector(doNothingCharge:)];
 
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
        
    }else if ([interface isEqualToString:@"TowerD"] && [player getResource]>=[stats[race][@"Tower1"][@"price"] integerValue]) {
        
        float pointX=grid.menuLocation.x;
        float pointY=grid.menuLocation.y;
        int newResource = [player getResource] - [stats[race][@"Tower2"][@"price"] integerValue];
        [player setResource:newResource];
        
        CCNode<Tower>* tower=[factoryTowers towerForKey:@"Attackv2" Location:[self convertToWorldSpace:ccp(pointX,pointY)]];
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
        [[NetWorkManager NetWorkManager] setRewardtoAttacker:[[ArmyQueue layer] getCurrentAttacker] Reward: 1000];
        [gameStatusEssentialsSingleton setPaused:true];
        [[CCDirector sharedDirector] pause];
        [[CCDirector sharedDirector] pushScene:[PauseScene node]];
    }
    
}

-(void) resume{
    
    [gameStatusEssentialsSingleton setPaused:false];
    [gameStatusEssentialsSingleton setPaused:false];
    [[CCDirector sharedDirector] resume];
}

- (void) reset{
    [player setResource:5000];
    [player setLife:10];
    // remove tower(100) soldier(200)
    CCArray *arr= [CCArray arrayWithArray: [grid children]];
    for (CCNode *mynode in arr){
        // remove tower
        if (mynode.tag==100){
            TowerGeneric *tower = (TowerGeneric *) mynode;
            [tower stopAllActions];
            [tower unscheduleAllSelectors];
            //[tower.bullet stopAllActions];
            //[tower.bullet unscheduleAllSelectors];
            [grid removeTower:mynode];
        // remove soldier
        }else if(mynode.tag == 200){
            Soldier *sol = (Soldier *) mynode;
            [sol stopAllActions];
            [sol unscheduleAllSelectors];
            [[sol getBullet] stopAllActions];
            [[sol getBullet] unscheduleAllSelectors];
            [grid removeChild:sol cleanup:YES];
        }
    }
    [gameStatusEssentialsSingleton removeAllSoldiers];
    [gameStatusEssentialsSingleton removeAllTowers];
    // reset controller
    [solController reset];
    [waveController reset];
    [[ArmyQueue layer] reset];
    
    [self resume];
}

@end
