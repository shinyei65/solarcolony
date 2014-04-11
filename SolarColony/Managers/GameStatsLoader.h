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
@property(assign, nonatomic) NSMutableDictionary *stats;
@end
