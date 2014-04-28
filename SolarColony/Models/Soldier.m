//
//  Soldier.m
//  SolarColony
//
//  Created by Student on 2/9/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "TowerGeneric.h"
#import "GridMap.h"
//#import "cocos2d.h"
#import "NormalBullet.h"
#import "PlayerInfo.h"

@implementation Soldier{
    TowerGeneric *attackTarget;
    CCSprite * reward;
    int gainReward;
    bool isAttacking;
    bool stopController;
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
    attackTarget = nil;
    gainReward = 0;
    S_reward = 20;
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
    _soldier = [[CCSprite alloc] init];
    _hp = [CCSprite spriteWithFile:@"blood_full.jpg"];
    _hp.position = ccp(0, 15);
    [self addChild:_hp];
    bullet = [[ NormalBullet alloc] initSoldier:ccp(150, 150)];
    [self addChild:bullet];
    [bullet setVisible:false];
    
    isRunner=false;
    //explotion
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"bluebullet.plist"];
    spriteSheet = [CCSpriteBatchNode
                                      batchNodeWithFile:@"bluebullet.png"];
    [self addChild:spriteSheet z:10];
    musicManagerSingleton = [MusicManagerSingleton shareSoundManager];
    [spriteSheet setAnchorPoint:ccp(.5,.5)];
    
    //grab hands
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"handsmoving.plist"];
    spriteSheetHand = [CCSpriteBatchNode
                       batchNodeWithFile:@"handsmoving.png"];
    [spriteSheetHand setAnchorPoint:ccp(.5,.5)];
    [self addChild:spriteSheetHand z:10];
    [self setAnchorPoint:ccp(.5,.5)];
    isAttacking=false;
    stopController=false;
    
    
    reward = [CCSprite spriteWithFile:[NSString stringWithFormat:@"p%d.png",S_reward]];
    reward.position = ccp(0, 5);
    //[reward setVisible:false];
    reward.opacity=0;
    [self addChild:reward];
    
    return self;
}

- (instancetype) runner_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    self = [super init];
    if (!self) return(nil);
    attackTarget = nil;
    gainReward = 0;
    S_reward = 20;
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
    _soldier = [[CCSprite alloc] init];
    _hp = [CCSprite spriteWithFile:@"blood_full.jpg"];
    _hp.position = ccp(0, 15);
    [self addChild:_hp];
    
    isRunner=true;
    //explotion
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"acidbullet.plist"];
    spriteSheet = [CCSpriteBatchNode
                   batchNodeWithFile:@"acidbullet.png"];
    [spriteSheet setAnchorPoint:ccp(.5,.5)];
    [self addChild:spriteSheet z:10];
    //grab hands
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     @"handsmoving.plist"];
    spriteSheetHand = [CCSpriteBatchNode
                       batchNodeWithFile:@"handsmoving.png"];
    [spriteSheetHand setAnchorPoint:ccp(.5,.5)];
    [self addChild:spriteSheetHand z:10];
    [self setAnchorPoint:ccp(.5,.5)];
    isAttacking=false;
    stopController=false;
    
    reward = [CCSprite spriteWithFile:[NSString stringWithFormat:@"p%d.png",S_reward]];
    reward.position = ccp(0, 5);
    reward.opacity=0;
    [self addChild:reward];
    
    return self;
}

- (void)setHEALTH:(int)health{
    S_health = health;
    if (health > S_health_max) {
        NSLog(@"chang max health");
        S_health_max = health;
    }
    if (health <= S_health_max*3/4 && health > S_health_max*1/2) {
        //CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"blood_3:4.jpg"];
       // NSLog(@"blood 3/4");
        [_hp setTexture:[[CCSprite spriteWithFile:@"blood_3:4.jpg"]texture]];
    }
    if (health <= S_health_max*1/2 && health > S_health_max*1/4) {
       // NSLog(@"blood 1/2");
        [_hp setTexture:[[CCSprite spriteWithFile:@"blood_half.jpg"]texture]];
    }
    if (health <= S_health_max*1/4 && health > S_health_max*1/10) {
       // NSLog(@"blood 1/4");
        [_hp setTexture:[[CCSprite spriteWithFile:@"blood_1:4.jpg"]texture]];
    }
    if (health <= S_health_max*1/10 && health > S_health_max*1/20) {
       // NSLog(@"blood 0");
        [_hp setTexture:[[CCSprite spriteWithFile:@"blood_empty.jpg"]texture]];
    }
    @synchronized(self){
        if (health <= 0 && [self visible]){
            float moveTime = (float)1/[self getSPEED];
            CCFadeIn *fadeIn =  [CCFadeIn actionWithDuration:0.05];
            //id move2 = [CCMoveTo actionWithDuration:moveTime position:[[GridMap map] convertMapIndexToCenterGL:ccp([self position].x, [self position].y+5)]];
            id move2 = [CCMoveTo actionWithDuration:moveTime position:ccp([reward position].x, [reward position].y+35)];
            [reward runAction:[CCSequence actions:fadeIn,move2,[CCCallFunc actionWithTarget:self selector:@selector(setVisibleAndGiveRward)],nil]];
        
        }
    }
}


-(void) setVisibleAndGiveRward{
    [self setVisible:FALSE];
    //NSLog(@"REWARD!!!!:");
    int newResource = [[PlayerInfo Player] getResource];
    newResource +=  S_reward;
    [[PlayerInfo Player] setResource:newResource];

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
    MoveTime = (float)1/speed;
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

- (void)moveOriginal{
    
    float moveTime = (float)1/[self getSPEED];
    CGPoint newPosition = ccp(initialLocation.x-1,initialLocation.y);
    id move = [CCMoveTo actionWithDuration:moveTime position:[[GridMap map] convertMapIndexToCenterGL:newPosition]];
    S_position =initialLocation;
    [self runAction:move];
    
    
}

//test
- (void)moveOriginalTest{
    stopController=true;
    CCFadeIn *fadeIn =  [CCFadeIn actionWithDuration:0.05];;
    //animation
    walkAnimFramesHands = [NSMutableArray array];
    
    for (int i=1; i<=6; i++) {
        [walkAnimFramesHands addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"hand%d.png",i]]];
    }
    [spriteSheet setPosition:[self position]];
    walkAnim = [CCAnimation
                animationWithSpriteFrames:walkAnimFramesHands delay:0.1f ] ;
    
    self.hand = [CCSprite spriteWithSpriteFrameName:@"hand1.png"];
    [self.hand runAction:[CCSequence actions:fadeIn,[CCAnimate actionWithAnimation:walkAnim],[CCCallFunc actionWithTarget:self selector:@selector(moveSpriteSoldierOriginal)],nil]];
    [spriteSheetHand addChild:self.hand];
 
}

-(void)moveSpriteSoldierOriginal{
     CGPoint newPosition = ccp(initialLocation.x,initialLocation.y);
    float moveTime = (float)1/[self getSPEED];
    id move2 = [CCMoveTo actionWithDuration:moveTime position:[[GridMap map] convertMapIndexToCenterGL:newPosition]];
    S_position =initialLocation;
    [self runAction:[CCSequence actions:move2,[CCCallFunc actionWithTarget:self selector:@selector(superEvilGrabbingHand)],nil]];
}
 
//=)
-(void)superEvilGrabbingHand{
    CCFadeOut * fadeOut=  [CCFadeOut actionWithDuration:0.05];
         [self.hand runAction:[CCSequence actions:[CCCallFunc actionWithTarget:self selector:@selector(setStopController)],fadeOut,nil]];
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
    @synchronized(self){
        
        CCFadeOut * fadeOut=  [CCFadeOut actionWithDuration:0.05];;
        CCFadeIn *fadeIn =  [CCFadeIn actionWithDuration:0.05];;
        
        //animation
        walkAnimFrames = [NSMutableArray array];
        //add
        [musicManagerSingleton playEffect:@"sound 13.wav"];
        if (isRunner) {
            for (int i=1; i<=10; i++) {
                [walkAnimFrames addObject:
                 [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                  [NSString stringWithFormat:@"acid%d.png",i]]];
            }
            [spriteSheet setPosition:[self position]];
            walkAnim = [CCAnimation
                        animationWithSpriteFrames:walkAnimFrames delay:0.05f];
            
            self.explotion = [CCSprite spriteWithSpriteFrameName:@"acid1.png"];
        } else {
            for (int i=1; i<=10; i++) {
                [walkAnimFrames addObject:
                 [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                  [NSString stringWithFormat:@"blue%d.png",i]]];
            }
            [spriteSheet setPosition:[self position]];
            
            walkAnim = [CCAnimation
                        animationWithSpriteFrames:walkAnimFrames delay:0.05f];
            
            self.explotion = [CCSprite spriteWithSpriteFrameName:@"blue1.png"];
        }
        
        
        
        // self.explotion.position = S_position;
        self.explotion.position = [self convertToNodeSpace:S_position];
        /*CCAction *walkAction  = [ccre actionWithAction:
         ];*/
        //[self.explotion runAction:[CCAnimate actionWithAnimation:walkAnim]];
        [self.explotion runAction:[CCSequence actions:fadeIn,[CCAnimate actionWithAnimation:walkAnim],fadeOut,nil]];
        [spriteSheet addChild:self.explotion];

        
        int newHealth = S_health - attack_power;
        [self setHEALTH:newHealth];
    }

    
    
}
-(void)setStopController{
    stopController=false;
}
-(bool) getStopController{
    return stopController;
}
-(bool) getIsAttacking{
    return isAttacking;
}


- (void) attack:(CGPoint) tower  Target:(id) target{
      targetLocation=tower;
    attackTarget = (TowerGeneric *) target;
    isAttacking=true;
    //[self schedule: @selector(animatonAttack:) interval:0.5];
    [self animatonAttack];
    //[bullet setVisible:false];
    attackCD = 0;
    
    
}

//-(void) animatonAttack:(ccTime)delta
-(void) animatonAttack
{
    // bla bla bla
    //   if (counterTest<=5) {
 
    [bullet setVisible:true];
      //CCLOG(@"coord x %f",targetLocation.x);
      //CCLOG(@"coord x %f",targetLocation.y);
    CGPoint targetLocations = [self convertToNodeSpace:targetLocation];
     //  CCLOG(@"coord x %f",targetLocations.x);
       //CCLOG(@"coord x %f",targetLocations.y);
    targetPrevious = [bullet position];
 
    movePoint = [CCMoveTo actionWithDuration:.2 position:targetLocations];
    //returnPoint = [CCMoveTo actionWithDuration:.01 position:targetPrevious];
  
    
    [bullet runAction:[CCSequence actions: movePoint,[CCCallFunc actionWithTarget:self selector:@selector(bulletDisapp)],nil]];
 
}

- (void)setInitLocation:(CGPoint)loc{
    initialLocation=loc;
}
- (CGPoint)getInitLocation{
     return initialLocation;
}

-(void)bulletDisapp
{
    [attackTarget beignattacked:S_attack];
    //attackTarget = nil;
    [bullet setPosition:targetPrevious];
    [bullet setVisible:false];
    isAttacking=false;
    //[self unschedule: @selector(animatonAttack:)];
}

-(NormalBullet*)getBullet{
    return bullet;
}

- (void)dealloc
{
    [self release];
    [super dealloc];
    //CCLOG(@"A soldier was deallocated");
    // clean up code goes here, should there be any
    
}

-(NSString*)getType{
    return type;
}









@end
