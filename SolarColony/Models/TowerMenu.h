//
//  TowerMenu.h
//  SolarColony
//
//  Created by charles on 2/11/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface TowerMenu : CCMenu    
+ (instancetype) menu;
- (instancetype) init;
- (void) createTowerofType:(id) towerType;
- (void) setMapLocation: (CGPoint) index;
- (CGPoint) getMapLocation;
@end
