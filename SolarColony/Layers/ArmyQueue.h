//
//  ArmyQueue.h
//  SolarColony
//
//  Created by Charles on 2/19/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "WaveController.h"
#import "Army.h"

@interface ArmyQueue : CCLayer {
    NSMutableArray *_queue;
}

+ (instancetype) layer;
- (instancetype) init;
- (void) updateTick;
- (void) endWave;
- (void) addArmy: (Army *) army;
@end

@interface WaveSprite : CCNode
+ (id) sprtieWithUserID: (NSString *) uid Race: (NSString *) race;
- (id) init: (NSString *) uid Race: (NSString *) race;
@end