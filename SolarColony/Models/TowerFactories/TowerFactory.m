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
            towerCreated=[[TowerAttack alloc] initTower:location Race:raceType Power:2];
        
    } else if ([towerKey isEqualToString:@"Attackv2"]) {
        
        //choose based on current race
            towerCreated=[[TowerAttack alloc] initTower:location Race:raceType Power:3];
    }
    return [towerCreated autorelease];
}



@end
