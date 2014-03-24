//
//  MyCocos2DClass.h
//  SolarColony
//
//  Created by Student on 3/23/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameStatusEssentialsSingleton.h"

@interface PauseScene  : CCLayer {
    GameStatusEssentialsSingleton *gameStatusEssentialsSingleton;
}
+(CCScene *) scene;
@end
