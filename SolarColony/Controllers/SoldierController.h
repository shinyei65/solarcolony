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

@interface SoldierController : NSObject

+(instancetype) Controller;
-(instancetype)init;
-addSoldier:(Soldier *) newSoldier;
-(int)getArraylength;


@end
