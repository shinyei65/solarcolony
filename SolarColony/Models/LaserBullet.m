//
//  LaserBullet.m
//  SolarColony
//
//  Created by Student on 4/26/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "LaserBullet.h"

@implementation LaserBullet{
    double gravity ; // metres per second square
    double X ;
    double Y;
    double V0 ;// meters per second -- elevation
    double VX0; // meters per second
    double VY0; // meters per second
    float angle;
    CGPoint prev_loc;
    bool isRightdirection;
    int numberOfDraw;
}

@synthesize bulletLocation;
@synthesize targetLocation;
@synthesize gametime;
@synthesize initBulletLocation;

- (LaserBullet*) initTower:(CGPoint)location{
    
    self = [super init];
    if (!self) return(nil);
    
    //[self setLocation:location];
    numberOfDraw = 0;
    bulletLocation = location;
    bulletLocation=ccp(0,0);
    initBulletLocation=bulletLocation;
    gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
    gravity = 19.8; // metres per second square
    X = 0;
    Y = 0;
    V0 = 50; // meters per second -- elevation
    VX0 = V0 * cos(angle); // meters per second
    VY0 = V0 * sin(angle); // meters per second
    gametime=0.0;
    return self;
}

-(void) delegateRaceAttack{
    [self setVisible:true];
    CGPoint targetLocations = [self convertToNodeSpace:targetLocation];
    //   CCLOG(@"coord x %f",targetLocations.x);
    //   CCLOG(@"coord x %f",targetLocations.y);
    CGPoint targetPrevious = self.initBulletLocation;
    
    prev_loc = targetPrevious;
    //id startAttack = [CCCallFunc actionWithTarget:<#(id)#> selector:<#(SEL)#>];
    id returnPoint = [CCCallFunc actionWithTarget:self selector:@selector(endAttack)];  
    
    [self setUpshootDirection:targetLocation];
    
}

-(void) setUpshootDirection:(CGPoint)targetLocations  {
    CGPoint originPoint = CGPointMake(targetLocations.x - prev_loc.x, targetLocations.y - prev_loc.y); // get origin point to origin by subtracting end from start
    float bearingRadians = atan2f(originPoint.y, originPoint.x); // get bearing in radians
    float bearingDegrees = bearingRadians * (180.0 / M_PI); // convert to degrees
    // bearingDegrees = (bearingDegrees > 0.0 ? bearingDegrees : (360.0 + bearingDegrees)); // correct discontinuity
    // CCLOG(@"ANGLE RADIANS %f",bearingRadians);
    
    if ((bearingDegrees>=270.0&&bearingDegrees<359)||(bearingDegrees>=0.0&&bearingDegrees<20)) {
        isRightdirection=true;
    } else {
        isRightdirection=false;
    }
    
}

-(bool) getBulletDirection{
    return isRightdirection;
}

-(void) endAttack{
    [self setPosition:prev_loc];
    TowerAttack *tower = (TowerAttack *) self.parent;
    [tower endAttack];
}

-(void)draw{
    [super draw];
    // set line width
    if (numberOfDraw > 3) {
        numberOfDraw = 0;
        [self endAttack];
    }
    glLineWidth(12.0f);
    
    // set line color.
    ccDrawColor4F(1.0, 0.0, 0.0, 1.0);
    
    // draw line from a vector to other vector.
    CGPoint targetLocations = [self convertToNodeSpace:targetLocation];
    //   CCLOG(@"coord x %f",targetLocations.x);
    //   CCLOG(@"coord x %f",targetLocations.y);
    CGPoint targetPrevious = self.initBulletLocation;
    CGPoint temptarget;
    
    if (targetLocations.x < targetPrevious.x) {
        temptarget.x = -480;
        temptarget.y = ((targetPrevious.y-targetLocations.y)/(targetPrevious.x-targetLocations.x))*(temptarget.x-targetLocations.x)+targetLocations.y;
    }
    else{
        temptarget.x = 480;
        temptarget.y = ((targetLocations.y-targetPrevious.y)/(targetLocations.x-targetPrevious.x))*(temptarget.x-targetPrevious.x)+targetPrevious.y;
    }
    //temptarget = ccp(0,0);
    ccDrawLine(temptarget,targetPrevious);
    glLineWidth(1.0f);
    ccDrawColor4F(1.0, 1.0, 1.0, 1.0);
    numberOfDraw ++;
}

@end
