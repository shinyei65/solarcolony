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
@synthesize towerReward;
- (instancetype) initTower:(CGPoint)location Race: (NSString*) raceType Reward: (int) reward Life: (int) health{
    
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
        [self setLife:health];
        [self setPower:10];
        [self setSetSpeedAttack:20];
        [self setSetSpeedAttack:10];
        [self setIsAttacking:false];
        towerReward = reward;
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
        [self setLife:health];
        [self setPower:10];
        [self setSetSpeedAttack:20];
        [self setSetSpeedAttack:10];
        [self setIsAttacking:false];
        towerReward = reward;
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
        [self setLife:health];
        [self setPower:10];
        [self setSetSpeedAttack:20];
        [self setSetSpeedAttack:10];
        [self setIsAttacking:false];
        towerReward = reward;
        //bullet= [CCSprite spriteWithFile:@"bulletA.png"];
        isDeath=false;
        bullet = [[ NormalBullet alloc] initTower:location];
 
        
    }
    _health=health;
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

- (void) attackTest:(CGPoint) soldier Target:(Soldier*) target{
      [self reloadAnimation];
    
}

-(void) reloadAnimation
{
    
    if (isCharging==false) {
        isCharging=true;
        //NSLog(@"SPEED = %g", (float)towerSpeed/60);
        CCProgressFromTo *to1 = [CCProgressFromTo actionWithDuration:10 from:100 to:0];
        CCSprite* progressSprite = [CCSprite spriteWithFile:@"towerAcharge.png"];
        timeBar = [CCProgressTimer progressWithSprite:progressSprite];
        //[timeBar setAnchorPoint:ccp(.8, 0.5)];
        counter=0;
        [self addChild:timeBar];
        [timeBar runAction:to1];
        [self schedule: @selector(doNothingCharge:) interval:10];//(float)towerSpeed/60];
    }
    
}

-(void) doNothingCharge: (ccTime) dt{
    
    NSLog(@" waitting to charge %d", counter);
    
    // if (counter > 1) {
    // NSLog(@"stopped 1st scheduler");
    isCharging=false;
    counter=0;
    [self unschedule:@selector(doNothingCharge:)];
    // }else{
    //      counter++;
    // }
    
}

-(void)beignattacked:(int) attack_power{
    
    if ([self getLife]<=0) {
        isDeath=true;
    }else{
        [self setLife:([self getLife]-attack_power)];
        [self setHEALTH:-attack_power];
    }
}

-(void)beignHealed{
    
    [self setLife:_health];
    [self setHEALTH:200];
    
}
- (void)setHEALTH:(int)reduceHealth{
    if (towerLife > _health*3/4) {
        [towerSprite_hp setTexture:[[CCSprite spriteWithFile:@"blood_full.jpg"]texture]];
    }
    if (towerLife <= _health*3/4 && towerLife > _health*1/2) {
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
