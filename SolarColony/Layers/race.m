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
        //transition and music manager
        transitionManagerSingleton=[TransitionManagerSingleton sharedInstance];
        musicManagerSingleton = [MusicManagerSingleton shareSoundManager];
        
        //Game status global variables
        gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        [self addChild:[self loadMenu]];
    }
    return self;
}

- (CCMenu*)loadMenu
{
    CCMenuItemFont *menuItemHuman=[CCMenuItemFont itemWithString:@"Human" target:self selector:@selector(moveToScene:)];
    
    CCMenuItemFont *MenuItemRobot=[CCMenuItemFont itemWithString:@"Robot" target:self selector:@selector(moveToScene:)];
    
    CCMenuItemFont *menuItemMagic=[CCMenuItemFont itemWithString:@"Magic" target:self selector:@selector(moveToScene:)];
    
    CCMenu *mainMenu=[CCMenu menuWithItems:menuItemHuman,MenuItemRobot,menuItemMagic, nil];
    
    [mainMenu alignItemsHorizontallyWithPadding:20];
    
    [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2)];
    
    return mainMenu;
    
}

-(void)moveToScene:(id)sender{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    if ([menuItem.label.string isEqualToString:@"Human"]) {
        [gameStatusEssentialsSingleton setRaceType:@"Human"];
        [transitionManagerSingleton transitionTo:1];
    } else if ([menuItem.label.string isEqualToString:@"Robot"])  {
        [gameStatusEssentialsSingleton setRaceType:@"Robot"];
        [transitionManagerSingleton transitionTo:1];
    } else if ([menuItem.label.string isEqualToString:@"Magic"])  {
        [gameStatusEssentialsSingleton setRaceType:@"Magic"];
        [transitionManagerSingleton transitionTo:1];
    }
}

-(void)dealloc
{
    [super dealloc];
}

@end

