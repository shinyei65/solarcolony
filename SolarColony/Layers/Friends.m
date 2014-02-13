//
//  Friends.m
//  SolarColony
//
//  Created by Po-Yi Lee on 2/8/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "Friends.h"
#import "HomeScene.h"

@implementation Friends
@synthesize mobileDisplaySize;


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Friends *layer = [Friends node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id)init
{
    self = [super init];
    [self setTouchEnabled:YES];
    
    if (self) {
        
        
         transitionManagerSingleton=[TransitionManagerSingleton sharedInstance];
        
        CCLabelTTF *splash = [CCLabelTTF labelWithString:@"Friends" fontName:@"Marker Felt" fontSize:64];
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        
        [splash setPosition:ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5)];
        
        [self addChild:splash];
        [self addChild:[self loadMenu]];
        
        //temp
          [self scheduleUpdate];
        colissionsManager= [[WorldColissionsManager alloc] init];
        
        
       
    }
    return self;
}

- (CCMenu*)loadMenu
{
    CCMenuItemFont *manuItemBack=[CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(moveToScene:)];
    manuItemBack.tag=1;
    
    CCMenu *mainMenu=[CCMenu menuWithItems:manuItemBack, nil];
    
    [mainMenu alignItemsHorizontallyWithPadding:20];
    
    [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2 - 50)];
    
    return mainMenu;

}

-(void)moveToScene:(id)sender
{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    if ([menuItem.label.string isEqualToString:@"Back"]) {
        [transitionManagerSingleton transitionTo:1];
    }
}

- (void)update:(ccTime)delta
{
    
   
}
-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    CCLOG(@"ccTouchBeganRuby");
    
    
    location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL: location];
 
    // end:
    
    CCLOG(@"End location.x %f", location.x);   //I just get location.x = 0
    CCLOG(@"End location.y %f", location.y);   //I just get location.y = 0
    return YES;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView: [touch view]];
    CGPoint prevLocation = [touch previousLocationInView: [touch view]];
    
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    prevLocation = [[CCDirector sharedDirector] convertToGL: prevLocation];
    
    CGPoint diff = ccpSub(touchLocation,prevLocation);
    
    CCLOG(@"End location.x %f", diff.x);   //I just get location.x = 0
    CCLOG(@"End location.y %f", diff.y);   //I just get location.y = 0
}

- (void)dealloc
{
    [super dealloc];
}


@end
