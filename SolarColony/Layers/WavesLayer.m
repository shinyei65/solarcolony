//
//  WavesLayer.m
//  SolarColony
//
//  Created by Po-Yi Lee on 3/7/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "WavesLayer.h"
#import "SoldiersLayer.h"


@implementation WavesLayer {
    SoldiersLayer *soldierlayer;
    int wave_num;
    NSArray *ItemArray;
}

@synthesize mobileDisplaySize;


-(id)init{
    
    if(self=[super init]){
        
        transitionManagerSingleton = [TransitionManagerSingleton sharedInstance];
        //Game status global variables
        gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
        
        
        
        wave_num = 1;
        
        //Plus button
        CCMenuItem *addItemButton = [CCMenuItemImage itemWithNormalImage:@"AddButton.png" selectedImage:@"AddButton_select.png" target:self selector:@selector(AddNewItem)];
        [addItemButton setPosition:ccp(-50,50)];
        
        
        wave1=[CCMenuItemFont itemWithString:@"Wave 1" target:self selector:@selector(setSoldierinWave:)];
        wave1.tag = 1;
        [wave1 setFontSize:20];
        
        [gameStatusEssentialsSingleton setCurrentWave:@"w1"];
       
        
        

        
        
        
        waveMenus= [CCMenu menuWithItems:addItemButton,wave1, nil];
        
        [waveMenus alignItemsVertically];
        [waveMenus setPosition:ccp( 0, mobileDisplaySize.height/2)];
        
        
        
        soldierlayer = [[SoldiersLayer alloc] init];
        [soldierlayer setPosition:ccp(mobileDisplaySize.width + 200, mobileDisplaySize.height/2)];
        
        
        [self addChild: waveMenus z:1];
        [self addChild: [self loadSoldierLayer]];
        
    }
    
    return self;
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
    // CCLOG(@"add new item");
    
    wave_num = wave_num + 1;
    NSString *Wave_num =[NSString stringWithFormat:@"Wave %i",wave_num];
    NSString *wave_key = [NSString stringWithFormat:@"w%i",wave_num];
    
    CCMenuItemFont* WaveNum = [CCMenuItemFont itemWithString: Wave_num target:self selector:@selector(setSoldierinWave:)];
    WaveNum.tag = wave_num;
    [WaveNum setFontSize:20];
    [WaveNum setZOrder:2];
    [waveMenus addChild:WaveNum];
    [waveMenus alignItemsVertically];
    
    
    
}

-(CCLayer*)loadSoldierLayer
{
    return soldierlayer;
}
-(void)dealloc{
    [super dealloc];
}

@end
