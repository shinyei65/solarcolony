//
//  TowerBasic.m
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "TowerSupport.h"

@implementation TowerSupport
@synthesize  targetLocation;
@synthesize towerTowerId;

//@synthesize towerLife;
@synthesize towerPower;
@synthesize towerLocation;
@synthesize towerSpeed;
@synthesize towerActiveRadius;
@synthesize isAttacking;
@synthesize selfLocation;
@synthesize isCharging;
@synthesize isDeath;
@synthesize actionTowerLocation;
@synthesize whichRace;
@synthesize isDrop;
@synthesize mapLocation;
@synthesize towerPrice;
@synthesize towerReward;

- (instancetype) initTower:(CGPoint)location  Race: (NSString*) raceType Reward: (int) reward Life: (int) health   Price:(int) price{
   
    self = [super init];
    if (!self) return(nil);
    towerSpriteSelected = [CCSprite spriteWithFile:@"target.png"];
    [towerSpriteSelected setAnchorPoint:ccp(0.5,1.6)];
    [towerSpriteSelected setVisible:false];
    if ([raceType isEqualToString:@"Human"]) {
        towerSprite = [CCSprite spriteWithFile:@"Tower_cornCharge.gif"];
        [towerSprite setAnchorPoint:ccp(0.5,0.5)];
        towerSprite_hp = [CCSprite spriteWithFile:@"blood_full.jpg"];
        towerSprite_hp.position = ccp(0, 15);
        //[self setLocation:ccp(200,200)];
        [self setLocation:location];
        selfLocation=location;
        towerTowerId=9;
        [self setLife:health];
        [self setPower:20];
        [self setSetSpeedAttack:20];
        [self setSetSpeedAttack:10];
        [self setIsAttacking:false];
        towerPrice = price;
        towerReward= reward;
        isDeath=false;
        bullet = [[ NormalBullet alloc] initTower:location];

    }else if([raceType isEqualToString:@"Robot"]){
        
        towerSprite = [CCSprite spriteWithFile:@"Tower_corn.gif"];
        [towerSprite setAnchorPoint:ccp(0.5,0.5)];
        towerSprite_hp = [CCSprite spriteWithFile:@"blood_full.jpg"];
        towerSprite_hp.position = ccp(0, 15);
        [self setLocation:location];
        selfLocation=location;
        towerTowerId=3;
        [self setLife:health];
        [self setPower:20];
        [self setSetSpeedAttack:20];
        [self setSetSpeedAttack:10];
        [self setIsAttacking:false];
        towerPrice = price;
        towerReward= reward;
        isDeath=false;
        bullet = [[ NormalBullet alloc] initTower:location];
        

    }else if([raceType isEqualToString:@"Magic"]){
        
        towerSprite = [CCSprite spriteWithFile:@"Tower_cornCharge.gif"];
        [towerSprite setAnchorPoint:ccp(0.5,0.5)];
        towerSprite_hp = [CCSprite spriteWithFile:@"blood_full.jpg"];
        towerSprite_hp.position = ccp(0, 15);
        [self setLocation:location];
        selfLocation=location;
        towerTowerId=6;
        [self setLife:health];
        [self setPower:20];
        [self setSetSpeedAttack:20];
        [self setSetSpeedAttack:10];
        [self setIsAttacking:false];
        towerPrice = price;
        towerReward= reward;
        isDeath=false;
        bullet = [[ NormalBullet alloc] initTower:location];

    }
    [bullet setVisible:FALSE];
    actionTowerLocation=ccp(0, 0);
    _health = health;
    whichRace=raceType;
    isDrop=false;
    
    //healed turret sprite
    healedSprite = [CCSprite spriteWithFile:@"healedTurrets.png"];
    healedSprite.position = ccp(0, 5);
    //[reward setVisible:false];
    healedSprite.opacity=0;
    [self addChild:healedSprite];
    
    
    [self setPosition:[self getLocation]];
    [self addChild:towerSpriteSelected];
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

-(void) setReadySpecial:(bool) ready{
    readySpecial=ready;
}
-(bool) getReadySpecial{
    return readySpecial;
}

-(void) setMenuUpgradeVisible:(bool) state{
    
}
- (void)loadMenuUpgrade
{
    
    
    
}
-(void) upgradeTowerPower{
 
}
- (void) surveilance{
    
}
- (void) attack:(Soldier*) soldier{
    
}
- (void) attackTest:(CGPoint) soldier{
    
    [self setIsAttacking:true];

}

-(void) animatonAttackTest: (ccTime) dt
{
    
    [bullet delegateRaceAttack];
    [self unscheduleAllSelectors];
    [self setIsAttacking:false];
}

-(void)beignattacked:(int) attack_power{
    
    if ([self getLife]<=0) {
        isDeath=true;
    }else{
        [self setLife:([self getLife]-attack_power)];
        [self setHEALTH:-attack_power];
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
return nil;
}

/*-(void) setLife:(int) life{
    towerLife=life;
}

-(int) getLife{
return towerLife;
}*/

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
    
    if ([self getLife]<=0) {
        isDeath=true;
    }else{
        [self setLife:([self getLife]-attack_power)];
        [self setHEALTH:-attack_power];
    }
}

-(void) setActionTowerLocation:(CGPoint) Location{
    actionTowerLocation=Location;
    [towerSpriteSelected setVisible:true];
}
//for wizard
-(void)replaceOriginAction{
   // self.position=actionTowerLocation;
    self.position=[self convertToNodeSpace:actionTowerLocation];
    towerSprite.position=[self convertToNodeSpace:actionTowerLocation];
}

//for robots
-(int) HealOriginAction{
    return 100;
}

//for humans
-(int) empowerOriginAction{
    return  10;
}

//Race selector special acion
-(int) selectAction{
    [towerSpriteSelected setVisible:false];
    if([whichRace isEqualToString:@"Human"]){
        return [self empowerOriginAction];
    }else if([whichRace isEqualToString:@"Robot"]){
        [self replaceOriginAction];
        return 0;
    }else if([whichRace isEqualToString:@"Magic"]){
        return [self HealOriginAction];
    }
    
}

-(void)dealloc{}
@end
