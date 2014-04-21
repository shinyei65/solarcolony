//
//  MyCocos2DClass.m
//  SolarColony
//
//  Created by Student on 3/23/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "PauseScene.h"
#import "HomeScene.h"

@implementation PauseScene

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	PauseScene *layer = [PauseScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
-(id)init{
    if( (self=[super init] )) {
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Paused"
                                               fontName:@"Courier New"
                                               fontSize:30];
        label.position = ccp(240,190);
        [self addChild: label];
        [CCMenuItemFont setFontName:@"Courier New"];
        [CCMenuItemFont setFontSize:20];
        
        CCMenuItem *Resume= [CCMenuItemFont itemFromString:@"Resume"
                                                    target:self
                                                  selector:@selector(resume:)];
        CCMenuItem *Restart= [CCMenuItemFont itemFromString:@"Restart"
                                                    target:self
                                                  selector:@selector(restart:)];
        CCMenuItem *Quit = [CCMenuItemFont itemFromString:@"Quit Game"
                                                   target:self selector:@selector(GoToMainMenu:)];
        
        CCMenu *menu= [CCMenu menuWithItems: Resume, Restart, Quit, nil];
        menu.position = ccp(249, 131.67f);
        [menu alignItemsVerticallyWithPadding:12.5f];
        
        
        [self addChild:menu];
        
    }
    return self;
}

-(void) resume: (id) sender {
    
    // [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] popScene];
}

-(void) restart: (id) sender {
    
    // [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] popScene];
}

-(void) GoToMainMenu: (id) sender {
    
    [[CCDirector sharedDirector] sendCleanupToScene];
    [[CCDirector sharedDirector] popScene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1
                                               scene:[HomeScene node]]
     ];
}
/*
 - (id)init
 {
 self = [super initWithColor:ccc4(0, 0, 0, 75) width:200 height:200];
 if (self) {
 //Game status global variables
 gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
 }
 return self;
 }*/
@end
