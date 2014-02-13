//
//  Tower.h
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "cocos2d.h"
#import "Soldier.h"
#import <GameKit/GameKit.h>
#import <UIKit/UIKit.h>

@protocol Tower 

    @required

    - (instancetype) initTower:(CGPoint)location;
    - (void) surveilance;
    - (void) attack:(Soldier*) soldier;
    - (void) attackTest:(CGPoint) soldier;

    -(CCMenu*)loadMenu;
    -(void) setPower:(int) power;
    -(int) getPower;
    -(void) setLife:(int) life;
    -(int) getLife;
    -(void) setSetSpeedAttack:(int) speed;
    -(int) getSetSpeedAttack;
    -(void) setClosesTarget:(Soldier*) soldier;
    -(Soldier*) getClosesTarget;
    -(void) setLocation:(CGPoint) location;
    -(CGPoint) getLocation;
    -(bool) getIsattacking;
    -(void) setIsattacking:(bool) attack;

    -(void) destroyedAnimation;

    -(void)dealloc;


    @optional
        -(int)dummyMethodForReference:(int) value;

    @property(assign, nonatomic) int towerTowerId;
    @property(assign, nonatomic) int towerLife;
    @property(assign, nonatomic) int towerPower;
    @property(assign, nonatomic) CGPoint towerLocation;
    @property(assign, nonatomic) int towerSpeed;
    @property(assign, nonatomic) int towerActiveRadius;
    @property(assign, nonatomic) bool isAttacking;
    @property(assign, nonatomic) CCSprite* bullet;


    @property  CGSize mobileDisplaySize;


@end
