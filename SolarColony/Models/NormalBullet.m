//
//  NormalBullet.m
//  SolarColony
//
//  Created by Student on 2/26/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "NormalBullet.h"

@implementation NormalBullet
{
    CCSprite* towerSprite;
    
    double gravity ; // metres per second square
    double X ;
    double Y;
    double V0 ;// meters per second -- elevation
    double VX0; // meters per second
    double VY0; // meters per second
    float angle;
}
@synthesize bulletLocation;
@synthesize targetLocation;
@synthesize gametime;
@synthesize initBulletLocation;
- (NormalBullet*) initTower:(CGPoint)location{
    
    self = [super init];
    if (!self) return(nil);
    
    towerSprite = [CCSprite spriteWithFile:@"bulletA.gif"];
    [self setLocation:location];
    bulletLocation=ccp(0,0);
    initBulletLocation=bulletLocation;
    [self addChild:towerSprite];
    
    
    
    
    gravity = 19.8; // metres per second square
    X = 0;
    Y = 0;
    V0 = 50; // meters per second -- elevation
    VX0 = V0 * cos(angle); // meters per second
    VY0 = V0 * sin(angle); // meters per second
    gametime=0.0;
    return self;
}

-(void)startAttackTarget{
    //calculate initial angles velocities
   // float angleRadians = atan2(initBulletLocation.x - 00, initBulletLocation.y -   0);
    float angleRadians = atan2(targetLocation.x-initBulletLocation.x , targetLocation.x-initBulletLocation.y );
    float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
    angle = -1 * angleDegrees;
    CCLOG(@"ANGLE RADIANS %f",angleDegrees);
    angle = angleDegrees;
    bulletLocation=initBulletLocation;
    //2) call folow target
    
    
    
    
    //bezier test
    
    //
    
    
    
    
    [self schedule: @selector(followTarget:) interval:1/60];
}
-(void) decreaseSpeed{
    
}

- (void)followTarget:(ccTime)delta{
    
    //if ((targetLocation.x==bulletLocation.x)&&(targetLocation.y==bulletLocation.y)) {
   // if ((targetLocation.x<=bulletLocation.x)&&(targetLocation.y<=bulletLocation.y)) {
    if (((targetLocation.x>=bulletLocation.x-20&&targetLocation.x<=bulletLocation.x+20)&&(targetLocation.y>=bulletLocation.y-20&&targetLocation.y<=bulletLocation.y+20))
        /*||(bulletLocation.x<0||bulletLocation.y<0)*/){
        self.position = initBulletLocation;
        bulletLocation=initBulletLocation;
        gametime=0.0;
        [self unscheduleAllSelectors];
        
    }else{
        gametime += (delta*5);
        
        // x = v0 * t * cos(angle)
        bulletLocation.x = (V0 * gametime * cos(angle));
        
        // y = v0 * t * sin(angle) - 0.5 * g * t^2
        bulletLocation.y = -(V0 * gametime * sin(angle) - 0.5 * gravity * pow(gametime, 2));
        
        
        // bulletLocation.x+=10;
        
        //  bulletLocation.y+=10;
        
      //  CCLOG(@"coord x %f",bulletLocation.x);
      //  CCLOG(@"coord y %f",bulletLocation.y);
        //   X = (V0 * gameTime * cos(angle))/2+120;
        
        // y = v0 * t * sin(angle) - 0.5 * g * t^2
        //  Y = (V0 * gameTime * sin(angle) - 0.5 * gravity * pow(gameTime, 2))/2+255;
        
        
        self.position = bulletLocation;
        
        
        
    }
    
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

/*@synthesize bulletLocation;
@synthesize  initBulletLocation;
@synthesize  targetLocation;
@synthesize gametime;

- (NormalBullet*) initTower:(CGPoint)location{
    
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


- (void)followTarget:(ccTime)delta{
    
}
- (void)startAttackTarget{
    
}

@end*/
