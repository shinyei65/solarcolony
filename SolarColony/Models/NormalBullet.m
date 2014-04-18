//
//  NormalBullet.m
//  SolarColony
//
//  Created by Student on 2/26/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "NormalBullet.h"
#import "GameStatusEssentialsSingleton.h"
#import "TowerAttack.h"
@implementation NormalBullet
{
    CCSprite* towerSprite;
    GameStatusEssentialsSingleton * gameStatusEssentialsSingleton;
    double gravity ; // metres per second square
    double X ;
    double Y;
    double V0 ;// meters per second -- elevation
    double VX0; // meters per second
    double VY0; // meters per second
    float angle;
    CGPoint prev_loc;
}
@synthesize bulletLocation;
@synthesize targetLocation;
@synthesize gametime;
@synthesize initBulletLocation;
- (NormalBullet*) initTower:(CGPoint)location{
    
    self = [super init];
    if (!self) return(nil);
    gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];

    if ([[gameStatusEssentialsSingleton raceType] isEqualToString:@"Human"]) {
        towerSprite = [CCSprite spriteWithFile:@"bulletA.gif"];
    } else if ([[gameStatusEssentialsSingleton raceType] isEqualToString:@"Robot"]){
         towerSprite = [CCSprite spriteWithFile:@"angrybomb.png"];
    }else if ([[gameStatusEssentialsSingleton raceType] isEqualToString:@"Magic"]){
        towerSprite = [CCSprite spriteWithFile:@"goshty.png"];
    }
    
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
    //CCLOG(@"ANGLE RADIANS %f",angleDegrees);
    angle = angleDegrees;
    bulletLocation=initBulletLocation;
    //2) call folow target

    //bezier test
 
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


-(void) delegateRaceAttack{
    if ([[gameStatusEssentialsSingleton raceType] isEqualToString:@"Human"]) {
        [self animatonAttackhuman];
    } else if ([[gameStatusEssentialsSingleton raceType] isEqualToString:@"Robot"]){
        [self animatonAttackRobot];
    }else if ([[gameStatusEssentialsSingleton raceType] isEqualToString:@"Magic"]){
        [self animatonAttackWizard];
    }
}

-(void) endAttack{
    [self setPosition:prev_loc];
    TowerAttack *tower = (TowerAttack *) self.parent;
    [tower endAttack];
}

-(void) animatonAttackhuman
{
    // bla bla bla
    //   if (counterTest<=5) {
   // CCLOG(@"SHOTTING");
    //    counterTest++;
    //     if ([self numberOfRunningActions]==0) {
    [self setVisible:true];
    //   CCLOG(@"coord x %f",targetLocation.x);
    //  CCLOG(@"coord x %f",targetLocation.y);
    CGPoint targetLocations = [self convertToNodeSpace:targetLocation];
    //   CCLOG(@"coord x %f",targetLocations.x);
    //   CCLOG(@"coord x %f",targetLocations.y);
    CGPoint targetPrevious = [self position];
    //   id appearAction = [CCFadeIn actionWithDuration:.1];
    // id disappearAction = [CCFadeOut actionWithDuration:.1];
    id movePoint = [CCMoveTo actionWithDuration:.1 position:targetLocations];
    prev_loc = targetPrevious;
    id returnPoint = [CCCallFunc actionWithTarget:self selector:@selector(endAttack)];
    
    [self runAction:[CCSequence actions: movePoint,returnPoint,nil]];
    
}

-(void) animatonAttackRobot
{
    // bla bla bla
    //   if (counterTest<=5) {
   // CCLOG(@"SHOTTING");
    //    counterTest++;
    //     if ([self numberOfRunningActions]==0) {
    [self setVisible:true];
    //   CCLOG(@"coord x %f",targetLocation.x);
    //  CCLOG(@"coord x %f",targetLocation.y);
    CGPoint targetLocations = [self convertToNodeSpace:targetLocation];
    //   CCLOG(@"coord x %f",targetLocations.x);
    //   CCLOG(@"coord x %f",targetLocations.y);
    CGPoint targetPrevious = self.initBulletLocation;
    //   id appearAction = [CCFadeIn actionWithDuration:.1];
    // id disappearAction = [CCFadeOut actionWithDuration:.1];
    id movePoint = [CCMoveTo actionWithDuration:.1 position:targetLocations];
    prev_loc = targetPrevious;
    id returnPoint = [CCCallFunc actionWithTarget:self selector:@selector(endAttack)];
    
   
    ccBezierConfig bezier;
    bezier.controlPoint_1 = ccp(targetPrevious.x*.25, targetPrevious.y*.75);
    //   bezier.controlPoint_2 = ccp(targetPrevious.x*.5, targetLocations.y*.5);
    bezier.controlPoint_2 = ccp(targetPrevious.x*.75, targetLocations.y*.25);
    bezier.endPosition = ccp(targetLocations.x,targetLocations.y);
    CCBezierTo *bezierAction = [CCBezierTo actionWithDuration:1 bezier:bezier];
    
    [self runAction:[CCSequence actions:bezierAction,returnPoint,nil]];
    
 
    
}
-(void) animatonAttackWizard
{
    // bla bla bla
    //   if (counterTest<=5) {
   // CCLOG(@"SHOTTING");
    //    counterTest++;
    //     if ([self numberOfRunningActions]==0) {
    [self setVisible:true];
    //   CCLOG(@"coord x %f",targetLocation.x);
    //  CCLOG(@"coord x %f",targetLocation.y);
    CGPoint targetLocations = [self convertToNodeSpace:targetLocation];
    //   CCLOG(@"coord x %f",targetLocations.x);
    //   CCLOG(@"coord x %f",targetLocations.y);
    CGPoint targetPrevious = [self position];
    //   id appearAction = [CCFadeIn actionWithDuration:.1];
    // id disappearAction = [CCFadeOut actionWithDuration:.1];
    id movePoint = [CCMoveTo actionWithDuration:.1 position:targetLocations];
    prev_loc = ccp(targetLocations.x*((1)*0.1)  ,targetLocations.y*((1)*0.1));
    id returnPoint = [CCCallFunc actionWithTarget:self selector:@selector(endAttack)];
    //id returnPoint = [CCMoveTo actionWithDuration:.01 position:ccp(targetLocations.x*((1)*0.1)  ,targetLocations.y*((1)*0.1))];
    
    
     ccBezierConfig bezier;
     bezier.controlPoint_1 = ccp(targetPrevious.x*1.5, targetPrevious.y);
     bezier.controlPoint_2 = ccp(targetPrevious.x, targetLocations.y*1.2);
     bezier.endPosition = ccp(targetLocations.x,targetLocations.y);
     CCBezierTo *bezierAction = [CCBezierTo actionWithDuration:2 bezier:bezier];
    
  /*  ccBezierConfig bezier;
    bezier.controlPoint_1 = ccp(targetLocations.x*.05, targetLocations.y*.75);
    //   bezier.controlPoint_2 = ccp(targetPrevious.x*.5, targetLocations.y*.5);
    bezier.controlPoint_2 = ccp(targetLocations.x*.75, targetLocations.y*.85);
    bezier.endPosition = ccp(targetLocations.x,targetLocations.y);
    CCBezierTo *bezierAction = [CCBezierTo actionWithDuration:.4 bezier:bezier];*/
    
    [self runAction:[CCSequence actions:bezierAction,returnPoint,nil]];

   
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
