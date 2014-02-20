//
//  GameLandingScene.m
//  SolarColony
//
//  Created by Student on 2/7/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "GameLandingScene.h"

@implementation GameLandingScene
@synthesize mobileDisplaySize;
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLandingScene *layer = [GameLandingScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        transitionManagerSingleton=[TransitionManagerSingleton sharedInstance];
        musicManagerSingleton = [MusicManagerSingleton shareSoundManager];
        
        CCLabelTTF *splash = [CCLabelTTF labelWithString:@"Landing Page" fontName:@"Marker Felt" fontSize:32];
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        
        [splash setPosition:ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5)];
        
        [self addChild:splash];
        [self addChild:[self loadMenu]];
    }
    return self;
}

- (CCMenu*)loadMenu
{
    CCMenuItemFont *manuItemFriends=[CCMenuItemFont itemWithString:@"Friends" target:self selector:@selector(moveToScene:)];
    
    CCMenuItemFont *manuItemDefense=[CCMenuItemFont itemWithString:@"DeFense" target:self selector:@selector(moveToScene:)];
    
    CCMenuItemFont *manuItemattack=[CCMenuItemFont itemWithString:@"Attack" target:self selector:@selector(moveToScene:)];
    
    CCMenuItemFont *manuItemdefenseSetting=[CCMenuItemFont itemWithString:@"TowersSet" target:self selector:@selector(moveToScene:)];
    
    CCMenu *mainMenu=[CCMenu menuWithItems:manuItemFriends,manuItemDefense,manuItemattack, manuItemdefenseSetting, nil];
    
    [mainMenu alignItemsHorizontallyWithPadding:20];
    
    [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2 - 50)];
    
    return mainMenu;
    
}

-(void)moveToScene:(id)sender{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    if ([menuItem.label.string isEqualToString:@"Friends"]) {
        [transitionManagerSingleton transitionTo:5];
    } else if ([menuItem.label.string isEqualToString:@"DeFense"])  {
        [transitionManagerSingleton transitionTo:3];
    } else if ([menuItem.label.string isEqualToString:@"Attack"])  {
        [transitionManagerSingleton transitionTo:6];
    } else if ([menuItem.label.string isEqualToString:@"TowersSet"])  {
        [transitionManagerSingleton transitionTo:8];
    }
    // NSLog(menuItem.label.string);
    
}


- (void)dealloc
{
    [super dealloc];
    
}

@end
