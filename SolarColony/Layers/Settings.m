//
//  Settings.m
//  SolarColony
//
//  Created by Po-Yi Lee on 2/10/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "Settings.h"
#import "HomeScene.h"
#import "SimpleAudioEngine.h"

@implementation Settings
@synthesize mobileDisplaySize;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Settings *layer = [Settings node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    self = [super init];
    if (self) {
        transitionManagerSingleton=[TransitionManagerSingleton sharedInstance];
        musicManagerSingleton = [MusicManagerSingleton shareSoundManager];
        
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        
        
        [self addChild:[self loadMenu]];
    }
    return self;
}
- (CCMenu*)loadMenu
{
    CCMenuItemFont *menuItemAccount=[CCMenuItemFont itemWithString:@"Account"];
    menuItemAccount.tag=1;
    
    CCMenuItemFont *menuItemMusic=[CCMenuItemFont itemWithString:@"Music"];
    menuItemMusic.tag=2;
    CCMenuItemFont *menuItemMusicOn=[CCMenuItemFont itemWithString:@"On" target:self selector:@selector(turnsound:)];
    CCMenuItemFont *menuItemMusicOff=[CCMenuItemFont itemWithString:@"Off" target:self selector:@selector(turnsound:)];
    CCMenuItemFont *menuItemSound=[CCMenuItemFont itemWithString:@"Sound"];
    menuItemSound.tag=3;
    CCMenuItemFont *menuItemSoundOn=[CCMenuItemFont itemWithString:@"On"];
    CCMenuItemFont *menuItemSoundOff=[CCMenuItemFont itemWithString:@"Off"];
    CCMenuItemFont *menuItemBack=[CCMenuItemFont itemWithString:@"Back"
                                                         target:self selector:@selector(moveToScene:)];
    menuItemBack.tag=4;
    
    CCMenu *mainMenu=[CCMenu menuWithItems: menuItemAccount, menuItemMusic, menuItemMusicOn, menuItemMusicOff, menuItemSound, menuItemSoundOn, menuItemSoundOff, menuItemBack, nil];
    
    [mainMenu alignItemsInColumns:[NSNumber numberWithInt:1],[NSNumber numberWithInt:3],[NSNumber numberWithInt:3],[NSNumber numberWithInt:1], nil];
    //[mainMenu alignItemsVerticallyWithPadding:20];
    
    [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2 - 50)];
    
    return mainMenu;
    
}

-(void)moveToScene:(id)sender
{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    if ([menuItem.label.string isEqualToString:@"Back"]) {
        [transitionManagerSingleton transitionTo:4];
    }
  //  [[CCDirector sharedDirector]replaceScene:[CCTransitionCrossFade transitionWithDuration:0.3 scene:[HomeScene node]]];
}
-(void)turnsound:(id)sender{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    if([menuItem.label.string isEqualToString:@"Off"])
    {
        [[SimpleAudioEngine sharedEngine]pauseBackgroundMusic];
        
    }
    else {
        [[SimpleAudioEngine sharedEngine]resumeBackgroundMusic];
    }
}
- (void)dealloc
{
    [super dealloc];
}



@end
