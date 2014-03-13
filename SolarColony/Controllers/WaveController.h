//
//  WaveController.h
//  SolarColony
//
//  Created by Charles on 2/14/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wave.h"
#import "NetWorkManager.h"

@interface WaveController : NSObject

+ (instancetype) controller;
- (instancetype) init;
- (void) update;
- (void) startWave: (Wave *) target;
- (void) endWave;

@end
