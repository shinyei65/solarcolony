//
//  TowerDestroyer.h
//  SolarColony
//
//  Created by Student on 2/17/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "Tower.h"
#import "BulletBasic.h"

@interface TowerRobot : CCNode<Tower>{
    int counterTest;
    int health;
    BulletBasic* bullet;
    id movePoint, returnPoint ;
}
@property(assign, atomic) CGPoint targetLocation;
@property(assign, atomic) CGPoint selfLocation;
@end
