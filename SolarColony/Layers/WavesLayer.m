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
    int x;
    int y;
    CCArray *ItemArray;
    
}

@synthesize mobileDisplaySize;


-(id)init{
    
    if(self=[super init]){
        
        transitionManagerSingleton = [TransitionManagerSingleton sharedInstance];
        //Game status global variables
        gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
        wave_num = 1;
        
        CCMenuItem *addItemButton = [CCMenuItemImage itemWithNormalImage:@"AddButton.png" selectedImage:@"AddButton_select.png" target:self selector:@selector(AddNewItem)];

        [addItemButton setPosition:ccp(-50,50)];
        
        wave1=[CCMenuItemFont itemWithString:@"Wave 1" target:self selector:@selector(setSoldierinWave:)];
        wave1.tag = 1;
        
        [wave1 setFontSize:20];
        //[wave1 setColor:ccc3(255, 0, 0)];
        
        //waveMenus= [CCMenu menuWithItems:addItemButton,wave1, wave2, wave3, nil];
        waveMenus= [CCMenu menuWithItems:addItemButton,wave1, nil];
        //[WaveMenus  alignItemsInGridWithPadding:ccp(25, 25) columns:3];
        
        [waveMenus alignItemsVertically];
        
        [waveMenus setPosition:ccp( 0, mobileDisplaySize.height/2)];
        
        soldierlayer = [[SoldiersLayer alloc] init];
        [soldierlayer setPosition:ccp(mobileDisplaySize.width + 200, mobileDisplaySize.height/2)];
        
        
        [self addChild: waveMenus z:1];
        [self addChild: soldierlayer z:2];
                
    }
    
    return self;
}

-(void) setSoldierinWave:(id) soldierType{
    CCMenuItemFont *menuItem = (CCMenuItemFont*)soldierType;
    NSString *currwave;
    switch (menuItem.tag) {
        case 1:
            [gameStatusEssentialsSingleton setCurrentWave:@"w1"];
           // [menuItem setColor:ccc3(255,0,0)];
           // [wave2 setColor:ccc3(255,255,255)];
           // [wave3 setColor:ccc3(255,255,255)];
           // [wave4 setColor:ccc3(255,255,255)];
           // [wave5 setColor:ccc3(255,255,255)];
           // [wave6 setColor:ccc3(255,255,255)];
           // [wave7 setColor:ccc3(255,255,255)];
           // [wave8 setColor:ccc3(255,255,255)];
            
            currwave = [gameStatusEssentialsSingleton getCurrentWave];
           // CCLOG(currwave);
            break;
        case 2:
            [gameStatusEssentialsSingleton setCurrentWave:@"w2"];
            //[menuItem setColor:ccc3(255,0,0)];
            //[wave1 setColor:ccc3(255,255,255)];
            //[wave3 setColor:ccc3(255,255,255)];
            //[wave4 setColor:ccc3(255,255,255)];
            //[wave5 setColor:ccc3(255,255,255)];
            //[wave6 setColor:ccc3(255,255,255)];
            //[wave7 setColor:ccc3(255,255,255)];
            //[wave8 setColor:ccc3(255,255,255)];
            currwave = [gameStatusEssentialsSingleton getCurrentWave];
           // CCLOG(currwave);
            break;
        case 3:
            [gameStatusEssentialsSingleton setCurrentWave:@"w3"];
            //[menuItem setColor:ccc3(255,0,0)];
            //[wave1 setColor:ccc3(255,255,255)];
            //[wave2 setColor:ccc3(255,255,255)];
            //[wave4 setColor:ccc3(255,255,255)];
            //[wave5 setColor:ccc3(255,255,255)];
            //[wave6 setColor:ccc3(255,255,255)];
            //[wave7 setColor:ccc3(255,255,255)];
            //[wave8 setColor:ccc3(255,255,255)];
            
            currwave = [gameStatusEssentialsSingleton getCurrentWave];
            CCLOG(currwave);
            break;
        case 4:
            [gameStatusEssentialsSingleton setCurrentWave:@"w4"];
            //[menuItem setColor:ccc3(255,0,0)];
            //[wave1 setColor:ccc3(255,255,255)];
            //[wave2 setColor:ccc3(255,255,255)];
            //[wave3 setColor:ccc3(255,255,255)];
            //[wave5 setColor:ccc3(255,255,255)];
            //[wave6 setColor:ccc3(255,255,255)];
            //[wave7 setColor:ccc3(255,255,255)];
            //[wave8 setColor:ccc3(255,255,255)];
            
            currwave = [gameStatusEssentialsSingleton getCurrentWave];
            CCLOG(currwave);
            break;
        case 5:
            [gameStatusEssentialsSingleton setCurrentWave:@"w5"];
            //[menuItem setColor:ccc3(255,0,0)];
            //[wave1 setColor:ccc3(255,255,255)];
            //[wave2 setColor:ccc3(255,255,255)];
            //[wave3 setColor:ccc3(255,255,255)];
            //[wave4 setColor:ccc3(255,255,255)];
            //[wave6 setColor:ccc3(255,255,255)];
            //[wave7 setColor:ccc3(255,255,255)];
            //[wave8 setColor:ccc3(255,255,255)];
            
            currwave = [gameStatusEssentialsSingleton getCurrentWave];
            CCLOG(currwave);
            break;
        case 6:
            [gameStatusEssentialsSingleton setCurrentWave:@"w6"];
            /*[menuItem setColor:ccc3(255,0,0)];
            [wave1 setColor:ccc3(255,255,255)];
            [wave2 setColor:ccc3(255,255,255)];
            [wave3 setColor:ccc3(255,255,255)];
            [wave4 setColor:ccc3(255,255,255)];
            [wave5 setColor:ccc3(255,255,255)];
            [wave7 setColor:ccc3(255,255,255)];
            [wave8 setColor:ccc3(255,255,255)];
            */
            currwave = [gameStatusEssentialsSingleton getCurrentWave];
            CCLOG(currwave);
            break;
        case 7:
            [gameStatusEssentialsSingleton setCurrentWave:@"w7"];
            /*[menuItem setColor:ccc3(255,0,0)];
            [wave1 setColor:ccc3(255,255,255)];
            [wave2 setColor:ccc3(255,255,255)];
            [wave3 setColor:ccc3(255,255,255)];
            [wave4 setColor:ccc3(255,255,255)];
            [wave5 setColor:ccc3(255,255,255)];
            [wave6 setColor:ccc3(255,255,255)];
            [wave8 setColor:ccc3(255,255,255)];
            */
            currwave = [gameStatusEssentialsSingleton getCurrentWave];
            CCLOG(currwave);
            break;
        case 8:
            [gameStatusEssentialsSingleton setCurrentWave:@"w8"];
            /*[menuItem setColor:ccc3(255,0,0)];
            [wave1 setColor:ccc3(255,255,255)];
            [wave2 setColor:ccc3(255,255,255)];
            [wave3 setColor:ccc3(255,255,255)];
            [wave4 setColor:ccc3(255,255,255)];
            [wave5 setColor:ccc3(255,255,255)];
            [wave6 setColor:ccc3(255,255,255)];
            [wave7 setColor:ccc3(255,255,255)];
            */
            currwave = [gameStatusEssentialsSingleton getCurrentWave];
            CCLOG(currwave);
            break;
        default:
            break;
    }
    
}

-(void)AddNewItem{
    CCLOG(@"add new item");
    wave_num = wave_num + 1;
    CCMenuItemFont* WaveNum = [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"Wave %i",wave_num] target:self selector:@selector(setSoldierinWave:)];
    WaveNum.tag = wave_num;
    [WaveNum setFontSize:20];
    [WaveNum setZOrder:2];
    [waveMenus addChild:WaveNum];
    [waveMenus alignItemsVertically];
    
}
-(void)dealloc{
    [super dealloc];
}

@end
