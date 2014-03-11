//
//  SoldiersLayer.h
//  SolarColony
//
//  Created by Po-Yi Lee on 3/7/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "AbstractScene.h"


@interface SoldiersLayer : CCLayer<AbstractScene> {
    CCMenuItemFont *item1;
    CCMenuItemFont *item2;
    CCMenuItemFont *item3;
    CCMenuItemFont *item4;
    CCMenuItemFont *item5;
    CCMenuItemFont *item6;
    CCMenu *soldierMenus;
    int counterA, counterB,counterC,counterD,counterE,counterF;
    GameStatusEssentialsSingleton * gameStatusEssentialsSingleton;
}

@end
