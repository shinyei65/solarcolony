//
//  MyCocos2DClass.m
//  SolarColony
//
//  Created by Student on 3/23/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "PauseScene.h"


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

- (id)init
{
    self = [super init];
    if (self) {
       
 
        //Game status global variables
        gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
        
    }
    return self;
}
@end
