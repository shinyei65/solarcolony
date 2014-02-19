//
//  Army.h
//  SolarColony
//
//  Created by Charles on 2/18/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Soldier.h";

@interface Army : NSObject
+ (instancetype) army;
- (instancetype) init;
- (int) count;
- (void) addSoldier: (Soldier *) sol;
- (Soldier *) popSoldier;
@end
