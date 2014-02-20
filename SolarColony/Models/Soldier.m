//
//  Soldier.m
//  SolarColony
//
//  Created by Student on 2/9/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "Soldier.h"
#import "GridMap.h"
//#import "cocos2d.h"


@implementation Soldier{
    CCSprite *_soldier;
    CCSprite *_hp;
    //soldier's attribute
    int S_health;
    int S_health_max;
    int S_attack;
    int S_attack_sp;
    int S_speed;
    float MoveTime;
    float moveCD;
    float AttackTime;
    float attackCD;
    BOOL S_attack_flag;
    CGPoint S_position;
     id movePoint, returnPoint ;
    BulletBasic* bullet;
}
@synthesize targetLocation;

+ (instancetype) attacker:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    return([[Soldier alloc]attacker_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp]);
}
+ (instancetype) runner:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    return([[Soldier alloc]runner_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp]);
}

- (instancetype) attacker_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    self = [super init];
    if (!self) return(nil);
    S_health = health;
    S_health_max = health;
    S_attack = attack;
    S_attack_sp = attack_sp;
    S_speed = speed;
    MoveTime = (float)1/speed;
    moveCD = 0;
    AttackTime = (float)1/attack_sp;
    attackCD = 0;
    S_attack_flag = TRUE;
    _soldier = [CCSprite spriteWithFile:@"Dismounted Soldier - Gear.jpg"];
    _hp = [CCSprite spriteWithFile:@"blood_full.jpg"];
    _hp.position = ccp(0, 10);
    [self addChild:_soldier];
    [self addChild:_hp];


    return self;
}

- (instancetype) runner_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    self = [super init];
    if (!self) return(nil);
    S_health = health;
    S_health_max = health;
    S_attack = attack;
    S_attack_sp = attack_sp;
    S_speed = speed;
    MoveTime = (float)1/speed;
    moveCD = 0;
    AttackTime = (float)1/attack_sp;
    attackCD = 0;
    S_attack_flag = FALSE;
    _soldier = [CCSprite spriteWithFile:@"Dismounted Soldier - Gear.jpg"];
    _hp = [CCSprite spriteWithFile:@"blood_full.jpg"];
    _hp.position = ccp(0, 10);
    [self addChild:_soldier];
    [self addChild:_hp];

    
    bullet = [[ BulletBasic alloc] initTower:ccp(150, 150)];
    [self addChild:bullet];
    
    return self;
}

- (void)setHEALTH:(int)health{
    S_health = health;
    if (health <= S_health_max*3/4 && health > S_health_max*1/2) {
        //CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"blood_3:4.jpg"];
        [_hp setTexture:[[CCSprite spriteWithFile:@"blood_3:4.jpg"]texture]];
    }
    if (health <= S_health_max*1/2 && health > S_health_max*1/4) {
        [_hp setTexture:[[CCSprite spriteWithFile:@"blood_half.jpg"]texture]];
    }
    if (health <= S_health_max*1/4 && health > S_health_max*1/10) {
        [_hp setTexture:[[CCSprite spriteWithFile:@"blood_1:4.jpg"]texture]];
    }
    if (health <= S_health_max*1/10 && health > S_health_max*1/20) {
        [_hp setTexture:[[CCSprite spriteWithFile:@"blood_empty.jpg"]texture]];
    }
    if (health <= 0){
        [self setVisible:FALSE];
    }
}
- (int)getHEALTH{
    return S_health;
}
- (void)setATTACK:(int)attack{
    S_attack = attack;
}
- (int)getATTACK{
    return S_attack;
}
- (void)setATTACK_SP:(int)attack_sp{
    S_attack_sp = attack_sp;
}
- (int)getATTACK_SP{
    return S_attack_sp;
}
- (void)setSPEED:(int)speed{
    S_speed = speed;
}
- (int)getSPEED{
    return S_speed;
}
- (void)setPOSITION:(int)x Y:(int)y{//set the position of soldier in grid coordinate
    S_position.x = x;
    S_position.y = y;
}
- (CGPoint)getPOSITION{
    return S_position;
}
- (BOOL)getATTACK_FLAG{
    return S_attack_flag;
}

- (void)move:(char)direction gridSize:(CGSize)size{
    
    CGPoint original = self.position;
    float moveTime = (float)1/[self getSPEED];
    //CGPoint new = ccpAdd(original, ccp(size.width,size.height));
    
    switch (direction) {
        case 'U':{
            id move = [CCMoveTo actionWithDuration:moveTime position:ccpAdd(original, ccp(0,size.height))];
            [self runAction:move];
            S_position = ccpAdd(S_position, ccp(0,-1));//update grid coordinate
            break;
        }
        case 'D':{
            id move = [CCMoveTo actionWithDuration:moveTime position:ccpAdd(original, ccp(0,-size.height))];
            [self runAction:move];
            S_position = ccpAdd(S_position, ccp(0,1)); //update grid coordinate
            break;
        }
        case 'L':{
            id move = [CCMoveTo actionWithDuration:moveTime position:ccpAdd(original, ccp(-size.width,0))];
            [self runAction:move];
            S_position = ccpAdd(S_position, ccp(-1,0)); //update grid coordinate
            break;
        }
        case 'R':{
            id move = [CCMoveTo actionWithDuration:moveTime position:ccpAdd(original, ccp(size.width,0))];
            [self runAction:move];
            S_position = ccpAdd(S_position, ccp(1,0)); //update grid coordinate

            break;
        }
            
        default:
            break;
    }
    
    moveCD = 0;
}

-(float)getMoveTime{
    return MoveTime;
}

-(float)getMoveCD{
    return moveCD;
}

-(void)acculMoveCD:(float)time{
    moveCD += time;
}

-(float)getAttackTime{
    return AttackTime;
}

-(float)getAttackCD{
    return attackCD;
}

-(void)acculAttackCD:(float)time{
    attackCD += time;
}

-(void)beingAttacked:(int)attack_power{
    int newHealth = [self getHEALTH] - attack_power;
    [self setHEALTH:newHealth];
}


- (void) attackTest:(CGPoint) tower{
     CCLOG(@"SHOTTING TOWERRRR*********");
      targetLocation=tower;
    [self schedule: @selector(animatonAttack:) interval:1];
   attackCD = 0;
    
}

-(void) animatonAttack: (ccTime) dt
{
    // bla bla bla
    //   if (counterTest<=5) {
    CCLOG(@"SHOTTING TOWERRRR*********99999595959595");
 
    [bullet setVisible:true];
       CCLOG(@"coord x %f",targetLocation.x);
      CCLOG(@"coord x %f",targetLocation.y);
    CGPoint targetLocations = [self convertToNodeSpace:targetLocation];
     //  CCLOG(@"coord x %f",targetLocations.x);
       //CCLOG(@"coord x %f",targetLocations.y);
    CGPoint targetPrevious = [bullet position];
 
    movePoint = [CCMoveTo actionWithDuration:.2 position:targetLocations];
    returnPoint = [CCMoveTo actionWithDuration:.01 position:targetPrevious];
    
    [bullet runAction:[CCSequence actions: movePoint,returnPoint,nil]];
 
    
 
    [self unscheduleAllSelectors];
 
  
    
}


- (void)dealloc
{
    [super dealloc];
    CCLOG(@"A soldier was deallocated");
    // clean up code goes here, should there be any
    
}











@end
