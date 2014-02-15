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
    int S_attack;
    int S_attack_sp;
    int S_speed;
    BOOL S_attack_flag;
    CGPoint S_position;
}

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
    S_attack = attack;
    S_attack_sp = attack_sp;
    S_speed = speed;
    S_attack_flag = TRUE;
    _soldier = [CCSprite spriteWithFile:@"Dismounted Soldier - Gear.jpg"];
    [self addChild:_soldier];
  
/*
    _hp = [];
    [self addChild:_hp];
 */
    return self;
}

- (instancetype) runner_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    self = [super init];
    if (!self) return(nil);
    S_health = health;
    S_attack = attack;
    S_attack_sp = attack_sp;
    S_speed = speed;
    S_attack_flag = FALSE;
    _soldier = [CCSprite spriteWithFile:@"Dismounted Soldier - Gear.jpg"];
    [self addChild:_soldier];
/*
     _hp = [];
     [self addChild:_hp];
*/
    return self;
}

- (void)setHEALTH:(int)health{
    S_health = health;
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

    //CGPoint new = ccpAdd(original, ccp(size.width,size.height));
    
    switch (direction) {
        case 'U':{
            id move = [CCMoveTo actionWithDuration:1.5 position:ccpAdd(original, ccp(0,size.height))];
            [self runAction:move];
            S_position = ccpAdd(S_position, ccp(0,-1)); //update grid coordinate
            break;
        }
        case 'D':{
            id move = [CCMoveTo actionWithDuration:1.5 position:ccpAdd(original, ccp(0,-size.height))];
            [self runAction:move];
            S_position = ccpAdd(S_position, ccp(0,1)); //update grid coordinate
            break;
        }
        case 'L':{
            id move = [CCMoveTo actionWithDuration:1.5 position:ccpAdd(original, ccp(-size.width,0))];
            [self runAction:move];
            S_position = ccpAdd(S_position, ccp(-1,0)); //update grid coordinate
            break;
        }
        case 'R':{
            id move = [CCMoveTo actionWithDuration:1.5 position:ccpAdd(original, ccp(size.width,0))];
            [self runAction:move];
            S_position = ccpAdd(S_position, ccp(1,0)); //update grid coordinate
            break;
        }
            
        default:
            break;
    }
    
}

- (void)attack{
    
}

- (void)dealloc
{
    [super dealloc];
    CCLOG(@"A soldier was deallocated");
    // clean up code goes here, should there be any
    
}
/*
- (void)update:(ccTime)delta
{
    
}
*/










@end
