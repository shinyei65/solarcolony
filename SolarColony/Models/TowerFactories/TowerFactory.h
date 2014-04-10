//
//  TowerFactory.h
//  SolarColony
//
//  Created by Student on 3/29/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameStatusEssentialsSingleton.h"
#import "GameStatsLoader.h"
#import "Tower.h"
#import "TowerSupport.h"
#import "TowerAttack.h"
#import "TowerSpecial.h"

@interface TowerFactory : NSObject
{
    GameStatusEssentialsSingleton * gameStatusEssentialsSingleton;
    GameStatsLoader *stats;
}
+ (instancetype)factory;
-(id)towerForKey:(NSString *)towerKey  Location: (CGPoint) location;
@end
