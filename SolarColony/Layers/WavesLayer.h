//
//  WavesLayer.h
//  SolarColony
//
//  Created by Po-Yi Lee on 3/7/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "AbstractScene.h"

@interface WavesLayer : CCLayer <AbstractScene> {
    TransitionManagerSingleton* transitionManagerSingleton;
    GameStatusEssentialsSingleton * gameStatusEssentialsSingleton;
    CCMenuItemFont *wave1;
    CCMenuItemFont *wave2;
    CCMenuItemFont *wave3;
    CCMenuItemFont *wave4;
    CCMenuItemFont *wave5;
    CCMenuItemFont *wave6;
    CCMenuItemFont *wave7;
    CCMenuItemFont *wave8;
    CCMenu *waveMenus;

}

@end
