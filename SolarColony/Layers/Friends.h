//
//  Friends.h
//  SolarColony
//
//  Created by Po-Yi Lee on 2/8/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "AbstractScene.h"
#import "WorldColissionsManager.h"
@interface Friends : CCLayer<AbstractScene>{
    TransitionManagerSingleton *transitionManagerSingleton;
    //test
    WorldColissionsManager* colissionsManager;
    CGPoint location;
}

@end
