//
//  attacker.m
//  SolarColony
//
//  Created by Sophia Wu on 2/11/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "attacker.h"


@implementation attacker
@synthesize mobileDisplaySize;
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	attacker *layer = [attacker node];
	
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

@end
