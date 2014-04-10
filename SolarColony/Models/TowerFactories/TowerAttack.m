//
//  TowerDestroyer.m
//  SolarColony
//
//  Created by Student on 2/17/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "TowerAttack.h"

@implementation TowerAttack
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
@synthesize towerPrice;
@synthesize towerReward;

- (instancetype) initTower:(CGPoint)location Race: (NSString*) raceType Life: (int) health Price: (int) price Reward: (int) reward Attspeed: (int) attspeed Power: (int) power{
    
    self = [super init];
    if (!self) return(nil);
    
    //Game status global variables
    gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
    
    if ([raceType isEqualToString:@"Human"]) {
        
        towerSprite = [CCSprite spriteWithFile:@"towerB.png"];
        towerSprite_hp = [CCSprite spriteWithFile:@"blood_full.jpg"];
        towerSprite_hp.position = ccp(0, 15);
       // [towerSprite setAnchorPoint:ccp(.8, 0.5)];
        towerTowerId=2;
        selfLocation=location;
        [self setLocation:location];
        [self setLife:health];
        [self setPower:power];
        towerPrice = price;
        towerReward = reward;
        //[self setSetSpeedAttack:20];
        [self setSetSpeedAttack:attspeed];
        [self setIsAttacking:false];
        isDeath=false;
        bullet = [[ NormalBullet alloc] initTower:location];
        isCharging=false;
        [self setPosition:[self getLocation]];

    }if ([raceType isEqualToString:@"Robot"]) {
        
        towerSprite = [CCSprite spriteWithFile:@"towerB.png"];
        towerSprite_hp = [CCSprite spriteWithFile:@"blood_full.jpg"];
        towerSprite_hp.position = ccp(0, 15);
        towerTowerId=2;
        selfLocation=location;
        [self setLocation:location];
        [self setLife:100];
        [self setPower:power];
        [self setSetSpeedAttack:20];
        [self setSetSpeedAttack:50];
        [self setIsAttacking:false];
        isDeath=false;
        bullet = [[ NormalBullet alloc] initTower:location];
        isCharging=false;
     
        [self setPosition:[self getLocation]];

    }if ([raceType isEqualToString:@"Magic"]) {
        
        towerSprite = [CCSprite spriteWithFile:@"towerB.png"];
        towerSprite_hp = [CCSprite spriteWithFile:@"blood_full.jpg"];
        towerSprite_hp.position = ccp(0, 15);
        towerTowerId=2;
        selfLocation=location;
        [self setLocation:location];
        [self setLife:100];
        [self setPower:power];
        [self setSetSpeedAttack:20];
        [self setSetSpeedAttack:50];
        [self setIsAttacking:false];

        isDeath=false;
        bullet = [[ NormalBullet alloc] initTower:location];
        isCharging=false;
  
        [self setPosition:[self getLocation]];

    }
    whichRace=raceType;
    health=100;
    [self addChild:towerSprite];
    
    [self addChild:bullet];
    [self addChild:towerSprite_hp z:100];
    return self;
}

-(CGRect) getBoundingBoxTower{
    CGRect originTower;
    originTower.origin=ccp(towerLocation.x-5, towerLocation.y-5);
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
    //  [self schedule: @selector(animatonAttack:) interval:1];
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

-(void) reloadAnimation
{
    
    if (isCharging==false) {
        isCharging=true;
        CCProgressFromTo *to1 = [CCProgressFromTo actionWithDuration:1 from:100 to:0];
        CCSprite* progressSprite = [CCSprite spriteWithFile:@"towerBcharge.png"];
        timeBar = [CCProgressTimer progressWithSprite:progressSprite];
        //[timeBar setAnchorPoint:ccp(.8, 0.5)];
        counter=0;
        [self addChild:timeBar];
        [timeBar runAction:to1];
        [self schedule: @selector(doNothingCharge:) interval:.3];
    }
    
}

-(void) doNothingCharge: (ccTime) dt{

    //NSLog(@" waitting to charge %d", counter);
    
    if (counter > 1) {
       // NSLog(@"stopped 1st scheduler");
        isCharging=false;
        counter=0;
        [self unschedule:@selector(doNothingCharge:)];
    }else{
         counter++;
    }
 
}


-(void)beignattacked{
    
    if ([self getLife]<=0) {
        isDeath=true;
    }else{
       [self setLife:([self getLife]-10)];
        [self setHEALTH:-10];
    }
}

-(void)beignHealed{    
  
        [self setLife:([self getLife]+30)];
        [self setHEALTH:100];
    
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
- (void)setHEALTH:(int)reduceHealth{
    
    if (towerLife <= health*3/4 && towerLife > health*1/2) {
        //CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"blood_3:4.jpg"];
        [towerSprite_hp setTexture:[[CCSprite spriteWithFile:@"blood_3:4.jpg"]texture]];
    }
    if (towerLife <= health*1/2 && towerLife > health*1/4) {
        [towerSprite_hp setTexture:[[CCSprite spriteWithFile:@"blood_half.jpg"]texture]];
    }
    if (towerLife <= health*1/4 && towerLife > health*1/10) {
        [towerSprite_hp setTexture:[[CCSprite spriteWithFile:@"blood_1:4.jpg"]texture]];
    }
    if (towerLife <= health*1/10 && towerLife > health*1/20) {
        [towerSprite_hp setTexture:[[CCSprite spriteWithFile:@"blood_empty.jpg"]texture]];
    }
   
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
