//
//  TowerFactory.m
//  SolarColony
//
//  Created by Student on 3/29/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "TowerFactory.h"

@implementation TowerFactory
+ (instancetype)factory {
    return [[[self class] alloc] init];
}

- (id)towerForKey:(NSString *)towerKey  Location: (CGPoint) location{
    gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
    stats = [GameStatsLoader loader];
    NSString * raceType=gameStatusEssentialsSingleton.raceType;
    
    CCNode<Tower>  *towerCreated = nil;
    
    //choose based on incomming key
    if ([towerKey isEqualToString:@"Support"]) {
        
        //choose based on current race
        towerCreated=[[TowerSupport alloc] initTower:location Race:raceType Reward:[stats.stats[raceType][@"TowerSupport"][@"reward"] integerValue] Life:[stats.stats[raceType][@"TowerSupport"][@"health"] integerValue] Price:[stats.stats[raceType][@"TowerSupport"][@"price"] integerValue] ];
        
    } else if ([towerKey isEqualToString:@"Special"]) {
        
        //choose based on current race
            towerCreated=[[TowerSpecial alloc] initTower:location Race:raceType Reward:[stats.stats[raceType][@"TowerSpecial"][@"reward"] integerValue] Life:[stats.stats[raceType][@"TowerSpecial"][@"health"] integerValue] Price:[stats.stats[raceType][@"TowerSpecial"][@"price"] integerValue] Attspeed:[stats.stats[raceType][@"TowerSpecial"][@"attspeed"] integerValue]] ;
        
    }  else if ([towerKey isEqualToString:@"Attackv1"]) {
        
        //choose based on current race
            towerCreated=[[TowerAttack alloc] initTower:location Race:raceType Life:[stats.stats[raceType][@"Tower1"][@"health"] integerValue] Price:[stats.stats[raceType][@"Tower1"][@"price"] integerValue] Reward:[stats.stats[raceType][@"Tower1"][@"reward"] integerValue] Attspeed:[stats.stats[raceType][@"Tower1"][@"attspeed"] integerValue] Power:[stats.stats[raceType][@"Tower1"][@"power"] integerValue]  TowerType:1];
        
    } else if ([towerKey isEqualToString:@"Attackv2"]) {
        
        //choose based on current race
            towerCreated=[[TowerAttack alloc] initTower:location Race:raceType Life:[stats.stats[raceType][@"Tower2"][@"health"] integerValue] Price:[stats.stats[raceType][@"Tower2"][@"price"] integerValue] Reward:[stats.stats[raceType][@"Tower2"][@"reward"] integerValue] Attspeed:[stats.stats[raceType][@"Tower2"][@"attspeed"] integerValue] Power:[stats.stats[raceType][@"Tower2"][@"power"] integerValue]  TowerType:2];
    }
    return [towerCreated autorelease];
}



@end
