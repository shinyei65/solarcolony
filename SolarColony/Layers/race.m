//
//  race.m
//  SolarColony
//
//  Created by Student on 2/10/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "race.h"
#import "HomeScene.h"
#import "defense.h"

@implementation race

@synthesize mobileDisplaySize;


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	race *layer = [race node];
	
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
        
       // CCLabelTTF *splash = [CCLabelTTF labelWithString:@"RaceSelect" fontName:@"Marker Felt" fontSize:32];
        
        
        
       // [splash setPosition:ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5)];
        
        // test square cell
        
        
     //   [self addChild:splash];
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        [self addChild:[self loadMenu]];
    }
    return self;
}

- (CCMenu*)loadMenu
{
    CCMenuItem *menuItemHuman=[CCMenuItemFont itemWithString:@"Human" target:self selector:@selector(maketransition:)];
   
    
    CCMenuItem *MenuItemRobot=[CCMenuItemFont itemWithString:@"Robot"];
    
    CCMenuItem *menuItemMagic=[CCMenuItemFont itemWithString:@"Magic"];
    
    CCMenu *mainMenu=[CCMenu menuWithItems:menuItemHuman,MenuItemRobot,menuItemMagic, nil];
    
    [mainMenu alignItemsHorizontallyWithPadding:20];
    
    [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2)];
    
    return mainMenu;
    
}

-(void)maketransition:(id)sender{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionCrossFade transitionWithDuration:0.3 scene:[defense scene]]];
    
}

-(void)dealloc
{
    [super dealloc];
}

@end

