//
//  TowerBasic.h
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "Tower.h"
#import "NormalBullet.h"
#import "TowerGeneric.h"
@interface TowerSupport : TowerGeneric{
    int counterTest;
    NormalBullet* bullet;
    id movePoint, returnPoint ;
    //CCSprite* towerSprite;
    CCSprite* towerSpriteSelected;
    bool readySpecial;

}
-(void) setReadySpecial:(bool) ready;
-(bool) getReadySpecial;
@property(assign, atomic) CGPoint targetLocation;
@property(assign, atomic) CGPoint selfLocation;
@property(assign, nonatomic) CGPoint actionTowerLocation;
@property(assign, atomic) bool isDrop;
@end
