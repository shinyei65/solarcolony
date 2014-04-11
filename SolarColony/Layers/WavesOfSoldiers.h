//
//  WavesOfSoldiers.h
//  SolarColony
//
//  Created by Po-Yi Lee on 3/3/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//


#import "AbstractScene.h"


@interface WavesOfSoldiers : CCLayer<AbstractScene>{
    TransitionManagerSingleton* transitionManagerSingleton;
    GameStatusEssentialsSingleton * gameStatusEssentialsSingleton;
    NSMutableDictionary* Wave_Store;
    CCMenuItemFont *wave1;
    CCMenu *waveMenus;
    CCMenuItemFont *item1;
    CCMenuItemFont *item2;
    CCMenuItemFont *item3;
    //for increasing number of soldier
    CCMenuItemFont *item4;
    CCMenuItemFont *item5;
    CCMenuItemFont *item6;
    
    
    //for decreasing number of soldier
    CCMenuItemFont *item7;
    CCMenuItemFont *item8;
    CCMenuItemFont *item9;
    CCMenu *soldierMenus;
    int counterA, counterB,counterC,counterD,counterE,counterF;
}
+(NSMutableDictionary*) SaveWave:(NSString*)WaveName:(NSString*)WaveKey;
- (void) AddWave: (int) waveID;
@end