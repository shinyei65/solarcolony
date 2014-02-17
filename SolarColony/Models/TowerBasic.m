//
//  TowerBasic.m
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "TowerBasic.h"

@implementation TowerBasic
@synthesize  targetLocation;
@synthesize towerTowerId;

@synthesize towerLife;
@synthesize towerPower;
@synthesize towerLocation;
@synthesize towerSpeed;
@synthesize towerActiveRadius;
@synthesize isAttacking;
 

- (instancetype) initTower:(CGPoint)location{
   
    self = [super init];
    if (!self) return(nil);
    
    CCSprite* towerSprite = [CCSprite spriteWithFile:@"towerA.png"];
    [towerSprite setAnchorPoint:ccp(0.5,0.5)];
    //[self setLocation:ccp(200,200)];
    [self setLocation:location];
    [self setLife:100];
    [self setPower:10];
    [self setSetSpeedAttack:20];
    [self setSetSpeedAttack:50];
    [self setIsAttacking:false];
    
    //bullet= [CCSprite spriteWithFile:@"bulletA.png"];
    
    bullet = [[ BulletBasic alloc] initTower:location];
    
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
    
    [self setIsAttacking:true];
    
  //
    targetLocation=soldier;
    [self schedule: @selector(animatonAttack:) interval:2];

    
  //
    

    
}

-(void) animatonAttack: (ccTime) dt
{
    // bla bla bla
    if (counterTest<=5) {
         CCLOG(@"SHOTTING");
        counterTest++;
            if ([self numberOfRunningActions]==0) {
                [bullet setVisible:true];
                CCLOG(@"coord x %f",targetLocation.x);
                CCLOG(@"coord x %f",targetLocation.y);
                CGPoint targetLocations = [self convertToNodeSpace:targetLocation];
                CCLOG(@"coord x %f",targetLocations.x);
                CCLOG(@"coord x %f",targetLocations.y);
                CGPoint targetPrevious = [bullet position];
             //   id appearAction = [CCFadeIn actionWithDuration:.1];
               // id disappearAction = [CCFadeOut actionWithDuration:.1];
                movePoint = [CCMoveTo actionWithDuration:.5 position:targetLocations];
                returnPoint = [CCMoveTo actionWithDuration:.01 position:targetPrevious];
              
                [bullet runAction:[CCSequence actions: movePoint,returnPoint,nil]];
                 
            }
      
        
    }else{
        counterTest=0;
        
        [self unscheduleAllSelectors];
        [self setIsAttacking:false];
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

-(void) setLife:(int) life{
    towerLife=life;
}

-(int) getLife{
return nil;
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

-(void)dealloc{}
@end
