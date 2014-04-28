//
//  TowerGeneric.h
//  SolarColony
//
//  Created by Student on 4/6/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tower.h"

@interface TowerGeneric : CCNode<Tower>{
    CCSprite* healedSprite;
    int _health;
    CCSprite* towerSprite_hp;
    CCSprite* towerSprite;
}
@property(assign, atomic) CGPoint targetLocation;
@property(assign, atomic) CGPoint selfLocation;

@end
