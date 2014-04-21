//
//  RobotSoldier.m
//  SolarColony
//
//  Created by Student on 3/5/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "RobotSoldier.h"
#import "GameStatsLoader.h"

@implementation RobotSoldier

+ (id) soldierWithType:(NSString *) type
{
    NSMutableDictionary *stats = [GameStatsLoader loader].stats;
    if([type isEqualToString:@"typeA"]){
        return([[RobotSoldier alloc]typeA_init:[stats[@"Robot"][@"Attacker1"][@"health"] integerValue] ATTACK:[stats[@"Robot"][@"Attacker1"][@"power"] integerValue] Speed:[stats[@"Robot"][@"Attacker1"][@"speed"] integerValue] ATTACK_SP:[stats[@"Robot"][@"Attacker1"][@"attspeed"] integerValue]]);
    }else{
        return([[RobotSoldier alloc]typeA_init:[stats[@"Robot"][@"Attacker1"][@"health"] integerValue] ATTACK:[stats[@"Robot"][@"Attacker1"][@"power"] integerValue] Speed:[stats[@"Robot"][@"Attacker1"][@"speed"] integerValue] ATTACK_SP:[stats[@"Robot"][@"Attacker1"][@"attspeed"] integerValue]]);
    }
}
+ (instancetype) typeA:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    return([[RobotSoldier alloc]typeA_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp]);
}
- (instancetype) typeA_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    self = [super attacker_init:health ATTACK:attack Speed:speed ATTACK_SP:attack_sp];
    if (!self) return(nil);
    _soldier = [CCSprite spriteWithFile:@"RobotSoldier_Special.png"];
    type = @"R2";
    [self addChild:_soldier];
    return self;
}

@end
