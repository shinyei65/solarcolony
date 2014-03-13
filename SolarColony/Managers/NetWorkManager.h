//
//  NetWorkManager.h
//  SolarColony
//
//  Created by Student on 3/10/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Army.h"

@interface NetWorkManager : NSObject

+(id)NetWorkManager;
-(id)init;
-(void)sendAttackRequest:(Army*)sendingArmy;
-(Army*)generateArmyFromNetworkResource:(NSString*)sendingArmy;
@end
