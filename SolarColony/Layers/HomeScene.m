//
//  HomeScene.m
//  SolarColony
//
//  Created by Student on 2/7/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "HomeScene.h"
#import "GridMap.h"

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
        
        CCLabelTTF *splash = [CCLabelTTF labelWithString:@"Home Page" fontName:@"Marker Felt" fontSize:64];
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        
        [splash setPosition:ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5)];
        
        // test square cell
        
        GridMap *grid = [GridMap map];
        
        [self addChild:splash];
        [self addChild:[self loadMenu]];
        [self addChild:grid z:1];
    }
    return self;
}

- (CCMenu*)loadMenu
{
    CCMenuItemFont *manuItemStart=[CCMenuItemFont itemWithString:@"Start Game" target:self selector:@selector(moveToScenee:)];
    manuItemStart.tag=1;
    
    CCMenuItemFont *manuItemSettings=[CCMenuItemFont itemWithString:@"Settings"];
    manuItemStart.tag=2;
    
    CCMenu *mainMenu=[CCMenu menuWithItems:manuItemStart,manuItemSettings, nil];
    
    [mainMenu alignItemsHorizontallyWithPadding:20];
    
    [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2 - 50)];
    
    return mainMenu;
    
}

-(void)moveToScenee:(id)sender{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    NSLog(menuItem.label.string);
    //[transitionManagerSingleton transitionTo:menuItem.tag];
    
 }

- (void)dealloc
{
    [super dealloc];
    
}



@end
