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
    
    
}


- (void)setHEALTH:(int)reduceHealth{
 
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
