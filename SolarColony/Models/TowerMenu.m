//
//  TowerMenu.m
//  SolarColony
//
//  Created by charles on 2/11/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "TowerMenu.h"
#import "CCMenu+Layout.h"


@implementation TowerMenu
{
    CGPoint location;
    CGPoint mapLoc;
}

#pragma mark - Create and Destroy

+ (instancetype) menu
{
    return [[self alloc] init];
}

- (instancetype) init
{
    self = [super init];
    if (!self) return(nil);
   
    
    CCMenuItemFont *item1=[CCMenuItemFont itemWithString:@"A" target:self selector:@selector(createTowerofType:)];
    [self addChild:item1];
    CCMenuItemFont *item2=[CCMenuItemFont itemWithString:@"B" target:self selector:@selector(createTowerofType:)];
    [self addChild:item2];
    CCMenuItemFont *item3=[CCMenuItemFont itemWithString:@"C" target:self selector:@selector(createTowerofType:)];
    [self addChild:item3];
    CCMenuItemFont *item4=[CCMenuItemFont itemWithString:@"D" target:self selector:@selector(createTowerofType:)];
    [self addChild:item4];
    CCMenuItemFont *item5=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(createTowerofType:)];
    [self addChild:item5];
    CCMenuItemFont *item6=[CCMenuItemFont itemWithString:@"F" target:self selector:@selector(createTowerofType:)];
    [self addChild:item6];
    CCMenuItemFont *item7=[CCMenuItemFont itemWithString:@"G" target:self selector:@selector(createTowerofType:)];
    [self addChild:item7];
    CCMenuItemFont *item8=[CCMenuItemFont itemWithString:@"H" target:self selector:@selector(createTowerofType:)];
    [self addChild:item8];
    CCMenuItemFont *item9=[CCMenuItemFont itemWithString:@"I" target:self selector:@selector(createTowerofType:)];
    [self addChild:item9];
    
    [self alignItemsInGridWithPadding:ccp(5, 5) columns:3];
    
    location=ccp(0,0);
    mapLoc = ccp(0,0);
    
      /* NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserverForName:nil
                        object:nil
                         queue:nil
                    usingBlock:^(NSNotification *notification)
    {
        NSLog(@"%@", notification.name);
    }];*/
    
    
    return self;
}

- (void) setMapLocation: (CGPoint) index
{
    mapLoc = index;
}
- (CGPoint) getMapLocation
{
    return mapLoc;
}

//creates nsnotification object, which is used to provide observer patter, so when the menu is clicke all register observers will recieve that a new tower must be created

- (void) createTowerofType:(id) towerType{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)towerType;
    location=self.position;
    CCLOG(@"End location.x %f", location.x);   //I just get location.x = 0
    CCLOG(@"End location.y %f", location.y);   //I just get location.y = 0
    
    //NSString *myPoint = NSStringFromCGPoint(menuItem.position);
    
   // NSDictionary *userInfo =    [NSDictionary dictionaryWithObjectsAndKeys:myPoint,@"point", nil];
    
    if ([menuItem.label.string isEqualToString:@"A"]) {
        NSDictionary *userInfo =    [NSDictionary dictionaryWithObjectsAndKeys:@"TowerA",@"point", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TowerOption" object:self userInfo:userInfo];
        
    } else if ([menuItem.label.string isEqualToString:@"B"])  {
         NSDictionary *userInfo =    [NSDictionary dictionaryWithObjectsAndKeys:@"TowerB",@"point", nil];
       // [[NSNotificationCenter defaultCenter] postNotificationName:@"TowerDestroyer" object:towerLocation];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TowerOption" object:self userInfo:userInfo];
    }
    
}



@end
