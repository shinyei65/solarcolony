//
//  AttackScene.h
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "AbstractScene.h"
#import "NetWorkManager.h"
#import "NetWorkManager.h"


@interface AttackScene : CCLayer<AbstractScene>{
    TransitionManagerSingleton* transitionManagerSingleton;
    MusicManagerSingleton* musicManagerSingleton;
    NetWorkManager* networkManager;
    int army_num;
}
@end
