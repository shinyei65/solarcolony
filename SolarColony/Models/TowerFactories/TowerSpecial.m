//
//  TowerMagic.m
//  SolarColony
//
//  Created by Student on 2/18/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "TowerSpecial.h"

@implementation TowerSpecial
@synthesize  targetLocation;
@synthesize towerTowerId;

@synthesize towerLife;
@synthesize towerPower;
@synthesize towerLocation;
@synthesize towerSpeed;
@synthesize towerActiveRadius;
@synthesize isAttacking;
@synthesize selfLocation;
@synthesize isCharging;
@synthesize isDeath;
@synthesize whichRace;

- (instancetype) initTower:(CGPoint)location Race: (NSString*) raceType{
    
    self = [super init];
    if (!self) return(nil);

    
    if ([raceType isEqualToString:@"Human"]) {
        towerSprite = [CCSprite spriteWithFile:@"towerA.png"];
        [towerSprite setAnchorPoint:ccp(0.5,0.5)];
        //[self setLocation:ccp(200,200)];
        [self setLocation:location];
        towerTowerId=4;
        selfLocation=location;
        [self setLife:200];
        [self setPower:10];
        [self setSetSpeedAttack:20];
        [self setSetSpeedAttack:10];
        [self setIsAttacking:false];
        
        //bullet= [CCSprite spriteWithFile:@"bulletA.png"];
        isDeath=false;
        bullet = [[ NormalBullet alloc] initTower:location];

        
    }if ([raceType isEqualToString:@"Robot"]) {
        
        towerSprite = [CCSprite spriteWithFile:@"towerA.png"];
        [towerSprite setAnchorPoint:ccp(0.5,0.5)];
        //[self setLocation:ccp(200,200)];
        [self setLocation:location];
        towerTowerId=4;
        selfLocation=location;
        [self setLife:200];
        [self setPower:10];
        [self setSetSpeedAttack:20];
        [self setSetSpeedAttack:10];
        [self setIsAttacking:false];
        
        //bullet= [CCSprite spriteWithFile:@"bulletA.png"];
        isDeath=false;
        bullet = [[ NormalBullet alloc] initTower:location];
 
    }if ([raceType isEqualToString:@"Magic"]) {
        
        towerSprite = [CCSprite spriteWithFile:@"towerA.png"];
        [towerSprite setAnchorPoint:ccp(0.5,0.5)];
        //[self setLocation:ccp(200,200)];
        [self setLocation:location];
        towerTowerId=4;
        selfLocation=location;
        [self setLife:200];
        [self setPower:10];
        [self setSetSpeedAttack:20];
        [self setSetSpeedAttack:10];
        [self setIsAttacking:false];
        
        //bullet= [CCSprite spriteWithFile:@"bulletA.png"];
        isDeath=false;
        bullet = [[ NormalBullet alloc] initTower:location];
 
        
    }
    whichRace=raceType;
    [self setPosition:[self getLocation]];
    [self addChild:bullet];
    [self addChild:towerSprite];
    

    
    
    return self;
}
-(CGRect) getBoundingBoxTower{
    CGRect originTower;
    originTower.origin=ccp(towerLocation.x-20, towerLocation.y-20);
    originTower.size.width=30;
    originTower.size.height=30;
    return originTower;
}
- (void) surveilance{
    
}
- (void) attack:(Soldier*) soldier{
    
}
- (void) attackTest:(CGPoint) soldier{
    
    [self setIsAttacking:true];
    targetLocation=soldier;
    bullet.targetLocation=soldier;
    [self schedule: @selector(animatonAttackTest:) interval:1];

    
}

-(void) animatonAttackTest: (ccTime) dt
{
  //  bullet.targetLocation=soldier;
    [bullet delegateRaceAttack];
    [self unscheduleAllSelectors];
    [self setIsAttacking:false];
}

-(void)beignattacked{
    
    if ([self getLife]<=0) {
        isDeath=true;
    }else{
        [self setLife:([self getLife]-10)];
    }
}

-(bool) getIsattacking{
    
    return nil;
}
-(void) setIsattacking:(bool) attack{
    
}

-(CCMenu*)loadMenu{
    
    return nil;
}

-(void) setPower:(int) power{
    towerPower=power;
}

-(int) getPower{
    return towerPower;
}

-(void) setLife:(int) life{
    towerLife=life;
}

-(int) getLife{
    return towerLife;
}

-(void) setSetSpeedAttack:(int) speed{
    towerSpeed=speed;
}

-(int) getSetSpeedAttack{
    return nil;
}

-(void) setClosesTarget:(Soldier*) soldier{}

-(Soldier*) getClosesTarget{
    return nil;
}

-(void) setLocation:(CGPoint) location{
    towerLocation=location;
}
-(CGPoint) getLocation{
    return towerLocation;
}

-(void) destroyedAnimation{}

-(void)beingAttacked:(int)attack_power{
}

-(void)dealloc{}
@end
