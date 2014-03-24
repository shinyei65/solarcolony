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
}
@synthesize mobileDisplaySize;

/*-(id)init{

    if(self=[super init]){

        transitionManagerSingleton = [TransitionManagerSingleton sharedInstance];
        CCMenuItemFont *wave1=[CCMenuItemFont itemWithString:@"Wave 1" target:self selector:nil];
//    CCMenuItemFont *wave2=[CCMenuItemFont itemWithString:@"Wave 2" target:self selector:nil];
//    CCMenuItemFont *wave3=[CCMenuItemFont itemWithString:@"Wave 3" target:self selector:nil];
        item1=[CCMenuItemFont itemWithString:@" " target:self selector:nil];
        item2=[CCMenuItemFont itemWithString:@" " target:self selector:nil];
        item3=[CCMenuItemFont itemWithString:@" " target:self selector:nil];
        item4=[CCMenuItemFont itemWithString:@" " target:self selector:nil];
        item5=[CCMenuItemFont itemWithString:@" " target:self selector:nil];
        item6=[CCMenuItemFont itemWithString:@" " target:self selector:nil];

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

        [self addChild:WaveMenus];

    }

    return self;
}
*/
-(id)init{
    
    if(self=[super init]){
        
        transitionManagerSingleton = [TransitionManagerSingleton sharedInstance];
        //Game status global variables
        gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
        
        item1=[CCMenuItemFont itemWithString:@"Wave 1" target:self selector:@selector(setSoldierinWave:)];
        item2=[CCMenuItemFont itemWithString:@"Wave 2" target:self selector:@selector(setSoldierinWave:)];
        item3=[CCMenuItemFont itemWithString:@"Wave 3" target:self selector:@selector(setSoldierinWave:)];
       // item4=[CCMenuItemFont itemWithString:@"Wave 4" target:self selector:@selector(setSoldierinWave:)];
       // item5=[CCMenuItemFont itemWithString:@"Wave 5" target:self selector:@selector(setSoldierinWave:)];
       // item6=[CCMenuItemFont itemWithString:@"Wave 6" target:self selector:@selector(setSoldierinWave:)];
       
        
        [item1 setFontSize:20];
        [item2 setFontSize:20];
        [item3 setFontSize:20];
      //  [item4 setFontSize:20];
      //  [item5 setFontSize:20];
      //  [item6 setFontSize:20];
        [item1 setColor:ccc3(255, 0, 0)];
        
        CCMenu *waveMenus= [CCMenu menuWithItems:item1, item2, item3, item4, item5, item6, nil];
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
    
    if ([menuItem.label.string isEqualToString:@"Wave 1"]) {
        [gameStatusEssentialsSingleton setCurrentWave:@"w1"];
         [menuItem setColor:ccc3(255,0,0)];
        [soldierlayer loadWave:0];
        
        [item2 setColor:ccc3(255,255,255)];
        [item3 setColor:ccc3(255,255,255)];
        [item4 setColor:ccc3(255,255,255)];
        [item5 setColor:ccc3(255,255,255)];
        [item6 setColor:ccc3(255,255,255)];
        
    }else if ([menuItem.label.string isEqualToString:@"Wave 2"]) {
        [gameStatusEssentialsSingleton setCurrentWave:@"w2"];
         [menuItem setColor:ccc3(255,0,0)];
        [soldierlayer loadWave:1];
        
        [item1 setColor:ccc3(255,255,255)];
        [item3 setColor:ccc3(255,255,255)];
        [item4 setColor:ccc3(255,255,255)];
        [item5 setColor:ccc3(255,255,255)];
        [item6 setColor:ccc3(255,255,255)];
    }else if ([menuItem.label.string isEqualToString:@"Wave 3"]) {
        [gameStatusEssentialsSingleton setCurrentWave:@"w3"];
         [menuItem setColor:ccc3(255,0,0)];
        [soldierlayer loadWave:2];
        
        [item1 setColor:ccc3(255,255,255)];
        [item2 setColor:ccc3(255,255,255)];
        [item4 setColor:ccc3(255,255,255)];
        [item5 setColor:ccc3(255,255,255)];
        [item6 setColor:ccc3(255,255,255)];
    }else if ([menuItem.label.string isEqualToString:@"Wave 4"]) {
        [gameStatusEssentialsSingleton setCurrentWave:@"w4"];
         [menuItem setColor:ccc3(255,0,0)];
        
        [item1 setColor:ccc3(255,255,255)];
        [item2 setColor:ccc3(255,255,255)];
        [item3 setColor:ccc3(255,255,255)];
        [item5 setColor:ccc3(255,255,255)];
        [item6 setColor:ccc3(255,255,255)];
    }else if ([menuItem.label.string isEqualToString:@"Wave 5"]) {
        [gameStatusEssentialsSingleton setCurrentWave:@"w5"];
         [menuItem setColor:ccc3(255,0,0)];
        
        [item1 setColor:ccc3(255,255,255)];
        [item2 setColor:ccc3(255,255,255)];
        [item3 setColor:ccc3(255,255,255)];
        [item4 setColor:ccc3(255,255,255)];
        [item6 setColor:ccc3(255,255,255)];
    }else if ([menuItem.label.string isEqualToString:@"Wave 6"]) {
        [gameStatusEssentialsSingleton setCurrentWave:@"w6"];
         [menuItem setColor:ccc3(255,0,0)];
        
        [item1 setColor:ccc3(255,255,255)];
        [item2 setColor:ccc3(255,255,255)];
        [item3 setColor:ccc3(255,255,255)];
        [item4 setColor:ccc3(255,255,255)];
        [item5 setColor:ccc3(255,255,255)];
    }else if ([menuItem.label.string isEqualToString:@"Wave 7"]) {
        [gameStatusEssentialsSingleton setCurrentWave:@"w7"];
         [menuItem setColor:ccc3(255,0,0)];
    }
}
-(void)dealloc{
    [super dealloc];
}

@end
