//
//  TowerMagic.h
//  SolarColony
//
//  Created by Student on 2/18/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//


#import "Tower.h"
#import "NormalBullet.h"
#import "TowerGeneric.h"

@interface TowerSpecial : TowerGeneric{
    int counterTest;
    NormalBullet* bullet;
    id movePoint, returnPoint ;
    CCSprite* towerSprite;
    CCProgressTimer *timeBar;
    int counter;
    CCMenu *mainMenuUpgrade;
}
@property(assign, atomic) CGPoint targetLocation;
@property(assign, atomic) CGPoint selfLocation;
@end
