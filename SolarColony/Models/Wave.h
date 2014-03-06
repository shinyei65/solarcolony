//
//  Wave.h
//  SolarColony
//
//  Created by Charles on 3/5/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Soldier.h"

@interface Wave : NSObject
+ (instancetype) wave;
- (instancetype) init;
- (int) count;
- (void) addSoldier: (Soldier *) sol;
- (Soldier *) popSoldier;
@end
