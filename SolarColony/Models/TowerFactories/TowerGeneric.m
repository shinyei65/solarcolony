//
//  TowerGeneric.m
//  SolarColony
//
//  Created by Student on 4/6/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "TowerGeneric.h"


@implementation TowerGeneric
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
@synthesize mapLocation;

- (instancetype) initTower:(CGPoint)location Race: (NSString*) raceType Power: (int) power{
  return nil;
}

- (void) surveilance{
    
}
- (void) attack:(Soldier*) soldier{
    
}
- (void) attackTest:(CGPoint) soldier{
    
}

-(void) animatonAttackTest: (ccTime) dt
{

}

-(void) reloadAnimation
{
  
}

-(void) doNothingCharge: (ccTime) dt{
  
}


-(void)beignattacked{

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
 
}

-(int) getPower{
    return nil;
}

-(void) setLife:(int) life{
   
}

-(int) getLife{
    return nil;
}

-(void) setSetSpeedAttack:(int) speed{
    
}

-(int) getSetSpeedAttack{
    return nil;
}

-(void) setClosesTarget:(Soldier*) soldier{}

-(Soldier*) getClosesTarget{
    return nil;
}

-(void) setLocation:(CGPoint) location{
    

}
-(CGPoint) getLocation{
  return ccp(0,0);
}

-(void) destroyedAnimation{}

-(void)beingAttacked:(int)attack_power{

}
-(void) setActionTowerLocation:(CGPoint) Location{
    
}

-(void)beignHealed{
    
    
    CCFadeIn *fadeIn =  [CCFadeIn actionWithDuration:0.05];
    CCFadeOut *fadeOut= [CCFadeOut actionWithDuration:.05];
    //id move2 = [CCMoveTo actionWithDuration:moveTime position:[[GridMap map] convertMapIndexToCenterGL:ccp([self position].x, [self position].y+5)]];
    id move2 = [CCMoveTo actionWithDuration:1 position:ccp([healedSprite position].x, [healedSprite position].y+35)];
    [healedSprite runAction:[CCSequence actions:fadeIn,move2,fadeOut,nil]];
    
    [self setLife:_health];
    [self setHEALTH:100];
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

- (void) flipTower:(BOOL) flag
{
    towerSprite.flipX=flag;
}

-(void) setMenuUpgradeVisible:(bool) state{
  
}

- (void)loadMenuUpgrade
{
  
    
    
}
-(void) upgradeTowerPower{
 
}
-(void)dealloc{}
@end
