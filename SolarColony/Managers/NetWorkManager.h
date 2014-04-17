//
//  NetWorkManager.h
//  SolarColony
//
//  Created by Student on 3/10/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Army.h"
#import "ArmyQueue.h"
#import "PlayerInfo.h"

@interface NetWorkManager : NSObject

+(id)NetWorkManager;
-(id)init;
-(void)sendAttackRequest:(Army*)sendingArmy attackTarget:(NSString *)target;
-(void)getAttackRequest;
-(void)deleteAttackRequest:(NSString*)datetime;
-(BOOL)signInUser:(NSString*)username;
-(BOOL)checkUser:(NSString*)username;

@end
