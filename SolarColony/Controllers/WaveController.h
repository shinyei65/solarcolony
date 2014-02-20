//
//  WaveController.h
//  SolarColony
//
//  Created by Charles on 2/14/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoldierController.h"
#import "Army.h"

@interface WaveController : NSObject

+ (instancetype) controller: (SoldierController *) sol_control;
- (instancetype) init: (SoldierController *) sol_control;
- (void) update;
- (void) startWave;
- (void) endWave;
- (void) addWave: (Army *) wave;

@end
