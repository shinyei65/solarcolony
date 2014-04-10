//
//  TowerMagic.h
//  SolarColony
//
//  Created by Student on 2/18/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//


#import "Tower.h"
#import "NormalBullet.h"

@interface TowerSpecial : CCNode<Tower>{
    int counterTest;
    int health;
    NormalBullet* bullet;
    id movePoint, returnPoint ;
    CCSprite* towerSprite;
    CCSprite* towerSprite_hp;
}
@property(assign, atomic) CGPoint targetLocation;
@property(assign, atomic) CGPoint selfLocation;
@end
