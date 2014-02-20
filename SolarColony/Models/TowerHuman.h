//
//  TowerBasic.h
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "Tower.h"
#import "BulletBasic.h"
@interface TowerHuman : CCNode<Tower>{
    int counterTest;
    int health;
    BulletBasic* bullet;
    id movePoint, returnPoint ;
}
@property(assign, atomic) CGPoint targetLocation;
@property(assign, atomic) CGPoint selfLocation;
@end
