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
    int wave_sol[8][3];
    int cur_wave;
}
@synthesize mobileDisplaySize;


+(CCScene *) scene
{
    
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
    WavesOfSoldiers *baselayer = [WavesOfSoldiers node];
    
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
        
        //initial SoldierLayer variable
        if(gameStatusEssentialsSingleton.getSoldierInit == false)
        {
            counterA=0;
            counterB=0;
            counterC=0;
            //CCLOG(@"Initialization %i",counterA);
            
            gameStatusEssentialsSingleton.soldierInit = true;
        }
        else{
            counterA = gameStatusEssentialsSingleton.GetCounterA;
            wave_sol[cur_wave][0] = counterA;
            counterB = gameStatusEssentialsSingleton.GetCounterB;
            wave_sol[cur_wave][1] = counterB;
            counterC = gameStatusEssentialsSingleton.GetCounterC;
            wave_sol[cur_wave][2] = counterC;
            
        }
        CCLOG(@"Initialization %i",wave_sol[cur_wave][0]);
        
        
        
        if([gameStatusEssentialsSingleton FirstVisit ]==true){
            dict = [[NSMutableDictionary alloc]init];
            [gameStatusEssentialsSingleton notFirstVisit];
            
        }
        
        [dict setObject:@"Wave 1" forKey:@"w1"];
        
        
        
        CCMenuItemFont *menuSave=[CCMenuItemFont itemWithString:@"save" target:self selector:@selector(saveRequest:)];
        
        CCMenuItemFont *manuItemBack=[CCMenuItemFont itemWithString:@"back" target:self selector:@selector(moveToScene:)];
        
        CCMenu *mainMenu=[CCMenu menuWithItems:menuSave,manuItemBack, nil];
        [mainMenu alignItemsHorizontallyWithPadding:20];
        
        [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2 - 140)];
        
        
        
        
        
        
        
        
        
        [self addChild:splash z:1];
        [self addChild:mainMenu z:2];
        [self addChild:[self LoadWaveMenu] z:3];
        [self addChild:[self loadWave]z:4];
        [self addChild:[self loadMutablesoldierMenuNumber]z:5];
        
        
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

/**used to be in WaveLayer Start*/

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
    [waveMenus setPosition:ccp( mobileDisplaySize.width/2 - 150, mobileDisplaySize.height/2)];
    
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
/**used to be in WaveLayer End*/

/**used to be in SoldierLayer Start*/
-(CCMenu*) loadWave{
    NSString *robot = @"Robot";
    NSString *human = @"Human";
    NSString *magic = @"Magic";
    CCMenuItemImage *soldierA;
    CCMenuItemImage *soldierB;
    CCMenuItemImage *soldierC;
    if([gameStatusEssentialsSingleton raceType] == human){
        soldierA=[CCMenuItemImage itemWithNormalImage:@"HumanSoldier_Basic.gif" selectedImage:@"HumanSoldier_basic.gif"];
        soldierB=[CCMenuItemImage itemWithNormalImage:@"HumanSoldier_Special.gif" selectedImage:@"HumanSoldier_Special.gif"];
        soldierC=[CCMenuItemImage itemWithNormalImage:@"HumanSoldier_Basic.gif" selectedImage:@"HumanSoldier_Basic.gif"];
    }
    if([gameStatusEssentialsSingleton raceType] == robot){
        soldierA=[CCMenuItemImage itemWithNormalImage:@"RobotSoldier_Basic.png" selectedImage:@"RobotSoldier_Basic.png"];
        soldierB=[CCMenuItemImage itemWithNormalImage:@"RobotSoldier_Special.png" selectedImage:@"RobotSoldier_Special.png"];
        soldierC=[CCMenuItemImage itemWithNormalImage:@"RobotSoldier_Basic.png" selectedImage:@"RobotSoldier_Basic.png"];
    }
    if([gameStatusEssentialsSingleton raceType] == magic){
        soldierA=[CCMenuItemImage itemWithNormalImage:@"MageSoldier_Basic.png" selectedImage:@"MageSoldier_Basic.png"];
        soldierB=[CCMenuItemImage itemWithNormalImage:@"MageSoldier_Special.png" selectedImage:@"MageSoldier_Special.png"];
        soldierC=[CCMenuItemImage itemWithNormalImage:@"MageSoldier_Basic.png" selectedImage:@"MageSoldier_Basic.png"];
    }
    
    //[soldierA setFontSize:20];
    //[soldierB setFontSize:20];
    //[soldierC setFontSize:20];
    
    CCMenu *SoldierMenu = [CCMenu menuWithItems:soldierA, soldierB, soldierC, nil];
    [SoldierMenu  alignItemsVertically];
    [SoldierMenu setPosition:ccp(mobileDisplaySize.width/2, mobileDisplaySize.height/2)];
    
    return SoldierMenu;
}


-(CCMenu*) loadMutablesoldierMenuNumber{
    item1=[CCMenuItemFont itemWithString:[NSString stringWithFormat:@"%i", counterA]];
    [item1 setFontSize:20];
    item2=[CCMenuItemFont itemWithString:[NSString stringWithFormat:@"%i", counterB]];
    [item2 setFontSize:20];
    item3=[CCMenuItemFont itemWithString:[NSString stringWithFormat:@"%i", counterC]];
    [item3 setFontSize:20];
    
    //add
    //For increasing
    item4=[CCMenuItemFont itemWithString:@"+" target:self selector:@selector(setSoldierNumber:)];
    [item4 setFontSize:20];
    
    item5=[CCMenuItemFont itemWithString:@"+" target:self selector:@selector(setSoldierNumber:)];
    [item5 setFontSize:20];
    
    item6=[CCMenuItemFont itemWithString:@"+" target:self selector:@selector(setSoldierNumber:)];
    [item6 setFontSize:20];
    
    //For decreasing
    item7=[CCMenuItemFont itemWithString:@"-" target:self selector:@selector(setSoldierNumber:)];
    [item7 setFontSize:20];
    
    item8=[CCMenuItemFont itemWithString:@"-" target:self selector:@selector(setSoldierNumber:)];
    [item8 setFontSize:20];
    
    item9=[CCMenuItemFont itemWithString:@"-" target:self selector:@selector(setSoldierNumber:)];
    [item9 setFontSize:20];
    
    soldierMenus = [CCMenu menuWithItems:item4,item1,item7,item5, item2,item8,item6, item3,item9, nil];
    
    //   [soldierMenus alignItemsInColumns:[NSNumber numberWithInt:3],[NSNumber numberWithInt:3],[NSNumber numberWithInt:3],nil];
    [soldierMenus alignItemsInColumnsPadding:0 columns:[NSNumber numberWithInt:3],[NSNumber numberWithInt:3],[NSNumber numberWithInt:3], nil];
    //[soldierMenus  alignItemsVertically];
    [soldierMenus setPosition:ccp(mobileDisplaySize.width + 50, mobileDisplaySize.height/2)];
    
    return soldierMenus;
    
}

-(void) setSoldierNumber:(id) soldierType{
    CCMenuItemFont *menuItem = (CCMenuItemFont*)soldierType;
    
    //add....
    if (menuItem == item4) {
        wave_sol[cur_wave][0]++;
        counterA++;
    }
    if (menuItem == item7) {
        if(counterA >0)
        {
            wave_sol[cur_wave][0]--;
            counterA--;
            
        }
    }
    [item1 setString:[NSString stringWithFormat:@"%d", counterA]];
    NSString* wave= [gameStatusEssentialsSingleton currentWave];
    NSMutableDictionary * tempdictonary=[[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] objectForKey:wave];
    CCLOG(@"mente %@",[tempdictonary objectForKey:@"SA"]);
    [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterA] forKey:@"SA"];
    CCLOG(@"%@",[tempdictonary objectForKey:@"SA"]);
    [[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] setObject:tempdictonary forKey:wave];
    if([menuItem.label.string isEqualToString:@"Soldier B"]){
        wave_sol[cur_wave][1]++;
        counterB++;
        [item2 setString:[NSString stringWithFormat:@"%d", counterB]];
        NSString* wave= [gameStatusEssentialsSingleton currentWave];
        NSMutableDictionary * tempdictonary=[[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] objectForKey:wave];
        CCLOG(@"mente %@",[tempdictonary objectForKey:@"SB"]);
        [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterB] forKey:@"SB"];
        CCLOG(@"%@",[tempdictonary objectForKey:@"SB"]);
        [[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] setObject:tempdictonary forKey:wave];
    }else if([menuItem.label.string isEqualToString:@"Soldier C"]){
        counterC++;
        [item3 setString:[NSString stringWithFormat:@"%d", counterC]];
        NSString* wave= [gameStatusEssentialsSingleton currentWave];
        NSMutableDictionary * tempdictonary=[[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] objectForKey:wave];
        CCLOG(@"mente %@",[tempdictonary objectForKey:@"SC"]);
        [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterC] forKey:@"SC"];
        CCLOG(@"%@",[tempdictonary objectForKey:@"SC"]);
        [[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] setObject:tempdictonary forKey:wave];
    }else if([menuItem.label.string isEqualToString:@"Soldier D"]){
        counterD++;
        [item4 setString:[NSString stringWithFormat:@"%d", counterD]];
        NSString* wave= [gameStatusEssentialsSingleton currentWave];
        NSMutableDictionary * tempdictonary=[[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] objectForKey:wave];
        CCLOG(@"mente %@",[tempdictonary objectForKey:@"SD"]);
        [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterD] forKey:@"SD"];
        CCLOG(@"%@",[tempdictonary objectForKey:@"SD"]);
        [[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] setObject:tempdictonary forKey:wave];
    }else if([menuItem.label.string isEqualToString:@"Soldier E"]){
        counterE++;
        [item5 setString:[NSString stringWithFormat:@"%d", counterE]];
        NSString* wave= [gameStatusEssentialsSingleton currentWave];
        NSMutableDictionary * tempdictonary=[[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] objectForKey:wave];
        CCLOG(@"mente %@",[tempdictonary objectForKey:@"SE"]);
        [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterE] forKey:@"SE"];
        CCLOG(@"%@",[tempdictonary objectForKey:@"SE"]);
        [[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] setObject:tempdictonary forKey:wave];
    }else if([menuItem.label.string isEqualToString:@"Soldier F"]){
        counterF++;
        [item6 setString:[NSString stringWithFormat:@"%d", counterF]];
        NSString* wave= [gameStatusEssentialsSingleton currentWave];
        NSMutableDictionary * tempdictonary=[[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] objectForKey:wave];
        CCLOG(@"mente %@",[tempdictonary objectForKey:@"SF"]);
        [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterF] forKey:@"SF"];
        CCLOG(@"%@",[tempdictonary objectForKey:@"SF"]);
        [[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] setObject:tempdictonary forKey:wave];
    }
    //add
    gameStatusEssentialsSingleton.counterA = counterA;
    gameStatusEssentialsSingleton.counterB = counterB;
    gameStatusEssentialsSingleton.counterC = counterC;
}

- (void) AddWave: (int) waveID
{
    cur_wave = waveID;
    counterA = wave_sol[cur_wave][0];
    counterB = wave_sol[cur_wave][1];
    [item1 setString:[NSString stringWithFormat:@"%d", wave_sol[cur_wave][0]]];
    [item2 setString:[NSString stringWithFormat:@"%d", wave_sol[cur_wave][1]]];
}
/**used to be in SoldierLayer End*/
- (void)dealloc
{
    [super dealloc];
    
}

@end
