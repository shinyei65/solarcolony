//
//  HomeScene.m
//  SolarColony
//
//  Created by Student on 2/7/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "HomeScene.h"

@implementation HomeScene
@synthesize windomSize;
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
        
        CCLabelTTF *splash = [CCLabelTTF labelWithString:@"Home Page" fontName:@"Marker Felt" fontSize:64];
        
        windomSize= [[CCDirector sharedDirector] winSize];
        
        [splash setPosition:ccp(windomSize.width*.5, windomSize.height*.5)];
        
        [self addChild:splash];
        [self addChild:[self loadMenu]];
    }
    return self;
}

- (CCMenu*)loadMenu
{
    CCMenuItemFont *manuItemStart=[CCMenuItemFont itemWithString:@"Start Game"];
    
    CCMenuItemFont *manuItemSettings=[CCMenuItemFont itemWithString:@"Settings"];
    
    CCMenu *mainMenu=[CCMenu menuWithItems:manuItemStart,manuItemSettings, nil];
    
    [mainMenu alignItemsHorizontallyWithPadding:20];
    
    [mainMenu setPosition:ccp( windomSize.width/2, windomSize.height/2 - 50)];
    
    return mainMenu;
    
}
    
- (void)dealloc
{
    [super dealloc];
    
}

@end
