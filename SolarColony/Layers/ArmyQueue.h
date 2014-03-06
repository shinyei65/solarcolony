//
//  ArmyQueue.h
//  SolarColony
//
//  Created by Charles on 2/19/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Army.h"

@interface ArmyQueue : CCLayer {
    NSMutableArray *queue;
}

+ (instancetype) layer;
- (instancetype) init;
- (void) updateTick;
- (void) refreshTick;
- (void) addArmy: (Army *) army;
@end
