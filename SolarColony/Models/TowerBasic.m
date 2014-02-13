//
//  TowerBasic.m
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "TowerBasic.h"

@implementation TowerBasic
@synthesize towerTowerId;

@synthesize towerLife;
@synthesize towerPower;
@synthesize towerLocation;
@synthesize towerSpeed;
@synthesize towerActiveRadius;
@synthesize isAttacking;
@synthesize bullet;

- (instancetype) initTower:(CGPoint)location{
   
    self = [super init];
    if (!self) return(nil);
    
    CCSprite* towerSprite = [CCSprite spriteWithFile:@"towerA.png"];    
    [self setLocation:ccp(200,200)];
     //[self setLocation:location];
    [self setLife:100];
    [self setPower:10];
    [self setSetSpeedAttack:20];
    [self setSetSpeedAttack:50];
    [self setIsAttacking:false];
    
    bullet= [CCSprite spriteWithFile:@"bulletA.png"];
    [self setPosition:[self getLocation]];
    [self addChild:bullet];
    [self addChild:towerSprite];
     return self;
}

- (void) surveilance{
    
}
- (void) attack:(Soldier*) soldier{
    
}
- (void) attackTest:(CGPoint) soldier{
    
    id move = [CCMoveTo actionWithDuration:3 position:soldier];
    
    [bullet runAction:move];
    
}

-(bool) getIsattacking{
    
}
-(void) setIsattacking:(bool) attack{
    
}

-(CCMenu*)loadMenu{}

-(void) setPower:(int) power{
    towerPower=power;
}

-(int) getPower{}

-(void) setLife:(int) life{
    towerLife=life;
}

-(int) getLife{}

-(void) setSetSpeedAttack:(int) speed{
    towerSpeed=speed;
}

-(int) getSetSpeedAttack{}

-(void) setClosesTarget:(Soldier*) soldier{}

-(Soldier*) getClosesTarget{}

-(void) setLocation:(CGPoint) location{
    towerLocation=location;
}
-(CGPoint) getLocation{
    return towerLocation;
}

-(void) destroyedAnimation{}

-(void)dealloc{}
@end
