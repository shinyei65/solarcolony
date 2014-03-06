//
//  AttackScene.m
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "AttackScene.h"

@implementation AttackScene
@synthesize mobileDisplaySize;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AttackScene *layer = [AttackScene node];
    
    AttackScene *selectlayer = [AttackScene node];
    
	
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
        
       
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        
       // [splash setPosition:ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5)];
        

        [self addChild:[self loadMenu]];
    }
    return self;
}

- (CCMenu*)loadMenu
{
    CCMenuItemFont *manuItemStart=[CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(moveToScene:)];
    manuItemStart.tag=1;
    CCMenuItem *attackBotton=[CCMenuItemImage itemWithNormalImage:@"attackBotton.png" selectedImage:@"attackBotton_select.png" target:self selector:@selector(sendAttack)];
    
    attackBotton.position=ccp(50,100);
    
    CCMenu *mainMenu=[CCMenu menuWithItems:manuItemStart,attackBotton, nil];
    
   // [mainMenu alignItemsHorizontallyWithPadding:20];
    
    [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2 - 50)];
    
    return mainMenu;
    
}

-(void)sendAttack{
    CCLOG(@"SEND ATTACK!!!");
}

-(void)moveToScene:(id)sender{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    if ([menuItem.label.string isEqualToString:@"Back"]) {
        [transitionManagerSingleton transitionTo:1];
    }  

}


- (void)dealloc
{
    [super dealloc];
    
}



@end
