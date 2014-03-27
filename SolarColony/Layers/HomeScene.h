//
//  HomeScene.h
//  SolarColony
//
//  Created by Student on 2/7/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "AbstractScene.h"

@interface HomeScene : CCLayer<AbstractScene>{
    TransitionManagerSingleton* transitionManagerSingleton;
    MusicManagerSingleton* musicManagerSingleton;
    PlayerInfo* player;
}
@end

