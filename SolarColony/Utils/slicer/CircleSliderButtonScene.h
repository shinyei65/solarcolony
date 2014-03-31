//
//  CircleSliderButtonScene.h
//  ciricleSlideButton
//
//  Created by arjun prakash on 7/5/12.
//  Copyright 2012 CyborgDino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "CircleSliderButtonLayer.h"

@interface CircleSliderButtonScene : CCNode {
    
    
    CircleSliderButtonLayer *circleButton;
    
    CCMenuItem *onItem; 
    CCMenuItem *offItem;
    
    CGPoint location;
    CGPoint mapLoc;
    
    CCMenuItemToggle *selectItem00;
    CCMenuItemToggle *selectItem01;
    CCMenuItemToggle *selectItem02;
    CCMenuItemToggle *selectItemX;
    
    CCMenuItem *selectOn00;
    CCMenuItem *selectOff00;
    CCMenuItem *selectOn01;
    CCMenuItem *selectOff01;
    CCMenuItem *selectOn02;
    CCMenuItem *selectOff02;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
+ (instancetype) menu;
- (instancetype) init;
- (void) createTowerofType:(id) towerType;
- (void) setMapLocation: (CGPoint) index;
- (CGPoint) getMapLocation;
@end

