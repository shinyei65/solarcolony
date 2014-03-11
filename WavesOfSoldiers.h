//
//  WavesOfSoldiers.h
//  SolarColony
//
//  Created by Po-Yi Lee on 3/3/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//


#import "AbstractScene.h"


@interface WavesOfSoldiers : CCLayer<AbstractScene>{
    TransitionManagerSingleton* transitionManagerSingleton;
    GameStatusEssentialsSingleton * gameStatusEssentialsSingleton;
}

@end
