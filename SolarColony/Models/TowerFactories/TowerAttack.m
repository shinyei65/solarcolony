//
//  TowerDestroyer.m
//  SolarColony
//
//  Created by Student on 2/17/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "TowerAttack.h"

@implementation TowerAttack {
    Soldier *attack_target;
}
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
@synthesize mapLocation;

- (instancetype) initTower:(CGPoint)location Race: (NSString*) raceType Life: (int) health Price: (int) price Reward: (int) reward Attspeed: (int) attspeed Power: (int) power TowerType:(int) typeT{
    
    self = [super init];
    if (!self) return(nil);
    
    //Game status global variables
    gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
    musicManagerSingleton = [MusicManagerSingleton shareSoundManager];
    
    towerType=typeT;
    
    if ([raceType isEqualToString:@"Human"]) {
        attack_target = nil;
        towerSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"attackTowerType%d.gif",towerType]];
        towerSprite_hp = [CCSprite spriteWithFile:@"blood_full.jpg"];
        towerSprite_hp.position = ccp(0, 15);
        // [towerSprite setAnchorPoint:ccp(.8, 0.5)];
        towerTowerId=2;
        selfLocation=location;
        [self setLocation:location];
        [self setLife:health];
        [self setPower:power];
        towerReward = reward;
        //[self setSetSpeedAttack:20];
        [self setSetSpeedAttack:attspeed];
        [self setIsAttacking:false];
        isDeath=false;
        bullet = [[ NormalBullet alloc] initTower:location];
        isCharging=false;
        [self setPosition:[self getLocation]];
        
    }if ([raceType isEqualToString:@"Robot"]) {
        
        towerSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"attackTowerType%d.gif",towerType]];
        towerSprite_hp = [CCSprite spriteWithFile:@"blood_full.jpg"];
        towerSprite_hp.position = ccp(0, 15);
        towerTowerId=2;
        selfLocation=location;
        [self setLocation:location];
        [self setLife:health];
        [self setPower:power];
        //[self setSetSpeedAttack:20];
        [self setSetSpeedAttack:attspeed];
        [self setIsAttacking:false];
        isDeath=false;
        if (towerType == 2)
            bullet = [[LaserBullet alloc] initTower:location];
        else
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
        [self setLife:health];
        [self setPower:power];
        //[self setSetSpeedAttack:20];
        [self setSetSpeedAttack:attspeed];
        [self setIsAttacking:false];
        
        isDeath=false;
        bullet = [[ NormalBullet alloc] initTower:location];
        isCharging=false;
        
        [self setPosition:[self getLocation]];
        
    }
    towerPrice = price;
    whichRace=raceType;
    _health=health;
    
    //healing sprite
    
    healedSprite = [CCSprite spriteWithFile:@"healedTurrets.png"];
    healedSprite.position = ccp(0, 5);
    //[reward setVisible:false];
    healedSprite.opacity=0;
    [self addChild:healedSprite];
    
    
    [self loadMenuUpgrade];
    [self addChild:towerSprite];
    [bullet setVisible:FALSE];
    [self addChild:bullet];
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
    int newscore= [[PlayerInfo Player] getResource]-200;
    
    if (newscore>0) {
        [[PlayerInfo Player] setResource:([[PlayerInfo Player] getResource]-200)];
        [self setPower:[self getPower]+5];
    }
    
    [mainMenuUpgrade setVisible:false];
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
- (void) attackTest:(CGPoint) soldier Target:(Soldier*) target{
    attack_target = target;
    [self setIsAttacking:true];
    targetLocation=soldier;
    [musicManagerSingleton playEffect:@"sound 9.wav"];
    //  [self schedule: @selector(animatonAttack:) interval:1];
    bullet.targetLocation=soldier;
    //[self schedule: @selector(animatonAttackTest:) interval:1];
    
    [self animatonAttackTest:.01];
    
}
-(void) endAttack
{
    if([[gameStatusEssentialsSingleton soldiers] count] > 0){
        if (towerType == 2) {
            for (Soldier* soldier in gameStatusEssentialsSingleton.soldiers) {
                if (![soldier visible]) {
                    continue;
                }
                
                CGPoint soldierpoint = [soldier getPOSITION];
                soldierpoint=[[GridMap map] convertMapIndexToGL:soldierpoint];
                int diff;
                
                diff = abs(((selfLocation.y-targetLocation.y)/(selfLocation.x-targetLocation.x))*(soldierpoint.x-targetLocation.x)+targetLocation.y - soldierpoint.y);
                
                if (diff < 10) {
                    [soldier beingAttacked:[self getPower]];
                }

                
            }
        }
        else
            [attack_target beingAttacked:[self getPower]];
    }
    attack_target = nil;
    [bullet setVisible:FALSE];
    [self setIsAttacking:false];
    [self reloadAnimation];
}

-(void) animatonAttackTest: (ccTime) dt
{
    
    [bullet setVisible:TRUE];
    [bullet delegateRaceAttack];
    //[self unscheduleAllSelectors];
    //[self setIsAttacking:false];
}

-(void) reloadAnimation
{
    
    if (isCharging==false) {
        isCharging=true;
        //NSLog(@"SPEED = %g", (float)towerSpeed/60);
        CCProgressFromTo *to1 = [CCProgressFromTo actionWithDuration:(float)towerSpeed/60 from:100 to:0];
        CCSprite* progressSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"attackTowerTypeCharge%d.gif",towerType]];
        if ([bullet getBulletDirection]) {
            towerSprite.flipX=true;
            progressSprite.flipX=true;
        }else{
            towerSprite.flipX=false;
            progressSprite.flipX=false;
        }
        
        timeBar = [CCProgressTimer progressWithSprite:progressSprite];
        
        counter=0;
        [self addChild:timeBar];
        [timeBar runAction:to1];
        [self schedule: @selector(doNothingCharge:) interval:(float)towerSpeed/60];
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

-(void)beignHealed{
    
    
    CCFadeIn *fadeIn =  [CCFadeIn actionWithDuration:0.05];
    CCFadeOut *fadeOut= [CCFadeOut actionWithDuration:.05];
    //id move2 = [CCMoveTo actionWithDuration:moveTime position:[[GridMap map] convertMapIndexToCenterGL:ccp([self position].x, [self position].y+5)]];
    id move2 = [CCMoveTo actionWithDuration:1 position:ccp([healedSprite position].x, [healedSprite position].y+35)];
    [healedSprite runAction:[CCSequence actions:fadeIn,move2,fadeOut,nil]];
        
    [self setLife:_health];
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
