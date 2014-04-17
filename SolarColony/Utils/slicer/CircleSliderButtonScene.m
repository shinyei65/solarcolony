//
//  CircleSliderButtonScene.m
//  ciricleSlideButton
//
//  Created by arjun prakash on 7/5/12.
//  Copyright 2012 CyborgDino. All rights reserved.
//

#import "CircleSliderButtonScene.h"


@implementation CircleSliderButtonScene


+ (instancetype) menu
{
    return [[self alloc] init];
}

- (void) setMapLocation: (CGPoint) index
{
    mapLoc = index;
}
- (CGPoint) getMapLocation
{
    return mapLoc;
}

// on "init" you need to initialize your instance
-(id) init 
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        

        // creat objects and inits
        
        selectOn00 = [CCMenuItemImage itemWithNormalImage:@"select0.png"
                                                        selectedImage:@"select0.png" target:nil selector:nil];
        selectOff00 = [CCMenuItemImage itemWithNormalImage:@"select0Active.png"
                                                         selectedImage:@"select0Active.png" target:nil selector:nil];
        selectItem00 = [CCMenuItemToggle itemWithTarget:self
                                                               selector:@selector(selectButtonTapped:) items:selectOn00, selectOff00, nil];
        selectItem00.tag="0";
        
        
        selectOn01 = [CCMenuItemImage itemWithNormalImage:@"select1.png"
                                                        selectedImage:@"select1.png" target:nil selector:nil];
        selectOff01 = [CCMenuItemImage itemWithNormalImage:@"select1Active.png"
                                                         selectedImage:@"select1Active.png" target:nil selector:nil];
        selectItem01 = [CCMenuItemToggle itemWithTarget:self
                                                                 selector:@selector(selectButtonTapped:) items:selectOn01, selectOff01, nil];
        selectItem01.tag="1";
        
        selectOn02 = [CCMenuItemImage itemWithNormalImage:@"select2.png"
                                                        selectedImage:@"select2.png" target:nil selector:nil];
        selectOff02 = [CCMenuItemImage itemWithNormalImage:@"select2Active.png"
                                                         selectedImage:@"select2Active.png" target:nil selector:nil];
        selectItem02 = [CCMenuItemToggle itemWithTarget:self
                                                                 selector:@selector(selectButtonTapped:) items:selectOn02, selectOff02, nil];
        
        selectItem02.tag="2";
        selectOn03 = [CCMenuItemImage itemWithNormalImage:@"select3.png"
                                            selectedImage:@"select3.png" target:nil selector:nil];
        selectOff03 = [CCMenuItemImage itemWithNormalImage:@"select3Active.png"
                                             selectedImage:@"select3Active.png" target:nil selector:nil];
        selectItem03 = [CCMenuItemToggle itemWithTarget:self
                                               selector:@selector(selectButtonTapped:) items:selectOn03, selectOff03, nil];
    
        selectItem03.tag="3";
        
        circleButton = [[CircleSliderButtonLayer alloc] init];
        circleButton = [circleButton menuWithRaidus:60 andItems:selectItem00, selectItem01, selectItem02, selectItem03, nil];
        [self addChild:circleButton z:10];
        circleButton.position = ccp(0,0);
        [circleButton degreeRotation:60];

        
        // add ioButton    
        onItem = [[CCMenuItemImage itemWithNormalImage:@"ioButtonON.png"
                                            selectedImage:@"ioButtonON.png" target:nil selector:nil] retain];
        offItem = [[CCMenuItemImage itemWithNormalImage:@"ioButtonON.png"
                                             selectedImage:@"ioButtonON.png" target:nil selector:nil] retain];
        CCMenuItemToggle *toggleItem = [CCMenuItemToggle itemWithTarget:self 
                                                               selector:@selector(chipIOButtonTapped:) items:offItem, onItem, nil];
        
        CCMenu *toggleMenu = [CCMenu menuWithItems:toggleItem, nil];
        [self addChild:toggleMenu z:2];
        toggleMenu.anchorPoint = ccp(0, 0);
        toggleMenu.position = ccp(0,0);
        
            [circleButton openButtons];
	
	}
	return self;
}

- (void) selectButtonTapped:(id) towerType{
    CCMenuItemToggle* menuItem = (CCMenuItemToggle*)towerType;
    location=circleButton.position;
    CCLOG(@"End location.x %f", location.x);   //I just get location.x = 0
    CCLOG(@"End location.y %f", location.y);   //I just get location.y = 0
    CCLOG(@"End location.y %@", menuItem.selectedItem);
    
    if ((menuItem.selectedItem == selectOn00) || (menuItem.selectedItem == selectOff00)) {
        NSDictionary *userInfo =    [NSDictionary dictionaryWithObjectsAndKeys:@"TowerA",@"point", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TowerOption" object:self userInfo:userInfo];
        
    } else if ((menuItem.selectedItem == selectOn01) || (menuItem.selectedItem == selectOff01)) {
        NSDictionary *userInfo =    [NSDictionary dictionaryWithObjectsAndKeys:@"TowerB",@"point", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TowerOption" object:self userInfo:userInfo];
    }else if ((menuItem.selectedItem == selectOn02) || (menuItem.selectedItem == selectOff02)) {
        NSDictionary *userInfo =    [NSDictionary dictionaryWithObjectsAndKeys:@"TowerC",@"point", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TowerOption" object:self userInfo:userInfo];
    }else if ((menuItem.selectedItem == selectOn03) || (menuItem.selectedItem == selectOff03)) {
        NSDictionary *userInfo =    [NSDictionary dictionaryWithObjectsAndKeys:@"TowerD",@"point", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TowerOption" object:self userInfo:userInfo];
    }
    [menuItem  setSelectedIndex:0];
}
- (void) chipIOButtonTapped:(id)sender { 
    /*for (int i = 0; i < circleButton.items.count-1; i++) {
        CCMenuItemToggle *item = (CCMenuItemToggle *)[circleButton.items objectAtIndex:i];
        //[item setSelectedIndex:0];
    }
     CCLOG(@"WORKING IO");
    [circleButton openButtons];
*/

}

- (void)xButtonTapped:(id)sender {

    CCLOG(@"WORKING X");
    for (int i = 0; i < circleButton.items.count-1; i++) {
        CCMenuItemToggle *item = (CCMenuItemToggle *)[circleButton.items objectAtIndex:i];
        [item setSelectedIndex:0];
    }

}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
 
    [onItem release];
    [offItem release];
	// don't forget to call "super dealloc"
	[super dealloc];
}


@end
