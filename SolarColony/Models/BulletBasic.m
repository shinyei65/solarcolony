//
//  BulletBasic.m
//  SolarColony
//
//  Created by Student on 2/14/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "BulletBasic.h"

@implementation BulletBasic
@synthesize bulletLocation;


- (instancetype) initTower:(CGPoint)location{
    
    self = [super init];
    if (!self) return(nil);
    
    CCSprite* towerSprite = [CCSprite spriteWithFile:@"bulletA.gif"];
    [self setLocation:location];
   
    [self addChild:towerSprite];

    return self;
}



-(void) setLocation:(CGPoint) location{
    bulletLocation=location;
}
-(CGPoint) getLocation{
    return bulletLocation;
}
-(void) appearSpriteBullet{
    id appearAction = [CCFadeIn actionWithDuration:.1];
    [self runAction:[CCSequence actions:appearAction,nil]];
}
-(void) disappearSpriteBullet{
    id disappearAction = [CCFadeOut actionWithDuration:.1];
    [self runAction:[CCSequence actions:disappearAction,nil]];
}
@end
