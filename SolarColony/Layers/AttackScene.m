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
        
        int *army_num = 1;
       // [splash setPosition:ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5)];
        CCSprite *bg = [CCSprite spriteWithFile:@"AttackPage_wallpaper.jpg"];
        bg.position = ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5);
        [self addChild:bg];

        [self addChild:[self loadMenu]];
    }
    return self;
}




- (CCMenu*)loadMenu
{
    
    
    
    
    CCMenuItemFont *menuItemArmy1=[CCMenuItemFont itemWithString:@"Army 1" target:self selector:@selector(moveToScene:)];
    menuItemArmy1.tag = 1;
    CCMenuItemFont *menuItemArmy2=[CCMenuItemFont itemWithString:@"Army 2" target:self selector:@selector(moveToScene:)];
    menuItemArmy1.tag = 2;
    menuItemArmy2.visible = false;
    CCMenuItemFont *menuItemArmy3=[CCMenuItemFont itemWithString:@"Army 3" target:self selector:@selector(moveToScene:)];
    menuItemArmy1.tag = 3;
    menuItemArmy3.visible = false;
    CCMenuItemFont *menuItemArmy4=[CCMenuItemFont itemWithString:@"Army 4" target:self selector:@selector(moveToScene:)];
    menuItemArmy1.tag = 4;
    menuItemArmy4.visible = false;
    CCMenuItemFont *menuItemArmy5=[CCMenuItemFont itemWithString:@"Army 5" target:self selector:@selector(moveToScene:)];
    menuItemArmy1.tag = 5;
    menuItemArmy5.visible = false;
    [menuItemArmy1 setFontSize:20];
    [menuItemArmy2 setFontSize:20];
    [menuItemArmy3 setFontSize:20];
    [menuItemArmy4 setFontSize:20];
    [menuItemArmy5 setFontSize:20];
    CCMenuItem *attackBotton=[CCMenuItemImage itemWithNormalImage:@"attackBotton.png" selectedImage:@"attackBotton_select.png" target:self selector:@selector(sendAttack)];
    
   CCMenuItem *attackBotton_inactive2=[CCMenuItemImage itemWithNormalImage:@"attackBotton.png" selectedImage:@"attackBotton_select.png"];
    attackBotton_inactive2.visible = false;
    CCMenuItem *attackBotton_inactive3=[CCMenuItemImage itemWithNormalImage:@"attackBotton.png" selectedImage:@"attackBotton_select.png"];
    attackBotton_inactive3.visible = false;
    CCMenuItem *attackBotton_inactive4=[CCMenuItemImage itemWithNormalImage:@"attackBotton.png" selectedImage:@"attackBotton_select.png"];
    attackBotton_inactive4.visible = false;
    CCMenuItem *attackBotton_inactive5=[CCMenuItemImage itemWithNormalImage:@"attackBotton.png" selectedImage:@"attackBotton_select.png"];
    attackBotton_inactive5.visible = false;
    CCMenuItemFont *menuItemBack=[CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(moveToScene:)];
    [menuItemBack setFontSize:20];
    //menuItemStart.position=ccp(0,0);
    //menuItemSoldierSelect.position=ccp(0,50);
    //attackBotton.position=ccp(50,100);

    
    CCMenu *mainMenu=[CCMenu menuWithItems:menuItemArmy1,attackBotton,menuItemArmy2,attackBotton_inactive2,menuItemArmy3,attackBotton_inactive3,menuItemArmy4,attackBotton_inactive4,menuItemArmy5,attackBotton_inactive5,menuItemBack,nil];
    
    
    [mainMenu alignItemsInColumns:[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:1], nil];
    
   // CCMenu *mainMenu=[CCMenu menuWithItems:menuItemStart,menuItemSoldierSelect,attackBotton, nil];
    
   // [mainMenu alignItemsHorizontallyWithPadding:20];
    
    [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2)];
    
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
    } else if ([menuItem.label.string isEqualToString:@"Army 1"]) {
        [transitionManagerSingleton transitionTo:9];
    }

}

-(void)AddNewItem:(id)sender{
    
}



- (void)dealloc
{
    [super dealloc];
    
}



@end
