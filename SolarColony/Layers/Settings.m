//
//  Settings.m
//  SolarColony
//
//  Created by Po-Yi Lee on 2/10/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "Settings.h"
#import "HomeScene.h"

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
        
        CCLabelTTF *splash = [CCLabelTTF labelWithString:@"Settings" fontName:@"Marker Felt" fontSize:64];
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        
        [splash setPosition:ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5)];
        
        [self addChild:splash];
        [self addChild:[self loadMenu]];
    }
    return self;
}
- (CCMenu*)loadMenu
{
    CCMenuItemFont *manuItemAccount=[CCMenuItemFont itemWithString:@"Account"];
    manuItemAccount.tag=1;
    
    CCMenuItemFont *manuItemMusic=[CCMenuItemFont itemWithString:@"Music"];
    manuItemMusic.tag=2;
    
    CCMenuItemFont *manuItemSound=[CCMenuItemFont itemWithString:@"Sound"];
    manuItemSound.tag=3;
    
    CCMenuItemFont *manuItemBack=[CCMenuItemFont itemWithString:@"Back"
        target:self selector:@selector(moveToScene:)];
    manuItemBack.tag=4;
    
    CCMenu *mainMenu=[CCMenu menuWithItems: manuItemAccount, manuItemMusic, manuItemSound, manuItemBack, nil];
    
    [mainMenu alignItemsHorizontallyWithPadding:20];
    
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
- (void)dealloc
{
    [super dealloc];
}



@end
