//
//  SupportTowerTouch.h
//  SolarColony
//
//  Created by Student on 4/6/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameStatusEssentialsSingleton.h"
#import "TowerGeneric.h"

@interface SupportTowerTouch : CCLayer {
    GameStatusEssentialsSingleton * gameStatusEssentialsSingleton;
    TowerGeneric* towerHelper;
    bool isDroppingTower;
    NSString* raceType;
    bool isUpgradable;
    CGPoint centerTower;
}

@end
