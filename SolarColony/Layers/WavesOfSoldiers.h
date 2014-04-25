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
    CCMenuItemFont *wave1;
    CCMenu *waveMenus;
    CCMenuItemFont *item1;
    CCMenuItemFont *item2;
    CCMenuItemFont *item3;
    CCMenuItemFont *item4;
    CCMenuItemFont *item5;
    CCMenuItemFont *item6;
    
    CCMenu *soldierMenus;
    int counterA, counterB,counterC,counterD,counterE,counterF;
    
    CCMenuItemImage *soldierA_increase;
    CCMenuItemImage *soldierA_decrease;
    CCMenuItemImage *soldierB_increase;
    CCMenuItemImage *soldierB_decrease;
    CCMenuItemImage *soldierC_increase;
    CCMenuItemImage *soldierC_decrease;
    CCMenuItemImage *soldierD_increase;
    CCMenuItemImage *soldierD_decrease;
    CCMenuItemImage *soldierE_increase;
    CCMenuItemImage *soldierE_decrease;
    CCMenuItemImage *soldierF_increase;
    CCMenuItemImage *soldierF_decrease;
}
+(NSMutableDictionary*) SaveWave:(NSString*)WaveName:(NSString*)WaveKey;
- (void) AddWave: (int) waveID;
@end

@interface WaveSetting : NSObject
+ (instancetype) setting: (int) idx;
- (instancetype) initWave: (int) idx;
- (NSMutableArray*) getList;
-(NSString *) toJSONstring;
@end

@interface SoldierSetting : NSObject
+ (instancetype) setting: (NSString*) type;
- (instancetype) initSoldier: (NSString*) type;
-(NSString*) getType;
-(int) getCount;
-(void) increaseCount;
-(void) decreaseCount;
-(NSString *) toJSONstring;
@end