//
//  HomeScene.m
//  SolarColony
//
//  Created by Student on 2/7/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "HomeScene.h"
#import "race.h"
#import "Settings.h"

@implementation HomeScene
@synthesize mobileDisplaySize;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HomeScene *layer = [HomeScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
       // transitionManagerSingleton=[TransitionManagerSingleton sharedInstance];
        
        CCLabelTTF *splash = [CCLabelTTF labelWithString:@"Solar Colony" fontName:@"Marker Felt" fontSize:64];
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        
        [splash setPosition:ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5)];
        
        [self addChild:splash];
        [self addChild:[self loadMenu]];
    }
    return self;
}

- (CCMenu*)loadMenu
{
    CCMenuItemFont *manuItemStart=[CCMenuItemFont itemWithString:@"Start Game" target:self selector:@selector(moveToScenee:)];
    manuItemStart.tag=1;
    
    CCMenuItemFont *manuItemSettings=[CCMenuItemFont itemWithString:@"Settings"
        target:self selector:@selector(moveToSettings:)];
    manuItemStart.tag=2;
    
    CCMenu *mainMenu=[CCMenu menuWithItems:manuItemStart,manuItemSettings, nil];
    
    [mainMenu alignItemsHorizontallyWithPadding:20];
    
    [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2 - 50)];
    
    return mainMenu;
    
}

-(void)moveToScenee:(id)sender{
   /* CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    NSLog(menuItem.label.string);
    //[transitionManagerSingleton transitionTo:menuItem.tag];
    */
    [[CCDirector sharedDirector]replaceScene:[CCTransitionCrossFade transitionWithDuration:0.3 scene:[race node]]];
 }
-(void)moveToSettings:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionCrossFade transitionWithDuration:0.3 scene:[Settings node]]];
}

- (void)dealloc
{
    [super dealloc];
    
}



@end
