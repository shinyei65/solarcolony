//
//  AttackScene.h
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "AbstractScene.h"

@interface AttackScene : CCLayer<AbstractScene>{
    TransitionManagerSingleton* transitionManagerSingleton;
        MusicManagerSingleton* musicManagerSingleton;
}
@end
