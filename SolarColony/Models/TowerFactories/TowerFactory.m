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
            towerCreated=[[TowerSupport alloc] initTower:location Race:raceType];
        
    } else if ([towerKey isEqualToString:@"Special"]) {
        
        //choose based on current race
            towerCreated=[[TowerSpecial alloc] initTower:location Race:raceType];
        
    }  else if ([towerKey isEqualToString:@"Attackv1"]) {
        
        //choose based on current race
            towerCreated=[[TowerAttack alloc] initTower:location Race:raceType Life:stats.stats[raceType][@"Tower1"][@"health"] Price:stats.stats[raceType][@"Tower1"][@"price"] Reward:stats.stats[raceType][@"Tower1"][@"reward"] Attspeed:stats.stats[raceType][@"Tower1"][@"attspeed"] Power:stats.stats[raceType][@"Tower1"][@"power"]];
        
    } else if ([towerKey isEqualToString:@"Attackv2"]) {
        
        //choose based on current race
            towerCreated=[[TowerAttack alloc] initTower:location Race:raceType Life:stats.stats[raceType][@"Tower2"][@"health"] Price:stats.stats[raceType][@"Tower2"][@"price"] Reward:stats.stats[raceType][@"Tower2"][@"reward"] Attspeed:stats.stats[raceType][@"Tower2"][@"attspeed"] Power:stats.stats[raceType][@"Tower2"][@"power"]];
    }
    return [towerCreated autorelease];
}



@end
