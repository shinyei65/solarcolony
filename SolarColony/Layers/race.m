//
//  race.m
//  SolarColony
//
//  Created by Student on 2/10/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "race.h"
#import "HomeScene.h"
#import "defense.h"

@implementation race

@synthesize mobileDisplaySize;


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	race *layer = [race node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        //transition and music manager
        transitionManagerSingleton=[TransitionManagerSingleton sharedInstance];
        musicManagerSingleton = [MusicManagerSingleton shareSoundManager];
        
        //Game status global variables
        gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        [self addChild:[self loadMenu]];
    }
    return self;
}

- (CCMenu*)loadMenu
{
    CCLabelTTF *splash = [CCLabelTTF labelWithString:@"Select Race" fontName:@"Marker Felt" fontSize:32];
    [splash setPosition:ccp(100,280)];
    
    
    
    CCMenuItemImage *menuItemHuman=[CCMenuItemImage itemWithNormalImage:@"humanRace.png" selectedImage:@"humanRace.png" target:self selector:@selector(moveToScene:)];
    menuItemHuman.userData=@"Human";
    [menuItemHuman setPosition:ccp(30,100)];
    
    CCSprite *menuItemHumanBox = [CCSprite spriteWithFile:@"descriptionBox.png"];
    menuItemHumanBox.position = ccp(200,100);
    
    
    
    CCMenuItemImage *MenuItemRobot=[CCMenuItemImage itemWithNormalImage:@"robotRace.png" selectedImage:@"robotRace.png" target:self selector:@selector(moveToScene:)];
    
    MenuItemRobot.userData=@"Robot";
    [MenuItemRobot setPosition:ccp(280,100)];
    
    
    CCSprite *menuItemRobotBox = [CCSprite spriteWithFile:@"descriptionBox.png"];
    menuItemRobotBox.position = ccp(440,100);
    
    
    CCMenuItemImage *menuItemMagic=[CCMenuItemImage itemWithNormalImage:@"wizardRace.png" selectedImage:@"wizardRace.png" target:self selector:@selector(moveToScene:)];
    menuItemMagic.userData=@"Magic";
    [menuItemMagic setPosition:ccp(150,250)];
    
    
    CCSprite *menuItemWizardBox = [CCSprite spriteWithFile:@"descriptionBox.png"];
    menuItemWizardBox.position = ccp(320,250);
    
    
    CCMenu *mainMenu=[CCMenu menuWithItems:menuItemHuman,MenuItemRobot,menuItemMagic, nil];
    
    //[mainMenu alignItemsHorizontallyWithPadding:20];
    
    [mainMenu setPosition:ccp( 100 ,0)];
    
    CCSprite *bg = [CCSprite spriteWithFile:@"backgroundLayers.png"];
    bg.position = ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5);
    [self addChild:bg];
    [self addChild:menuItemHumanBox];
    [self addChild:menuItemRobotBox];
    [self addChild:menuItemWizardBox];
    [self addChild:splash];
    return mainMenu;
    
}

-(void)moveToScene:(id)sender{
    CCMenuItemImage* menuItem = (CCMenuItemImage*)sender;
    CCMenuItem *itm = (CCMenuItem *)sender;
    NSString *theData = (NSString *)itm.userData;
   
    if ([theData isEqualToString:@"Human"] ) {
        [gameStatusEssentialsSingleton setRaceType:@"Human"];
        [gameStatusEssentialsSingleton setUserID:@"User1"];
        [transitionManagerSingleton transitionTo:1];
    } else if ([theData isEqualToString:@"Robot"])  {
        [gameStatusEssentialsSingleton setRaceType:@"Robot"];
        [gameStatusEssentialsSingleton setUserID:@"User2"];
        [transitionManagerSingleton transitionTo:1];
    } else if ([theData isEqualToString:@"Magic"])  {
        [gameStatusEssentialsSingleton setRaceType:@"Magic"];
        [gameStatusEssentialsSingleton setUserID:@"User3"];
        [transitionManagerSingleton transitionTo:1];
    }
}

-(void)dealloc
{
    [super dealloc];
}

@end

