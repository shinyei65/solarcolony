//
//  TowerDestroyer.h
//  SolarColony
//
//  Created by Student on 2/17/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "Tower.h"
#import "NormalBullet.h"
#import "LaserBullet.h"
#import "GameStatusEssentialsSingleton.h"
#import "MusicManagerSingleton.h"
#import "TowerGeneric.h"
 @interface TowerAttack : TowerGeneric{
    int counterTest;
    NormalBullet* bullet;
    id movePoint, returnPoint ;
    GameStatusEssentialsSingleton* gameStatusEssentialsSingleton;
    CCProgressTimer *timeBar;
    int counter;
    CCSprite* towerSprite;
     int towerType;
    MusicManagerSingleton *musicManagerSingleton;
    CCMenu *mainMenuUpgrade;
   // CCSprite* healedSprite;
}
-(void) endAttack;
@property(assign, atomic) CGPoint targetLocation;
@property(assign, atomic) CGPoint selfLocation;

@end
