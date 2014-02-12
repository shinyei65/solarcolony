//
//  TransitionManagerSingleton.h
//  SolarColony
//
//  Created by Student on 2/7/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface TransitionManagerSingleton : NSObject {
    
}
+ (id)sharedInstance;
-(void) transitionTo:(int) nextScene;
@end

