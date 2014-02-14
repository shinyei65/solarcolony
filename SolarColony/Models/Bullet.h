//
//  Bullet.h
//  SolarColony
//
//  Created by Student on 2/14/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "cocos2d.h"
#import "Soldier.h"
#import <GameKit/GameKit.h>
#import <UIKit/UIKit.h>


@protocol Bullet  

@required

    -(void) setLocation:(CGPoint) location;
    -(CGPoint) getLocation;
    -(void) appearSpriteBullet;
    -(void) disappearSpriteBullet;


@optional
    -(int)dummyMethodForReference:(int) value;

@property  CGSize mobileDisplaySize;
 @property(assign, nonatomic) CGPoint bulletLocation;


@end
