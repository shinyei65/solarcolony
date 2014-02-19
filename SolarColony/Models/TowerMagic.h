//
//  TowerMagic.h
//  SolarColony
//
//  Created by Student on 2/18/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//


#import "Tower.h"
#import "BulletBasic.h"

@interface TowerMagic : CCNode<Tower>{
    int counterTest;
    BulletBasic* bullet;
    id movePoint, returnPoint ;
}
@property(assign, atomic) CGPoint targetLocation;
@end
