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
#import "ArmyNetwork.h"
#import "JSONModel.h"
#import "TestArmyNetwork.h"

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
        
        //Game status global variables
        gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
        
        CCLabelTTF *splash = [CCLabelTTF labelWithString:@"Assign Waves" fontName:@"Marker Felt" fontSize:32];
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        
        [splash setPosition:ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.95)];
        
        //Put the position of Back
        CCMenuItemFont *menuSave=[CCMenuItemFont itemWithString:@"save" target:self selector:@selector(saveRequest:)];
        CCMenuItemFont *menuTest=[CCMenuItemFont itemWithString:@"test" target:self selector:@selector(generateArmyFromNetworkResource)];
        CCMenuItemFont *manuItemBack=[CCMenuItemFont itemWithString:@"back" target:self selector:@selector(moveToScene:)];
        CCMenu *mainMenu=[CCMenu menuWithItems:menuSave,manuItemBack,menuTest, nil];
        
        [mainMenu alignItemsHorizontallyWithPadding:20];
        
        [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2 - 140)];
        
        
        WavesLayer *waveslayer = [[WavesLayer alloc] init];
        [waveslayer setPosition:ccp( mobileDisplaySize.width*.3, mobileDisplaySize.height*.6)];
        [self addChild: waveslayer z:3];
        
       // SoldiersLayer *soldierlayer = [[SoldiersLayer alloc] init];
       // [soldierlayer setPosition:ccp(mobileDisplaySize.width*.65, mobileDisplaySize.height*.6)];
       // [self addChild: soldierlayer z:4];
        
        [self addChild:splash z:1];
        [self addChild:mainMenu z:2];
        
        
        
   //     [self addChild:[self scrollLayer]];
    //    [self addChild:[self WavesMenu]];
     //   [self addChild:[self SoldierMenu]];
        
        
    }
    return self;
}



-(void)moveToScene:(id)sender{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    if ([menuItem.label.string isEqualToString:@"back"]) {
        [transitionManagerSingleton transitionTo:6];
    }
}
-(void)saveRequest:(id)sender{
    ArmyNetwork* army = gameStatusEssentialsSingleton.armynetwork;
    army.race=gameStatusEssentialsSingleton.raceType;
    NSString * jsonstring= [army toJSONString];
    CCLOG(jsonstring);
    
    
    
    //test save request
    ArmyNetworkRequest *armyNetwork = [[ArmyNetworkRequest alloc] init];
    
    
    
    for(id key in army.waveComplexStructure) {
        NSMutableDictionary* value = [army.waveComplexStructure objectForKey:key];
        WaveNetwork *waveNetwork = [[WaveNetwork alloc] init];
        
        for(id keyInner in value) {
            NSString* valueInner = [value objectForKey:keyInner];
            // CCLOG(valueInner);
            SoldierTypeNetwork *soldiersNetwork = [[SoldierTypeNetwork alloc] init];
            soldiersNetwork.quantity=valueInner;
            soldiersNetwork.soldiertype=keyInner;
            [waveNetwork.soldiersArray addObject:soldiersNetwork];
        }
        
        [armyNetwork.wavesArray addObject:waveNetwork];
    }
    armyNetwork.race=gameStatusEssentialsSingleton.raceType;
    NSString * jsonstringFixed= [armyNetwork toJSONString];

    CCLOG(jsonstringFixed);
    
}
-(Army*)generateArmyFromNetworkResource{
    NSString * test=[NSString stringWithString:@"{\"waveComplexStructure\":{\"w5\":{\"SC\":\"0\",\"SF\":\"0\",\"SB\":\"0\",\"SE\":\"0\",\"SA\":\"0\",\"SD\":\"0\"},\"w3\":{\"SC\":\"0\",\"SF\":\"0\",\"SB\":\"0\",\"SE\":\"0\",\"SA\":\"0\",\"SD\":\"0\"},\"w6\":{\"SC\":\"0\",\"SF\":\"0\",\"SB\":\"0\",\"SE\":\"0\",\"SA\":\"0\",\"SD\":\"0\"},\"w1\":{\"SC\":\"0\",\"SF\":\"0\",\"SB\":\"0\",\"SE\":\"0\",\"SA\":\"0\",\"SD\":\"0\"},\"w4\":{\"SC\":\"0\",\"SF\":\"0\",\"SB\":\"0\",\"SE\":\"0\",\"SA\":\"0\",\"SD\":\"0\"},\"w7\":{\"SC\":\"0\",\"SF\":\"0\",\"SB\":\"0\",\"SE\":\"0\",\"SA\":\"0\",\"SD\":\"0\"},\"w2\":{\"SC\":\"1\",\"SF\":\"1\",\"SB\":\"2\",\"SE\":\"2\",\"SA\":\"5\",\"SD\":\"0\"}},\"race\":\"Robot\"}"];
    ArmyNetwork* networkArmy=[[ArmyNetwork alloc] initWithString:test error:&erf];
    
    CCLOG(test);
    return nil;
}

- (void)dealloc
{
    [super dealloc];
    
}

@end
