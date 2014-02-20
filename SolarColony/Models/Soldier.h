//
//  Soldier.h
//  SolarColony
//
//  Created by Student on 2/9/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BulletBasic.h"
@interface Soldier : CCNode {
    
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
- (void)attack;
-(float)getMoveTime;
-(float)getMoveCD;
-(void)acculMoveCD:(float)time;
-(float)getAttackTime;
-(float)getAttackCD;
-(void)acculAttackCD:(float)time;
-(void)beingAttacked:(int)attack_power;


- (void) attackTest:(CGPoint) tower;

@property(assign, atomic) CGPoint targetLocation;

@end
