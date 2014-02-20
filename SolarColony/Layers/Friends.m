//
//  Friends.m
//  SolarColony
//
//  Created by Po-Yi Lee on 2/8/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "Friends.h"
#import "HomeScene.h"
#import "TowerHuman.h"

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
        
        TowerHuman* t1=[[TowerHuman alloc] initTower:[self convertToWorldSpace:ccp(200 , 100)]];
        [colissionsManager addTower:t1];
        [self addChild:t1];
        
        
        TowerHuman* t2=[[TowerHuman alloc] initTower:[self convertToWorldSpace:ccp(50 , 200)]];
        [colissionsManager addTower:t2];
        [self addChild:t2];
        
        TowerHuman* t3=[[TowerHuman alloc] initTower:[self convertToWorldSpace:ccp(300 , 300)]];
        [colissionsManager addTower:t3];
        [self addChild:t3];
        
        //Test sprite sheet
        CCSpriteFrameCache *cache=[CCSpriteFrameCache sharedSpriteFrameCache];
        [cache addSpriteFramesWithFile:@"Sam.plist"];
        
        // frame array
        NSMutableArray *framesArray=[NSMutableArray array];
        for (int i=1; i<=4; i++) {
            NSString *frameName=[NSString stringWithFormat:@"drummer%d.png", i];
            id frameObject=[cache spriteFrameByName:frameName];
            [framesArray addObject:frameObject];
        }
        
        // animation object
        id animObject=[CCAnimation animationWithFrames:framesArray delay:0.1];
        
        // animation action
        id animAction=[CCAnimate actionWithAnimation:animObject restoreOriginalFrame:NO];
        animAction=[CCRepeatForever actionWithAction:animAction];
        
        // sprite
        CCSprite *drummer=[CCSprite spriteWithSpriteFrameName:@"drummer1.png"];
        drummer.position=ccp(160,160);
        [self addChild:drummer];
        
        [drummer runAction:animAction];
        
        CCSpriteFrameCache *cache_pink=[CCSpriteFrameCache sharedSpriteFrameCache];
        [cache_pink addSpriteFramesWithFile:@"flamingo.plist"];
        
        // frame array
        NSMutableArray *framesArray_pink=[NSMutableArray array];
        for (int i=1; i<=3; i++) {
            NSString *frameName=[NSString stringWithFormat:@"flamingo%d.png", i];
            id frameObject=[cache_pink spriteFrameByName:frameName];
            [framesArray_pink addObject:frameObject];
        }
        
        // animation object
        id animObject_pink=[CCAnimation animationWithFrames:framesArray_pink delay:0.1];
        
        // animation action
        id animAction_pink=[CCAnimate actionWithAnimation:animObject_pink restoreOriginalFrame:NO];
        animAction_pink=[CCRepeatForever actionWithAction:animAction_pink];
        
        // sprite
        CCSprite *pink=[CCSprite spriteWithSpriteFrameName:@"drummer1.png"];
        pink.position=ccp(300,100);
        [self addChild:pink];
        
        [pink runAction:animAction_pink];


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
