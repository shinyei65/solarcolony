//
//  AbstractScene.h
//  SolarColony
//
//  Created by Student on 2/7/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "cocos2d.h"
#import "CCLayer.h"
#import <GameKit/GameKit.h>

@protocol  AbstractScene

    @required
        
        -(CCMenu*)loadMenu;
        -(void)moveToScene:(int)scene;
        -(void)dealloc;
        +(CCScene *) scene;

    @optional
        -(int)dummyMethodForReference:(int) value;

@property(assign, nonatomic) int layerId;
@property  CGSize mobileDisplaySize;

@end
