//
//  Settings.h
//  SolarColony
//
//  Created by Po-Yi Lee on 2/10/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "AbstractScene.h"
#import "SimpleAudioEngine.h"

@interface Settings : CCLayer<AbstractScene>{
    TransitionManagerSingleton * transitionManagerSingleton;
        MusicManagerSingleton* musicManagerSingleton;
}

@end
