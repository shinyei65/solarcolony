//
//  RobotSoldier.m
//  SolarColony
//
//  Created by Student on 3/5/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "RobotSoldier.h"

@implementation RobotSoldier

+ (instancetype) typeA:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    return([[RobotSoldier alloc]typeA_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp]);
}
- (instancetype) typeA_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    self = [super attacker_init:health ATTACK:attack Speed:speed ATTACK_SP:attack_sp];
    if (!self) return(nil);
    self->_soldier = [CCSprite spriteWithFile:@"RobotSoldier_Special.png"];
    
}

@end
