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
#import "GameStatsLoader.h"

static NSMutableDictionary *SoldiersSave;
static NSMutableArray* WavesSave;

@implementation WavesOfSoldiers{
    SoldiersLayer *soldierlayer;
    CCLabelTTF *resource_number;
    NSMutableArray* Waves;
    
    int wave_num;
    NSArray *ItemArray;
    int wave_sol[8][6];
    int cur_wave;
    PlayerInfo *player;
    NSString *race;
    GameStatsLoader *loader;
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
        race = [gameStatusEssentialsSingleton raceType];
        
        //initial SoldierLayer variable
        if(gameStatusEssentialsSingleton.getFirstVisit == true)
        {
            SoldiersSave = [[NSMutableDictionary alloc]init];
            Waves = gameStatusEssentialsSingleton.WaveSettings;
            wave_num = 0;
            [Waves addObject:[self CreateWaveSetting]];
            counterA=0;
            counterB=0;
            counterC=0;
            gameStatusEssentialsSingleton.FirstVisit = false;
        }
        else{
            counterA = gameStatusEssentialsSingleton.GetCounterA;
            wave_sol[cur_wave][0] = counterA;
            counterB = gameStatusEssentialsSingleton.GetCounterB;
            wave_sol[cur_wave][1] = counterB;
            Waves = gameStatusEssentialsSingleton.WaveSettings;
            wave_num = [gameStatusEssentialsSingleton.WaveSettings count];
        }
        
        
        
        //UI part
        CCLabelTTF *splash = [CCLabelTTF labelWithString:@"Assign Waves" fontName:@"Marker Felt" fontSize:32];
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        
        [splash setPosition:ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.95)];
        //initial background
        CCSprite *bg = [CCSprite spriteWithFile:@"Earth_Day.jpg"];
        bg.position = ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5);
        
        CCMenuItemFont *menuSave=[CCMenuItemFont itemWithString:@"save" target:self selector:@selector(saveWaveSetting:)];
        
        CCMenuItemFont *manuItemBack=[CCMenuItemFont itemWithString:@"back" target:self selector:@selector(moveToScene:)];
        
        CCMenu *mainMenu=[CCMenu menuWithItems:menuSave,manuItemBack, nil];
        [mainMenu alignItemsHorizontallyWithPadding:20];
        
        [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2 - 140)];
        
        [self addChild:bg z:0];
        
        [self addChild:splash z:1];
        [self addChild:mainMenu z:2];
        [self addChild:[self LoadWaveMenu] z:3];
        [self addChild:[self loadTable] z:3];
        [self addChild:[self loadButton] z:3];
        cur_wave = 0;
        [self setcolor];
        [self loadWaveSetting:cur_wave];
        
        // game stats loader
        loader = [GameStatsLoader loader];
        
        // add resource bar
        NSString *bar_img = nil;
        if([[gameStatusEssentialsSingleton raceType] isEqualToString:@"Human"]){
            bar_img = @"human_resource.gif";
        }else if([[gameStatusEssentialsSingleton raceType] isEqualToString:@"Human"]){
            bar_img = @"robot_resource.gif";
        }else{
            bar_img = @"magic_resource.gif";
        }
        CCSprite *resource_bar = [CCSprite spriteWithFile:bar_img];
        [resource_bar setPosition:ccp(120, 300)];
        resource_bar.opacity = 200;
        [self addChild:resource_bar];
        player = [PlayerInfo Player];
        resource_number = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", [player getResource]] fontName:@"Outlier.ttf" fontSize:15];
        resource_number.position = ccp(100,300);
        [self addChild:resource_number];
    }
    return self;
}

- (WaveSetting*) CreateWaveSetting
{
    WaveSetting* createwave = [[WaveSetting alloc]initWave:wave_num];
    NSMutableArray* list = [createwave getList];
    SoldierSetting* S1 = [[SoldierSetting alloc]initSoldier:@"Runner"];
    SoldierSetting* S2 = [[SoldierSetting alloc]initSoldier:@"Attacker1"];
    [list addObject:S1];
    [list addObject:S2];
    wave_num++;
    return createwave;
}

-(void)loadWaveSetting:(int)idx{
    NSMutableArray* list = [[Waves objectAtIndex:idx] getList];
    for(SoldierSetting* setting in list){
        if ([[setting getType] isEqualToString:@"Runner"]) {
            counterA = [setting getCount];
            [item1 setString:[NSString stringWithFormat:@"%d", counterA]];
        }
        else if([[setting getType] isEqualToString:@"Attacker1"]){
            counterB = [setting getCount];
            [item2 setString:[NSString stringWithFormat:@"%d", counterB]];
        }
    }
}
-(SoldierSetting*)getSoldierSetting:(NSString*)Type {
    NSMutableArray* list = [[Waves objectAtIndex:cur_wave] getList];
    for(SoldierSetting* setting in list){
        if ([[setting getType] isEqualToString:Type]) {
            return setting;
        }
    }
    return nil;
}

-(void)moveToScene:(id)sender{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    gameStatusEssentialsSingleton.WaveSettings = Waves;
    
    if ([menuItem.label.string isEqualToString:@"back"]) {
        [transitionManagerSingleton transitionTo:6];
        
    }
}

/**set up initial menu of waves*/

-(CCMenu*)LoadWaveMenu{
    //Plus button
    CCMenuItem *addItemButton = [CCMenuItemImage itemWithNormalImage:@"AddButton.png" selectedImage:@"AddButton_select.png" target:self selector:@selector(AddNewItem)];
    addItemButton.tag = -1;
    [addItemButton setPosition:ccp(-50,50)];
    
    /*wave1=[CCMenuItemFont itemWithString:@"Wave 1" target:self selector:@selector(setSoldierinWave:)];
    wave1.tag = 0;
    [wave1 setFontSize:20];
    [gameStatusEssentialsSingleton setCurrentWave:@"w1"];
    WaveSetting *W1 = [WaveSetting setting:wave_num];
    [Waves addObject:W1];*/
    NSMutableArray* arr = [NSMutableArray array];
    [arr addObject:addItemButton];
    for (int i = 0; i < [Waves count]; i++) {
        wave1=[CCMenuItemFont itemWithString:[NSString stringWithFormat:@"Wave %d",i] target:self selector:@selector(setSoldierinWave:)];
        wave1.tag = i;
        [wave1 setFontSize:20];
        [arr addObject:wave1];
    }
 
    //waveMenus= [CCMenu menuWithItems:addItemButton,wave1, nil];
    waveMenus= [CCMenu menuWithArray:[NSArray arrayWithArray:arr]];
    [waveMenus alignItemsVertically];
    [waveMenus setPosition:ccp( mobileDisplaySize.width/2 - 150, mobileDisplaySize.height/2)];

    return waveMenus;
}

-(void) setcolor
{
    for (CCMenuItemFont* item in waveMenus.children){
        if (item.tag == cur_wave) {
            [item setColor:ccc3(255, 255, 0)];
        }
        else if(item.tag >= 0)
        {
            [item setColor:ccc3(255, 255, 255)];
        }
    }
}

/**to check which wave is been selected and show different soldiers*/
-(void) setSoldierinWave:(id) soldierType{
    CCMenuItemFont *menuItem = (CCMenuItemFont*)soldierType;
    [menuItem setColor:ccc3(0, 255, 255)];
    cur_wave = menuItem.tag;
    [self setcolor];
    [self loadWaveSetting:cur_wave];
}

/**After clicking adding button, add new wave to menu list*/
-(void)AddNewItem{

    NSString *Wave_num =[NSString stringWithFormat:@"Wave %i",wave_num];
   // NSString *wave_key = [NSString stringWithFormat:@"w%i",wave_num];
    
    CCMenuItemFont* WaveNum = [CCMenuItemFont itemWithString: Wave_num target:self selector:@selector(setSoldierinWave:)];
    WaveNum.tag = wave_num;
    [WaveNum setFontSize:20];
    [WaveNum setZOrder:2];
    [waveMenus addChild:WaveNum];
    [waveMenus alignItemsVertically];
    
    [Waves addObject:[self CreateWaveSetting]];
}

/**show the table of soldier selection*/
-(CCMenu*) loadTable{
    NSString *robot = @"Robot";
    NSString *human = @"Human";
    NSString *magic = @"Magic";
    CCMenuItemImage *soldierA;
    CCMenuItemImage *soldierB;
    CCMenuItemImage *soldierC;
    CCMenuItemImage *TableSoldierA = [CCMenuItemImage itemWithNormalImage:@"Table_Soldier.png" selectedImage:@"Table_Soldier.png"];
    CCMenuItemImage *TableSoldierB = [CCMenuItemImage itemWithNormalImage:@"Table_Soldier.png" selectedImage:@"Table_Soldier.png"];
    CCMenuItemImage *TableSoldierC = [CCMenuItemImage itemWithNormalImage:@"Table_Soldier.png" selectedImage:@"Table_Soldier.png"];
    CCMenuItemImage *TableSoldierD = [CCMenuItemImage itemWithNormalImage:@"Table_Soldier.png" selectedImage:@"Table_Soldier.png"];
    CCMenuItemImage *TableSoldierE = [CCMenuItemImage itemWithNormalImage:@"Table_Soldier.png" selectedImage:@"Table_Soldier.png"];
    CCMenuItemImage *TableSoldierF = [CCMenuItemImage itemWithNormalImage:@"Table_Soldier.png" selectedImage:@"Table_Soldier.png"];
    
    CCMenuItemImage *soldierA_number=[CCMenuItemImage itemWithNormalImage:@"soldier_table_number.png" selectedImage:@"soldier_table_number.png"];
    CCMenuItemImage *soldierB_number=[CCMenuItemImage itemWithNormalImage:@"soldier_table_number.png" selectedImage:@"soldier_table_number.png"];
    CCMenuItemImage *soldierC_number=[CCMenuItemImage itemWithNormalImage:@"soldier_table_number.png" selectedImage:@"soldier_table_number.png"];
    CCMenuItemImage *soldierD_number=[CCMenuItemImage itemWithNormalImage:@"soldier_table_number.png" selectedImage:@"soldier_table_number.png"];
    CCMenuItemImage *soldierE_number=[CCMenuItemImage itemWithNormalImage:@"soldier_table_number.png" selectedImage:@"soldier_table_number.png"];
    CCMenuItemImage *soldierF_number=[CCMenuItemImage itemWithNormalImage:@"soldier_table_number.png" selectedImage:@"soldier_table_number.png"];
    
    //hard coded ccp don't change
    
    TableSoldierA.position = ccp(20,50);//with 150*150
    TableSoldierB.position = ccp(90,50);
    TableSoldierC.position = ccp(160,50);
    TableSoldierD.position = ccp(20,-45);
    TableSoldierE.position = ccp(90,-45);
    TableSoldierF.position = ccp(160,-45);
    soldierA_number.position = ccp(20,3);
    soldierB_number.position = ccp(90,3);
    soldierC_number.position = ccp(160,3);
    soldierD_number.position = ccp(20,-92);
    soldierE_number.position = ccp(90,-92);
    soldierF_number.position = ccp(160,-92);
    
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
    soldierA.position = ccp(20, 50);
    soldierB.position = ccp(90, 50);
    soldierC.position = ccp(160,50);
    
    
    CCMenu *SoldierMenu = [CCMenu menuWithItems:nil];
    [SoldierMenu addChild:TableSoldierA z:0];
    [SoldierMenu addChild:TableSoldierB z:0];
    [SoldierMenu addChild:TableSoldierC z:0];
    [SoldierMenu addChild:TableSoldierD z:0];
    [SoldierMenu addChild:TableSoldierE z:0];
    [SoldierMenu addChild:TableSoldierF z:0];
    [SoldierMenu addChild:soldierA_number z:0];
    [SoldierMenu addChild:soldierB_number z:0];
    [SoldierMenu addChild:soldierC_number z:0];
    [SoldierMenu addChild:soldierD_number z:0];
    [SoldierMenu addChild:soldierE_number z:0];
    [SoldierMenu addChild:soldierF_number z:0];
    [SoldierMenu addChild:soldierA z:1];
    [SoldierMenu addChild:soldierB z:1];
    //[SoldierMenu addChild:soldierC z:1];
    
    [SoldierMenu setPosition:ccp(mobileDisplaySize.width/2, mobileDisplaySize.height/2)];
    return SoldierMenu;
}

/**increase and decrease button*/
-(CCMenu*) loadButton{
    
    soldierA_decrease=[CCMenuItemImage itemWithNormalImage:@"soldier_decrease_unselect.png" selectedImage:@"soldier_decrease_select.png" target:self selector:@selector(setSoldierNumber:)];
    
    soldierA_increase=[CCMenuItemImage itemWithNormalImage:@"soldier_increase_unselect.png" selectedImage:@"soldier_increase_select.png" target:self selector:@selector(setSoldierNumber:)];
    
    soldierB_decrease=[CCMenuItemImage itemWithNormalImage:@"soldier_decrease_unselect.png" selectedImage:@"soldier_decrease_select.png" target:self selector:@selector(setSoldierNumber:)];
    
    soldierB_increase=[CCMenuItemImage itemWithNormalImage:@"soldier_increase_unselect.png" selectedImage:@"soldier_increase_select.png" target:self selector:@selector(setSoldierNumber:)];
    
    soldierC_decrease=[CCMenuItemImage itemWithNormalImage:@"soldier_decrease_unselect.png" selectedImage:@"soldier_decrease_unselect.png"];
    
    soldierC_increase=[CCMenuItemImage itemWithNormalImage:@"soldier_increase_unselect.png" selectedImage:@"soldier_increase_unselect.png"];
    
    soldierD_decrease=[CCMenuItemImage itemWithNormalImage:@"soldier_decrease_unselect.png" selectedImage:@"soldier_decrease_unselect.png"];
    
    soldierD_increase=[CCMenuItemImage itemWithNormalImage:@"soldier_increase_unselect.png" selectedImage:@"soldier_increase_unselect.png"];
    soldierE_decrease=[CCMenuItemImage itemWithNormalImage:@"soldier_decrease_unselect.png" selectedImage:@"soldier_decrease_unselect.png"];
    
    soldierE_increase=[CCMenuItemImage itemWithNormalImage:@"soldier_increase_unselect.png" selectedImage:@"soldier_increase_unselect.png"];
    soldierF_decrease=[CCMenuItemImage itemWithNormalImage:@"soldier_decrease_unselect.png" selectedImage:@"soldier_decrease_unselect.png"];
    
    soldierF_increase=[CCMenuItemImage itemWithNormalImage:@"soldier_increase_unselect.png" selectedImage:@"soldier_increase_unselect.png"];
    
    soldierA_decrease.position = ccp(-4, 5);
    soldierA_increase.position = ccp(44, 5);
    soldierB_decrease.position = ccp(66, 5);
    soldierB_increase.position = ccp(114, 5);
    soldierC_decrease.position = ccp(136, 5);
    soldierC_increase.position = ccp(184, 5);
    soldierD_decrease.position = ccp(-4, -90);
    soldierD_increase.position = ccp(44, -90);
    soldierE_decrease.position = ccp(66, -90);
    soldierE_increase.position = ccp(114,-90);
    soldierF_decrease.position = ccp(136, -90);
    soldierF_increase.position = ccp(184, -90);
    
    
    
    item1=[CCMenuItemFont itemWithString:[NSString stringWithFormat:@"%i", counterA]];
    [item1 setFontSize:20];
    item2=[CCMenuItemFont itemWithString:[NSString stringWithFormat:@"%i", counterB]];
    [item2 setFontSize:20];
    item3=[CCMenuItemFont itemWithString:[NSString stringWithFormat:@"%i", counterC]];
    [item3 setFontSize:20];
    item4=[CCMenuItemFont itemWithString:[NSString stringWithFormat:@"%i", counterD]];
    [item4 setFontSize:20];
    item5=[CCMenuItemFont itemWithString:[NSString stringWithFormat:@"%i", counterE]];
    [item5 setFontSize:20];
    item6=[CCMenuItemFont itemWithString:[NSString stringWithFormat:@"%i", counterF]];
    [item6 setFontSize:20];
    item1.position = ccp(20,3);
    item2.position = ccp(90,3);
    item3.position = ccp(160,3);
    item4.position = ccp(20,-92);
    item5.position = ccp(90,-92);
    item6.position = ccp(160,-92);
    CCMenu *SoldierMenu = [CCMenu menuWithItems:nil];
    
    
    [SoldierMenu addChild:soldierA_decrease z:0];
    [SoldierMenu addChild:soldierA_increase z:0];
    [SoldierMenu addChild:soldierB_decrease z:0];
    [SoldierMenu addChild:soldierB_increase z:0];
    [SoldierMenu addChild:soldierC_decrease z:0];
    [SoldierMenu addChild:soldierC_increase z:0];
    [SoldierMenu addChild:soldierD_decrease z:0];
    [SoldierMenu addChild:soldierD_increase z:0];
    [SoldierMenu addChild:soldierE_decrease z:0];
    [SoldierMenu addChild:soldierE_increase z:0];
    [SoldierMenu addChild:soldierF_decrease z:0];
    [SoldierMenu addChild:soldierF_increase z:0];
    [SoldierMenu addChild:item1];
    [SoldierMenu addChild:item2];
    [SoldierMenu addChild:item3];
    [SoldierMenu addChild:item4];
    [SoldierMenu addChild:item5];
    [SoldierMenu addChild:item6];
    
    [SoldierMenu setPosition:ccp(mobileDisplaySize.width/2, mobileDisplaySize.height/2)];
    return SoldierMenu;
}


/**used to be in SoldierLayer Start*/

- (void) setResource:(int) newResource {
    [player setResource:newResource];
    [resource_number setString:[NSString stringWithFormat:@"%d", newResource]];
}

-(void) setSoldierNumber:(id) soldierType{
    CCMenuItemImage *menuItemImage = (CCMenuItemImage*)soldierType;
    //add....
    int price;
    int newResource;
/**Soldier add and reduce*/
    
    if (menuItemImage == soldierA_increase) {
        price = [loader.stats[race][@"Runner"][@"price"] integerValue];
        newResource = [player getResource] - price;
        if(newResource >= 0){
            [self setResource:newResource];
            SoldierSetting* setting = [self getSoldierSetting:@"Runner"];
            [setting increaseCount];
            counterA = [setting getCount];
        }
    }
    if (menuItemImage == soldierA_decrease) {
        if(counterA >0)
        {
            price = [loader.stats[race][@"Runner"][@"price"] integerValue];
            newResource = [player getResource] + price;
            [self setResource:newResource];
            SoldierSetting* setting = [self getSoldierSetting:@"Runner"];
            [setting decreaseCount];
            counterA = [setting getCount];
        }
    }
    
    if (menuItemImage == soldierB_increase) {
        price = [loader.stats[race][@"Attacker1"][@"price"] integerValue];
        newResource = [player getResource] - price;
        if(newResource >= 0){
            [self setResource:newResource];
            SoldierSetting* setting = [self getSoldierSetting:@"Attacker1"];
            [setting increaseCount];
            counterB = [setting getCount];
        }
    }
    if (menuItemImage == soldierB_decrease) {
        if(counterB >0)
        {
            price = [loader.stats[race][@"Attacker1"][@"price"] integerValue];
            newResource = [player getResource] + price;
            [self setResource:newResource];
            SoldierSetting* setting = [self getSoldierSetting:@"Attacker1"];
            [setting decreaseCount];
            counterB = [setting getCount];
        }
    }
    
    if (menuItemImage == soldierC_increase) {
        wave_sol[cur_wave][0]++;
        counterC++;
    }
    if (menuItemImage == soldierC_decrease) {
        if(counterC >0)
        {
            wave_sol[cur_wave][0]--;
            counterC--;
            
        }
    }
    
    if (menuItemImage == soldierD_increase) {
        wave_sol[cur_wave][0]++;
        counterD++;
    }
    if (menuItemImage == soldierD_decrease) {
        if(counterD >0)
        {
            wave_sol[cur_wave][0]--;
            counterD--;
            
        }
    }
    
    if (menuItemImage == soldierE_increase) {
        wave_sol[cur_wave][0]++;
        counterE++;
    }
    if (menuItemImage == soldierE_decrease) {
        if(counterE >0)
        {
            wave_sol[cur_wave][0]--;
            counterE--;
            
        }
    }
    
    if (menuItemImage == soldierF_increase) {
        wave_sol[cur_wave][0]++;
        counterF++;
    }
    if (menuItemImage == soldierF_decrease) {
        if(counterF >0)
        {
            wave_sol[cur_wave][0]--;
            counterF--;
            
        }
    }
    [item1 setString:[NSString stringWithFormat:@"%d", counterA]];
    [item2 setString:[NSString stringWithFormat:@"%d", counterB]];
    [item3 setString:[NSString stringWithFormat:@"%d", counterC]];
    [item4 setString:[NSString stringWithFormat:@"%d", counterD]];
    [item5 setString:[NSString stringWithFormat:@"%d", counterE]];
    [item6 setString:[NSString stringWithFormat:@"%d", counterF]];
    
    
    NSString* wave= [gameStatusEssentialsSingleton currentWave];
    /*NSMutableDictionary * tempdictonary=[[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] objectForKey:wave];
    
    
    [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterA] forKey:@"SA"];
    [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterB] forKey:@"SB"];
    [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterC] forKey:@"SC"];
    [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterD] forKey:@"SD"];
    [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterE] forKey:@"SE"];
    [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterF] forKey:@"SF"];
    
    [[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] setObject:tempdictonary forKey:wave];
    */
    
    gameStatusEssentialsSingleton.counterA = counterA;
    gameStatusEssentialsSingleton.counterB = counterB;
    gameStatusEssentialsSingleton.counterC = counterC;
}

-(void)saveWaveSetting:(id)sender
{
    [SoldiersSave setValue:[NSNumber numberWithInt:counterA] forKey:@"SoldierA"];
    [SoldiersSave setValue:[NSNumber numberWithInt:counterB] forKey:@"SoldierB"];
    [WavesSave addObject:SoldiersSave];
    
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

@implementation WaveSetting {
    int index;
    NSMutableArray *_list;
}
+ (instancetype) setting: (int) idx
{
    return [[self alloc] initWave:idx];
}

- (instancetype) initWave:(int)idx
{
    self = [super init];
    if (!self) return(nil);
    index = idx;
    _list = [[NSMutableArray alloc] init];
    return self;
}

-(NSMutableArray*) getList{
    return _list;
}
@end

@implementation SoldierSetting {
    NSString *_type;
    int _count;
}
+ (instancetype) setting:(NSString *) type
{
    return [[self alloc] initSoldier: type];
}

- (instancetype) initSoldier:(NSString *)type
{
    self = [super init];
    if (!self) return(nil);
    _type = type;
    _count = 0;
    return self;
}
-(NSString*) getType{
    return  _type;
}
-(int) getCount{
    return _count;
}
-(void) increaseCount{
    _count++;
}
-(void) decreaseCount{
    _count--;
}
@end
