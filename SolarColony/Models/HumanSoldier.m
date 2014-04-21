//
//  HumanSoldier.m
//  SolarColony
//
//  Created by Student on 3/5/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "HumanSoldier.h"
#import "GameStatsLoader.h"

@implementation HumanSoldier

+ (id) soldierWithType:(NSString *) type
{
    NSMutableDictionary *stats = [GameStatsLoader loader].stats;
    if([type isEqualToString:@"typeA"]){
        return([[HumanSoldier alloc]typeA_init:[stats[@"Human"][@"Attacker1"][@"health"] integerValue] ATTACK:[stats[@"Human"][@"Attacker1"][@"power"] integerValue] Speed:[stats[@"Human"][@"Attacker1"][@"speed"] integerValue] ATTACK_SP:[stats[@"Human"][@"Attacker1"][@"attspeed"] integerValue]]);
    }else{
        return([[HumanSoldier alloc]typeA_init:[stats[@"Human"][@"Attacker1"][@"health"] integerValue] ATTACK:[stats[@"Human"][@"Attacker1"][@"power"] integerValue] Speed:[stats[@"Human"][@"Attacker1"][@"speed"] integerValue] ATTACK_SP:[stats[@"Human"][@"Attacker1"][@"attspeed"] integerValue]]);
    }
}
+ (instancetype) typeA:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    return([[HumanSoldier alloc]typeA_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp]);
}
- (instancetype) typeA_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    self = [super attacker_init:health ATTACK:attack Speed:speed ATTACK_SP:attack_sp];
    if (!self) return(nil);
    _soldier = [CCSprite spriteWithFile:@"HumanSoldier_Special.gif"];
    type = @"H2";
    [self addChild:_soldier];
    return self;
}



@end
