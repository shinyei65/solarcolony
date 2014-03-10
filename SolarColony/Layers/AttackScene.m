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
        networkManager = [NetWorkManager NetWorkManager];
       
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        
       // [splash setPosition:ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5)];
        

        [self addChild:[self loadMenu]];
    }
    return self;
}

- (CCMenu*)loadMenu
{
    CCMenuItemFont *menuItemStart=[CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(moveToScene:)];
    [menuItemStart setFontSize:20];
    menuItemStart.tag=1;
    CCMenuItemFont *menuItemSoldierSelect=[CCMenuItemFont itemWithString:@"Manage your soldiers" target:self selector:@selector(moveToScene:)];
    [menuItemSoldierSelect setFontSize:20];
    menuItemSoldierSelect.tag=2;
    CCMenuItem *attackBotton=[CCMenuItemImage itemWithNormalImage:@"attackBotton.png" selectedImage:@"attackBotton_select.png" target:self selector:@selector(sendAttack)];
    
    menuItemStart.position=ccp(0,0);
    menuItemSoldierSelect.position=ccp(0,50);
    attackBotton.position=ccp(50,100);

    
    CCMenu *mainMenu=[CCMenu menuWithItems:menuItemStart,menuItemSoldierSelect,attackBotton, nil];
    
   // [mainMenu alignItemsHorizontallyWithPadding:20];
    
    [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2 - 100)];
    
    return mainMenu;
    
}

-(void)sendAttack{
    Army* test;
    [[NetWorkManager NetWorkManager] sendAttackRequest:test];
    CCLOG(@"SEND ATTACK!!!");
}

-(void)moveToScene:(id)sender{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    if ([menuItem.label.string isEqualToString:@"Back"]) {
        [transitionManagerSingleton transitionTo:1];
    } else if ([menuItem.label.string isEqualToString:@"Manage your soldiers"]) {
        [transitionManagerSingleton transitionTo:9];
    }

}


- (void)dealloc
{
    [super dealloc];
    
}



@end
