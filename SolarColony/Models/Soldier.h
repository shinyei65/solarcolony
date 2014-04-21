//
//  Soldier.h
//  SolarColony
//
//  Created by Student on 2/9/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class NormalBullet;
//#import "NormalBullet.h"

@interface Soldier : CCNode {
    CCSprite *_soldier;
    CCSprite *_hp;
    //soldier's attribute
    int S_health;
    int S_health_max;
    int S_attack;
    int S_attack_sp;
    int S_speed;
    int S_reward;
    float MoveTime;
    float moveCD;
    float AttackTime;
    float attackCD;
    BOOL S_attack_flag;
    NSString* type;
    CGPoint S_position; // grid coordinate
    id movePoint, returnPoint;
    NormalBullet* bullet;
    CGPoint targetPrevious;
    CCAnimation *walkAnim;
    CCSpriteBatchNode *spriteSheet;
    NSMutableArray *walkAnimFrames ;
    bool isRunner;
    CGPoint initialLocation;
}

+ (instancetype) attacker:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp;
+ (instancetype) runner:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp;
- (instancetype) attacker_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp;
- (instancetype) runner_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp;
- (void)setHEALTH:(int)health;
- (int)getHEALTH;
- (void)setATTACK:(int)attack;
- (int)getATTACK;
- (void)setATTACK_SP:(int)attack_sp;
- (int)getATTACK_SP;
- (void)setSPEED:(int)speed;
- (int)getSPEED;
- (void)setPOSITION:(int)x Y:(int)y; //set the position of soldier in grid coordinate
- (CGPoint)getPOSITION;
- (BOOL)getATTACK_FLAG;
- (void)move:(char)direction gridSize:(CGSize)size;
- (void)attack:(CGPoint) tower Target:(id) target;
-(float)getMoveTime;
-(float)getMoveCD;
-(void)acculMoveCD:(float)time;
-(float)getAttackTime;
-(float)getAttackCD;
-(void)acculAttackCD:(float)time;
-(void)beingAttacked:(int)attack_power;
-(void)bulletDisapp;
-(NSString*)getType;
- (void)moveOriginal;
- (void)setInitLocation:(CGPoint)loc;
- (CGPoint)getInitLocation;

@property(assign, atomic) CGPoint targetLocation;
@property (nonatomic, strong) CCSprite *explotion;
@end
