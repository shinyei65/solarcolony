//
//  LaserBullet.h
//  SolarColony
//
//  Created by Student on 4/26/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "CCNode.h"
#import "Bullet.h"
#import "TowerAttack.h"

@interface LaserBullet : CCNode<Bullet>
- (NormalBullet*) initTower:(CGPoint)location;
@end
