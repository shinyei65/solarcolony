//
//  SoldierController.h
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Soldier.h"
#import "GameStatusEssentialsSingleton.h"
#import "PlayerInfo.h"

@interface SoldierController : CCNode


+(instancetype) Controller;
-(instancetype)init;
-(void)addSoldier:(Soldier *) newSoldier;
-(int)getArraylength;
-(void)updateSoldier:(ccTime) time;

//eder logic dont delete
-(NSMutableArray*)getSoldierArray;

@end
