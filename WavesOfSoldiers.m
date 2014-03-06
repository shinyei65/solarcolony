//
//  WavesOfSoldiers.m
//  SolarColony
//
//  Created by Po-Yi Lee on 3/3/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "WavesOfSoldiers.h"
#import "CCScrollLayer.h"


@implementation WavesOfSoldiers
@synthesize mobileDisplaySize;

+(CCScene *) scene
{

	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
    WavesOfSoldiers *layer = [WavesOfSoldiers node];
	WavesOfSoldiers *wavelayer = [WavesOfSoldiers node];
	WavesOfSoldiers *soldierlayer = [WavesOfSoldiers node];
    
	// add layer as a child to scene
	
    [layer addChild: wavelayer];
    [layer addChild: soldierlayer];
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        transitionManagerSingleton=[TransitionManagerSingleton sharedInstance];
        
        CCLabelTTF *splash = [CCLabelTTF labelWithString:@"Assign Waves" fontName:@"Marker Felt" fontSize:32];
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        
        [splash setPosition:ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.95)];
        
        [self addChild:splash];
   //     [self addChild:[self scrollLayer]];
        [self addChild:[self loadMenu]];
        [self addChild:[self WavesMenu]];
        [self addChild:[self SoldierMenu]];
        
        
    }
    return self;
}

- (CCMenu*)loadMenu
{
    CCMenuItemFont *manuItemBack=[CCMenuItemFont itemWithString:@"back" target:self selector:@selector(moveToScene:)];
    
    CCMenu *mainMenu=[CCMenu menuWithItems:manuItemBack, nil];
    
    [mainMenu alignItemsHorizontallyWithPadding:20];
    
    [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2 - 140)];
    
    return mainMenu;
    
}

-(CCMenu*) WavesMenu{
    CCMenuItemFont *wave1=[CCMenuItemFont itemWithString:@"Wave 1" target:self selector:nil];
//    CCMenuItemFont *wave2=[CCMenuItemFont itemWithString:@"Wave 2" target:self selector:nil];
//    CCMenuItemFont *wave3=[CCMenuItemFont itemWithString:@"Wave 3" target:self selector:nil];
    item1=[CCMenuItemFont itemWithString:@"A " target:self selector:@selector(setSoldierinWave:)];
    item2=[CCMenuItemFont itemWithString:@"B " target:self selector:@selector(setSoldierinWave:)];
    item3=[CCMenuItemFont itemWithString:@"C " target:self selector:@selector(setSoldierinWave:)];
//    item4=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(setTowerofTypes:)];
//    item5=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(setTowerofTypes:)];
//    item6=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(setTowerofTypes:)];
//    item7=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(setTowerofTypes:)];
//    item8=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(setTowerofTypes:)];
//    item9=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(setTowerofTypes:)];
    CCMenu *WaveMenus;
  
    WaveMenus = [CCMenu menuWithItems: wave1,item1, item2, item3, nil];
    //[WaveMenus  alignItemsInGridWithPadding:ccp(25, 25) columns:3];
   
    [WaveMenus alignItemsInColumns:[NSNumber numberWithInt:1],[NSNumber numberWithInt:3], nil];
    [WaveMenus setPosition:ccp( mobileDisplaySize.width*.25, mobileDisplaySize.height/2+40)];
    
    return WaveMenus;
   
    
}

-(CCMenu*) SoldierMenu{
    CCMenuItemFont *soldierA=[CCMenuItemFont itemWithString:@"Soldier A" target:self selector:nil];
    CCMenuItemFont *soldierB=[CCMenuItemFont itemWithString:@"Soldier B" target:self selector:nil];
    CCMenuItemFont *soldierC=[CCMenuItemFont itemWithString:@"Soldier C" target:self selector:nil];
    CCMenuItemFont *soldierD=[CCMenuItemFont itemWithString:@"Soldier D" target:self selector:nil];
    CCMenuItemFont *soldierE=[CCMenuItemFont itemWithString:@"Soldier E" target:self selector:nil];
    CCMenuItemFont *soldierF=[CCMenuItemFont itemWithString:@"Soldier F" target:self selector:nil];
    [soldierA setFontSize:20];
    [soldierB setFontSize:20];
    [soldierC setFontSize:20];
    [soldierD setFontSize:20];
    [soldierE setFontSize:20];
    [soldierF setFontSize:20];
    CCMenu *SoldierMenu = [CCMenu menuWithItems:soldierA, soldierB, soldierC,soldierD, soldierE, soldierF, nil];
    [SoldierMenu  alignItemsInGridWithPadding:ccp(25, 25) columns:2];
    [SoldierMenu setPosition:ccp(mobileDisplaySize.width*.55, mobileDisplaySize.height*.4)];
    
    return SoldierMenu;
}

-(void) setSoldierinWave:(id) soldierType{
    CCMenuItemFont *menuItem = (CCMenuItemFont*)soldierType;
    
    if ([menuItem.label.string isEqualToString:@"SoldierA"]) {
        [item1 setString:@"SoldierA"];
    }else if([menuItem.label.string isEqualToString:@"SoldierB"]){
        [item2 setString:@"SoldierB"];
    }else if([menuItem.label.string isEqualToString:@"SoldierC"]){
        [item3 setString:@"SoldierC"];
    }

}


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
