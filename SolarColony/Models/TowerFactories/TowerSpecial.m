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

//@synthesize towerLife;
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
@synthesize towerPrice;

- (instancetype) initTower:(CGPoint)location  Race: (NSString*) raceType Reward: (int) reward Life: (int) health  Price:(int) price Attspeed:(int) speed
{
    
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
        [self setSetSpeedAttack:speed];
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
        [self setLife:health];
        [self setPower:10];
        [self setSetSpeedAttack:speed];
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
        [self setLife:health];
        [self setPower:10];
        [self setSetSpeedAttack:speed];
        [self setIsAttacking:false];
 
        //bullet= [CCSprite spriteWithFile:@"bulletA.png"];
        isDeath=false;
        bullet = [[ NormalBullet alloc] initTower:location];
 
        
    }
    towerPrice = price;
    towerReward= reward;
    _health=health;
    whichRace=raceType;
    
    //healed turret sprite
    healedSprite = [CCSprite spriteWithFile:@"healedTurrets.png"];
    healedSprite.position = ccp(0, 5);
    //[reward setVisible:false];
    healedSprite.opacity=0;
    [self addChild:healedSprite];
    
    
    [self loadMenuUpgrade];
    [self setPosition:[self getLocation]];
    [bullet setVisible:FALSE];
    [self addChild:bullet];
    [self addChild:towerSprite];
    [self addChild:towerSprite_hp z:100];
    

    
    
    return self;
}

-(void) setMenuUpgradeVisible:(bool) state{
    [mainMenuUpgrade setVisible:state];
}

- (void)loadMenuUpgrade
{
    CCMenuItemImage *manuItemUpgrade=[CCMenuItemImage itemWithNormalImage:@"upgradev2.png" selectedImage:@"upgradev2on.png" target:self selector:@selector(upgradeTowerPower)];
    
    
    CCMenuItemFont *manuItemUpgradeText=[CCMenuItemFont itemWithString:[NSString stringWithFormat:@"-%d Upgrade",towerPrice] target:self selector:nil];
    
    [manuItemUpgradeText setFontSize:10];
    
    [manuItemUpgradeText setColor:ccGREEN];
 
    mainMenuUpgrade=[CCMenu menuWithItems:manuItemUpgrade,manuItemUpgradeText, nil];
    
    [mainMenuUpgrade alignItemsVertically];
    
    [mainMenuUpgrade setPosition:ccp( 40, 0)];
    
    [mainMenuUpgrade setVisible:false];
    
    [self addChild:mainMenuUpgrade];
    
    
}

-(void) upgradeTowerPower{
    //reduce money
    [[PlayerInfo Player] setResource:([[PlayerInfo Player] getResource]-towerPrice)];
    [self setPower:[self getPower]+10];
    [mainMenuUpgrade setVisible:false];
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
    
   // NSLog(@" waitting to charge %d", counter);
    
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
}

-(void)dealloc{
    [super dealloc];
}
@end
