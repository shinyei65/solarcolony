//
//  BasicSoldier.h
//  SolarColony
//
//  Created by Student on 3/5/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Soldier.h"

@interface BasicSoldier : Soldier

+ (id) soldierWithRace:(NSString *) race;
+ (instancetype) human:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp;
+ (instancetype) robot:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp;
+ (instancetype) mage:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp;
- (instancetype) human_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp;
- (instancetype) robot_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp;
- (instancetype) mage_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp;

@end
