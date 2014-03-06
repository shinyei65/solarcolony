//
//  BasicSoldier.m
//  SolarColony
//
//  Created by Student on 3/5/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "BasicSoldier.h"

@implementation BasicSoldier

+ (instancetype) human:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    return([[BasicSoldier alloc]human_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp]);

}
+ (instancetype) robot:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    return([[BasicSoldier alloc]robot_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp]);

}
+ (instancetype) mage:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    return([[BasicSoldier alloc]mage_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp]);

}
- (instancetype) human_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    self = [super runner_init:health ATTACK:attack Speed:speed ATTACK_SP:attack_sp];
    if (!self) return(nil);
    self->_soldier = [CCSprite spriteWithFile:@"HumanSoldier_Basic.gif"];
    
}
- (instancetype) robot_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    self = [super runner_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp];
    if (!self) return(nil);
    self->_soldier = [CCSprite spriteWithFile:@"RobotSoldier_Basic.png"];

}
- (instancetype) mage_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    self = [super runner_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp];
    if (!self) return(nil);
    self->_soldier = [CCSprite spriteWithFile:@"MageSoldier_Basic.png"];
}


@end
