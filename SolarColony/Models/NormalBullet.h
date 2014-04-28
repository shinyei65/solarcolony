//
//  NormalBullet.h
//  SolarColony
//
//  Created by Student on 2/26/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "Bullet.h"

@interface NormalBullet : CCNode<Bullet>
- (NormalBullet*) initTower:(CGPoint)location;
- (NormalBullet*) initSoldier:(CGPoint)location;
-(bool) getFlipFlag;
@end