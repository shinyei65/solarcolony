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

static NSMutableDictionary *dict;

@implementation WavesOfSoldiers{
    SoldiersLayer *soldierlayer;
    int wave_num;
    NSArray *ItemArray;
    
}
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
        
        wave_num = 1;
        
        
       
       
        if([gameStatusEssentialsSingleton FirstVisit ]==true){
            dict = [[NSMutableDictionary alloc]init];
            [gameStatusEssentialsSingleton notFirstVisit];

        }
        
        [dict setObject:@"Wave 1" forKey:@"w1"];
        
        
        //Put the position of Back
        CCMenuItemFont *menuSave=[CCMenuItemFont itemWithString:@"save" target:self selector:@selector(saveRequest:)];

        CCMenuItemFont *manuItemBack=[CCMenuItemFont itemWithString:@"back" target:self selector:@selector(moveToScene:)];

        CCMenu *mainMenu=[CCMenu menuWithItems:menuSave,manuItemBack, nil];
        [mainMenu alignItemsHorizontallyWithPadding:20];
        
        [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2 - 140)];
        
       
        
        //WavesLayer *waveslayer = [[WavesLayer alloc] init];
        //[waveslayer setPosition:ccp( mobileDisplaySize.width*.3, mobileDisplaySize.height*.6)];
       // [self addChild: waveslayer z:3];
        
        [self addChild:[self LoadWaveMenu] z:3];
        
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
   // CCLOG(jsonstring);
   
    
    
    
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

-(NSMutableDictionary*) SaveWave:(NSString*)WaveName :(NSString*)WaveKey
{
    [Wave_Store setObject:WaveName forKey:WaveKey];
    return Wave_Store;
}

-(CCMenu*)LoadWaveMenu{
    //Plus button
    CCMenuItem *addItemButton = [CCMenuItemImage itemWithNormalImage:@"AddButton.png" selectedImage:@"AddButton_select.png" target:self selector:@selector(AddNewItem)];
    [addItemButton setPosition:ccp(-50,50)];
    
    
    wave1=[CCMenuItemFont itemWithString:@"Wave 1" target:self selector:@selector(setSoldierinWave:)];
    wave1.tag = 1;
    [wave1 setFontSize:20];
    
    [gameStatusEssentialsSingleton setCurrentWave:@"w1"];
    
    
    
        NSArray *keys = [dict allKeys];
    NSLog(@"dict %@",dict);
        NSLog(@"%@",keys);
        // values in foreach loop
        for (NSString *key in keys) {
            ItemArray = [NSMutableArray arrayWithObject:[dict objectForKey:key]];
            
        }
        NSLog(@"Item %@",ItemArray);
    
    
    waveMenus= [CCMenu menuWithItems:addItemButton,wave1, nil];
    
    
    [waveMenus alignItemsVertically];
    [waveMenus setPosition:ccp( mobileDisplaySize.width/2 - 100, mobileDisplaySize.height/2)];
    
    return waveMenus;
    
}


-(void) setSoldierinWave:(id) soldierType{
    CCMenuItemFont *menuItem = (CCMenuItemFont*)soldierType;
    NSString *currwave;
    switch (menuItem.tag) {
        case 1:
            [gameStatusEssentialsSingleton setCurrentWave:@"w1"];
            
            
            currwave = [gameStatusEssentialsSingleton currentWave];
            CCLOG(currwave);
            break;
        case 2:
            [gameStatusEssentialsSingleton setCurrentWave:@"w2"];
            
            currwave = [gameStatusEssentialsSingleton currentWave];
            // CCLOG(currwave);
            break;
        case 3:
            [gameStatusEssentialsSingleton setCurrentWave:@"w3"];
            
            currwave = [gameStatusEssentialsSingleton currentWave];
            CCLOG(currwave);
            break;
        case 4:
            [gameStatusEssentialsSingleton setCurrentWave:@"w4"];
            currwave = [gameStatusEssentialsSingleton currentWave];
            CCLOG(currwave);
            break;
        case 5:
            [gameStatusEssentialsSingleton setCurrentWave:@"w5"];
            
            currwave = [gameStatusEssentialsSingleton currentWave];
            CCLOG(currwave);
            break;
        case 6:
            [gameStatusEssentialsSingleton setCurrentWave:@"w6"];
            
            currwave = [gameStatusEssentialsSingleton currentWave];
            CCLOG(currwave);
            break;
        case 7:
            [gameStatusEssentialsSingleton setCurrentWave:@"w7"];
            
            currwave = [gameStatusEssentialsSingleton currentWave];
            CCLOG(currwave);
            break;
        case 8:
            [gameStatusEssentialsSingleton setCurrentWave:@"w8"];
            
            currwave = [gameStatusEssentialsSingleton currentWave];
            CCLOG(currwave);
            break;
        default:
            break;
    }
    
}

-(void)AddNewItem{
     CCLOG(@"add new item");
    
    wave_num = wave_num + 1;
    NSString *Wave_num =[NSString stringWithFormat:@"Wave %i",wave_num];
    NSString *wave_key = [NSString stringWithFormat:@"w%i",wave_num];
    
    CCMenuItemFont* WaveNum = [CCMenuItemFont itemWithString: Wave_num target:self selector:@selector(setSoldierinWave:)];
    WaveNum.tag = wave_num;
    [WaveNum setFontSize:20];
    [WaveNum setZOrder:2];
    [waveMenus addChild:WaveNum];
    [waveMenus alignItemsVertically];
    
    [dict setObject:Wave_num  forKey:wave_key];
    
}

-(CCLayer*)loadSoldierLayer
{
    return soldierlayer;
}

- (void)dealloc
{
    [super dealloc];
    
}

@end
