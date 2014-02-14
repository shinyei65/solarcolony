//
//  WaveController.h
//  SolarColony
//
//  Created by Student on 2/14/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaveController : NSObject

+ (instancetype) controller;
- (instancetype) init;
- (BOOL) getStatus;
- (void) update;

@end
