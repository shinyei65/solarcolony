//
//  Friends.m
//  SolarColony
//
//  Created by Po-Yi Lee on 2/8/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "Friends.h"
#import "HomeScene.h"
#import "TowerBasic.h"

@implementation Friends
@synthesize mobileDisplaySize;


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Friends *layer = [Friends node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id)init
{
    self = [super init];
    [self setTouchEnabled:YES];
    
    if (self) {
        
        
        transitionManagerSingleton=[TransitionManagerSingleton sharedInstance];
        musicManagerSingleton = [MusicManagerSingleton shareSoundManager];
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        
        /*CCLabelTTF *splash = [CCLabelTTF labelWithString:@"Friends" fontName:@"Marker Felt" fontSize:64];        [splash setPosition:ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5)];
        
        [self addChild:splash];*/
        [self addChild:[self loadMenu]];
        
        //temp
          [self scheduleUpdate];
        colissionsManager= [[WorldColissionsManager alloc] init];
        
        TowerBasic* t1=[[TowerBasic alloc] initTower:[self convertToWorldSpace:ccp(200 , 100)]];
        [colissionsManager addTower:t1];
        [self addChild:t1];
        
        
        TowerBasic* t2=[[TowerBasic alloc] initTower:[self convertToWorldSpace:ccp(50 , 200)]];
        [colissionsManager addTower:t2];
        [self addChild:t2];
        
        TowerBasic* t3=[[TowerBasic alloc] initTower:[self convertToWorldSpace:ccp(300 , 300)]];
        [colissionsManager addTower:t3];
        [self addChild:t3];
        
        
        
        
        
       
    }
    return self;
}

- (CCMenu*)loadMenu
{
    CCMenuItemFont *manuItemBack=[CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(moveToScene:)];
    manuItemBack.tag=1;
    
    CCMenu *mainMenu=[CCMenu menuWithItems:manuItemBack, nil];
    
    [mainMenu alignItemsHorizontallyWithPadding:20];
    
    [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2 - 50)];
    
    return mainMenu;

}

-(void)moveToScene:(id)sender
{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    if ([menuItem.label.string isEqualToString:@"Back"]) {
        [transitionManagerSingleton transitionTo:1];
    }
}

- (void)update:(ccTime)delta
{
    [colissionsManager surveliance];
   
}
-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    CCLOG(@"ccTouchBeganRuby");
    
    
    location = [touch locationInView: [touch view]];
    //location = [[CCDirector sharedDirector] convertToGL: location];
 
    // end:
    [colissionsManager addSoldierTest:location] ;
    
    CCLOG(@"End location.x %f", location.x);   //I just get location.x = 0
    CCLOG(@"End location.y %f", location.y);   //I just get location.y = 0
    return YES;
}


- (void)dealloc
{
    [super dealloc];
}


@end
