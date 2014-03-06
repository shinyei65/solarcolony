//
//  HumanSoldier.h
//  SolarColony
//
//  Created by Student on 3/5/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Soldier.h"

@interface HumanSoldier : Soldier

+ (instancetype) typeA:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp;
- (instancetype) typeA_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp;

@end
