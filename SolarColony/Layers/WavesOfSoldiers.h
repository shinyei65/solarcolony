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
    
}
+(NSMutableDictionary*) SaveWave:(NSString*)WaveName:(NSString*)WaveKey;

@end