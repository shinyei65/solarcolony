//
//  GameLandingScene.m
//  SolarColony
//
//  Created by Student on 2/7/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "GameLandingScene.h"

@implementation GameLandingScene
@synthesize mobileDisplaySize;
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLandingScene *layer = [GameLandingScene node];
	
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
        
        CCLabelTTF *splash = [CCLabelTTF labelWithString:@"Player X" fontName:@"Marker Felt" fontSize:32];
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        
        [splash setPosition:ccp(mobileDisplaySize.width*.8, mobileDisplaySize.height*.9)];
        
        CCSprite *bg = [CCSprite spriteWithFile:@"backgroundLayers.png"];
        bg.position = ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5);
        
        //Game status global variables
        gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
        CCSprite *raceSprite;
        NSString * raceType=gameStatusEssentialsSingleton.raceType;
        if ([raceType isEqualToString:@"Human"]) {
            raceSprite = [CCSprite spriteWithFile:@"humanRace.png"];
            raceSprite.position = ccp(mobileDisplaySize.width*.18, mobileDisplaySize.height*.35);
        } else if ([raceType isEqualToString:@"Robot"]) {
            raceSprite = [CCSprite spriteWithFile:@"robotRace.png"];
            raceSprite.position = ccp(mobileDisplaySize.width*.18, mobileDisplaySize.height*.35);
        } else if ([raceType isEqualToString:@"Magic"]) {
            raceSprite = [CCSprite spriteWithFile:@"wizardRace.png"];
            raceSprite.position = ccp(mobileDisplaySize.width*.18, mobileDisplaySize.height*.35);
        }
        
        CCSprite *score = [CCSprite spriteWithFile:@"score.png"];
        score.position = ccp(mobileDisplaySize.width*.225, mobileDisplaySize.height*.85);
        
        CCSprite *ranking = [CCSprite spriteWithFile:@"rankin.png"];
        ranking.position = ccp(mobileDisplaySize.width*.2, mobileDisplaySize.height*.75);
        
        CCSprite *kills = [CCSprite spriteWithFile:@"kills.png"];
        kills.position = ccp(mobileDisplaySize.width*.35, mobileDisplaySize.height*.4);
        
        CCSprite *towers = [CCSprite spriteWithFile:@"towers.png"];
        towers.position = ccp(mobileDisplaySize.width*.35, mobileDisplaySize.height*.3);
        
        CCSprite *soldiers = [CCSprite spriteWithFile:@"soldiers.png"];
        soldiers.position = ccp(mobileDisplaySize.width*.35, mobileDisplaySize.height*.2);
        
        [self addChild:bg];
        
        [self addChild:raceSprite];
        [self addChild:score];
        [self addChild:ranking];
        [self addChild:kills];
        [self addChild:towers];
        [self addChild:soldiers];
        [self addChild:splash];
        [self addChild:[self loadMenu]];
    }
    return self;
}

- (CCMenu*)loadMenu
{
    CCMenuItemImage *manuItemFriends=[CCMenuItemImage itemWithNormalImage:@"foff.png" selectedImage:@"fon.png" target:self selector:@selector(moveToScene:)];
    manuItemFriends.userData=@"Friends";
    CCMenuItemImage *manuItemDefense=[CCMenuItemImage itemWithNormalImage:@"doff.png" selectedImage:@"don.png" target:self selector:@selector(moveToScene:)];
    manuItemDefense.userData=@"DeFense";
    CCMenuItemImage *manuItemattack=[CCMenuItemImage itemWithNormalImage:@"aoff.png" selectedImage:@"aon.png" target:self selector:@selector(moveToScene:)];
    manuItemattack.userData=@"Attack";
    CCMenuItemImage *manuItemdefenseSetting=[CCMenuItemImage itemWithNormalImage:@"toff.png" selectedImage:@"ton.png" target:self selector:@selector(moveToScene:)];
    manuItemdefenseSetting.userData=@"TowersSet";
    CCMenu *mainMenu=[CCMenu menuWithItems:manuItemFriends,manuItemDefense,manuItemattack, manuItemdefenseSetting, nil];
    
    
    [mainMenu alignItemsVerticallyWithPadding:20];
    
    [mainMenu setPosition:ccp( mobileDisplaySize.width*.7, mobileDisplaySize.height*.5)];
    
    return mainMenu;
    
}

-(void)moveToScene:(id)sender{
    CCMenuItemImage* menuItem = (CCMenuItemImage*)sender;
    CCMenuItem *itm = (CCMenuItem *)sender;
    NSString *theData = (NSString *)itm.userData;
    
    
    if ([theData isEqualToString:@"Friends"]) {
        [transitionManagerSingleton transitionTo:5];
    } else if ([theData isEqualToString:@"DeFense"])  {
        [transitionManagerSingleton transitionTo:3];
    } else if ([theData isEqualToString:@"Attack"])  {
        [transitionManagerSingleton transitionTo:6];
    } else if ([theData isEqualToString:@"TowersSet"])  {
        [transitionManagerSingleton transitionTo:8];
    }
    // NSLog(menuItem.label.string);
    
}


- (void)dealloc
{
    [super dealloc];
    
}

@end
