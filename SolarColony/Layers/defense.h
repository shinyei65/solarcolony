//
//  defense.h
//  SolarColony
//
//  Created by Student on 2/10/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "AbstractScene.h"
#import "WorldColissionsManager.h"

@interface defense : CCScene<AbstractScene>{
     WorldColissionsManager* colissionsManager;
}

+ (instancetype)scene;
- (instancetype)init;

@end
