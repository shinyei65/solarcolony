//
//  GameLandingScene.h
//  SolarColony
//
//  Created by Student on 2/7/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "AbstractScene.h"
#import "GameStatusEssentialsSingleton.h"

@interface GameLandingScene : CCLayer<AbstractScene>{
    TransitionManagerSingleton* transitionManagerSingleton;
    MusicManagerSingleton* musicManagerSingleton;
    GameStatusEssentialsSingleton *gameStatusEssentialsSingleton;
}


@end
