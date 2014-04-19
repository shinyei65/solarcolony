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
@synthesize mapLocation;

- (instancetype) initTower:(CGPoint)location Race: (NSString*) raceType{
    
    self = [super init];
    if (!self) return(nil);

    
    if ([raceType isEqualToString:@"Human"]) {
        towerSprite = [CCSprite spriteWithFile:@"towerA.png"];
        [towerSprite setAnchorPoint:ccp(0.5,0.5)];
        towerSprite_hp = [CCSprite spriteWithFile:@"blood_full.jpg"];
        towerSprite_hp.position = ccp(0, 15);
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
        towerSprite_hp = [CCSprite spriteWithFile:@"blood_full.jpg"];
        towerSprite_hp.position = ccp(0, 15);
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
        towerSprite_hp = [CCSprite spriteWithFile:@"blood_full.jpg"];
        towerSprite_hp.position = ccp(0, 15);
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
    _health=200;
    whichRace=raceType;
    [self setPosition:[self getLocation]];
    [bullet setVisible:FALSE];
    [self addChild:bullet];
    [self addChild:towerSprite];
    [self addChild:towerSprite_hp z:100];
    

    
    
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
        [self setLife:([self getLife]-1)];
        [self setHEALTH:-1];
    }
}

-(void)beignHealed{
    
    [self setLife:([self getLife]+200)];
    [self setHEALTH:200];
    
}
- (void)setHEALTH:(int)reduceHealth{
    
    if (towerLife <= _health*3/4 && towerLife > _health*1/2) {
        //CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"blood_3:4.jpg"];
        [towerSprite_hp setTexture:[[CCSprite spriteWithFile:@"blood_3:4.jpg"]texture]];
    }
    if (towerLife <= _health*1/2 && towerLife > _health*1/4) {
        [towerSprite_hp setTexture:[[CCSprite spriteWithFile:@"blood_half.jpg"]texture]];
    }
    if (towerLife <= _health*1/4 && towerLife > _health*1/10) {
        [towerSprite_hp setTexture:[[CCSprite spriteWithFile:@"blood_1:4.jpg"]texture]];
    }
    if (towerLife <= _health*1/10 && towerLife > _health*1/20) {
        [towerSprite_hp setTexture:[[CCSprite spriteWithFile:@"blood_empty.jpg"]texture]];
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

-(void)dealloc{
    [super dealloc];
}
@end
