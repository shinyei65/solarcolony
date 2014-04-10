//
//  GameStatsLoader.h
//  SolarColony
//
//  Created by Charles on 4/2/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameStatsLoader : NSObject
+ (GameStatsLoader *)loader;
// robot tower1
@property(assign, nonatomic) int robotT1_health;
@property(assign, nonatomic) int robotT1_price;
@property(assign, nonatomic) int robotT1_reward;
@property(assign, nonatomic) int robotT1_power;
@property(assign, nonatomic) float robotT1_attspeed;
// robot tower2
@property(assign, nonatomic) int robotT2_health;
@property(assign, nonatomic) int robotT2_price;
@property(assign, nonatomic) int robotT2_reward;
@property(assign, nonatomic) int robotT2_power;
@property(assign, nonatomic) int robotT2_attspeed;
@property(assign, nonatomic) NSMutableDictionary *stats;
@end
