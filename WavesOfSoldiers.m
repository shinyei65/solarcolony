//
//  WavesOfSoldiers.m
//  SolarColony
//
//  Created by Po-Yi Lee on 3/3/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "WavesOfSoldiers.h"
#import "CCScrollLayer.h"
#import "WavesLayer.h"
#import "SoldiersLayer.h"
#import "cocos2d.h"

@implementation WavesOfSoldiers
@synthesize mobileDisplaySize;

+(CCScene *) scene
{
    
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
    WavesOfSoldiers *baselayer = [WavesOfSoldiers node];
    
    //	WavesOfSoldiers *wavelayer = [WavesOfSoldiers node];
    //	WavesOfSoldiers *soldierlayer = [WavesOfSoldiers node];
    
	// add layer as a child to scene
	
    [scene addChild: baselayer z:0];
    
    
	// return the scene
	return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        //Put the position of Assign Waves
        transitionManagerSingleton=[TransitionManagerSingleton sharedInstance];
        
        CCLabelTTF *splash = [CCLabelTTF labelWithString:@"Assign Waves" fontName:@"Marker Felt" fontSize:32];
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        
        [splash setPosition:ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.95)];
        
        //Put the position of Back
        CCMenuItemFont *manuItemBack=[CCMenuItemFont itemWithString:@"back" target:self selector:@selector(moveToScene:)];
        
        CCMenu *mainMenu=[CCMenu menuWithItems:manuItemBack, nil];
        
        [mainMenu alignItemsHorizontallyWithPadding:20];
        
        [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2 - 140)];
        
        
        WavesLayer *waveslayer = [WavesLayer node];
        [waveslayer setPosition:ccp( mobileDisplaySize.width/3, mobileDisplaySize.height-45)];
        [self addChild: waveslayer z:3];
        
        SoldiersLayer *soldierlayer = [SoldiersLayer node];
        [soldierlayer setPosition:ccp(mobileDisplaySize.width*.75, mobileDisplaySize.height*.4)];
        [self addChild: soldierlayer z:4];
        
        [self addChild:splash z:1];
        [self addChild:mainMenu z:2];
        
        
        
   //     [self addChild:[self scrollLayer]];
    //    [self addChild:[self WavesMenu]];
     //   [self addChild:[self SoldierMenu]];
        
        
    }
    return self;
}


/*
-(CCMenu*) WavesMenu{
    CCMenuItemFont *wave1=[CCMenuItemFont itemWithString:@"Wave 1" target:self selector:nil];
//    CCMenuItemFont *wave2=[CCMenuItemFont itemWithString:@"Wave 2" target:self selector:nil];
//    CCMenuItemFont *wave3=[CCMenuItemFont itemWithString:@"Wave 3" target:self selector:nil];
    item1=[CCMenuItemFont itemWithString:@" " target:self selector:nil];
    item2=[CCMenuItemFont itemWithString:@" " target:self selector:nil];
    item3=[CCMenuItemFont itemWithString:@" " target:self selector:nil];
    item4=[CCMenuItemFont itemWithString:@" " target:self selector:nil];
    item5=[CCMenuItemFont itemWithString:@" " target:self selector:nil];
    item6=[CCMenuItemFont itemWithString:@" " target:self selector:nil];
//    item7=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(setTowerofTypes:)];
//    item8=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(setTowerofTypes:)];
//    item9=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(setTowerofTypes:)];
    [wave1 setFontSize:20];
    [item1 setFontSize:15];
    [item2 setFontSize:15];
    [item3 setFontSize:15];
    [item4 setFontSize:15];
    [item5 setFontSize:15];
    [item6 setFontSize:15];
    CCMenu *WaveMenus;
    
    WaveMenus = [CCMenu menuWithItems: wave1,item1, item2, item3, item4, item5, item6, nil];
    //[WaveMenus  alignItemsInGridWithPadding:ccp(25, 25) columns:3];
   
    [WaveMenus alignItemsInColumns:[NSNumber numberWithInt:1], [NSNumber numberWithInt:3], [NSNumber numberWithInt:3], nil];
    
    [WaveMenus setPosition:ccp( mobileDisplaySize.width/3, mobileDisplaySize.height-65)];
    
    return WaveMenus;
   
    
}

-(CCMenu*) SoldierMenu{
    CCMenuItemFont *soldierA=[CCMenuItemFont itemWithString:@"Soldier A" target:self selector:@selector(setSoldierinWave:)];
    CCMenuItemFont *soldierB=[CCMenuItemFont itemWithString:@"Soldier B" target:self selector:@selector(setSoldierinWave:)];
    CCMenuItemFont *soldierC=[CCMenuItemFont itemWithString:@"Soldier C" target:self selector:@selector(setSoldierinWave:)];
    CCMenuItemFont *soldierD=[CCMenuItemFont itemWithString:@"Soldier D" target:self selector:@selector(setSoldierinWave:)];
    CCMenuItemFont *soldierE=[CCMenuItemFont itemWithString:@"Soldier E" target:self selector:@selector(setSoldierinWave:)];
    CCMenuItemFont *soldierF=[CCMenuItemFont itemWithString:@"Soldier F" target:self selector:@selector(setSoldierinWave:)];
    [soldierA setFontSize:20];
    [soldierB setFontSize:20];
    [soldierC setFontSize:20];
    [soldierD setFontSize:20];
    [soldierE setFontSize:20];
    [soldierF setFontSize:20];
    CCMenu *SoldierMenu = [CCMenu menuWithItems:soldierA, soldierB, soldierC,soldierD, soldierE, soldierF, nil];
   [SoldierMenu  alignItemsInGridWithPadding:ccp(0, 0) columns:1];
    [SoldierMenu setPosition:ccp(mobileDisplaySize.width*.75, mobileDisplaySize.height*.4)];
    
    return SoldierMenu;
}

-(void) setSoldierinWave:(id) soldierType{
    CCMenuItemFont *menuItem = (CCMenuItemFont*)soldierType;
    
    if ([menuItem.label.string isEqualToString:@"Soldier A"]) {
        [item1 setString:@"SoldierA"];
    }else if([menuItem.label.string isEqualToString:@"Soldier B"]){
        [item2 setString:@"SoldierB"];
    }else if([menuItem.label.string isEqualToString:@"Soldier C"]){
        [item3 setString:@"SoldierC"];
    }else if([menuItem.label.string isEqualToString:@"Soldier D"]){
        [item4 setString:@"SoldierD"];
    }else if([menuItem.label.string isEqualToString:@"Soldier E"]){
        [item5 setString:@"SoldierE"];
    }else if([menuItem.label.string isEqualToString:@"Soldier F"]){
        [item6 setString:@"SoldierF"];
    }

}
*/

-(void)moveToScene:(id)sender{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    if ([menuItem.label.string isEqualToString:@"back"]) {
        [transitionManagerSingleton transitionTo:1];
    }
}

- (void)dealloc
{
    [super dealloc];
    
}

@end
