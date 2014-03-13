//
//  ArmyQueue.m
//  SolarColony
//
//  Created by Charles on 2/19/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "ArmyQueue.h"
#import "BasicSoldier.h"
#import "HumanSoldier.h"
#import "RobotSoldier.h"
#import "MageSoldier.h"
#import "GridMap.h"


static ArmyQueue *sharedInstance = nil;
int WAVE_START_RATE = 4;
int WAVE_SHOW_RATE = 2;
int ARMY_GEN_RATE = 6;
NSString *AI_REQUEST = @"AI";

@implementation ArmyQueue {
    //CCLabelTTF *_min;
    //CCLabelTTF *_sec;
    int _min_tick;
    int _sec_tick;
    int _tick;
    int _army_gen_tick;
    int _wave_show_tick;
    BOOL _hold;
    NSMutableArray *_queue;
    NSMutableArray *_show_queue;
    NSMutableArray *_sprite_queue;
}
+ (instancetype) layer
{
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}
- (instancetype) init
{
    self = [super init];
    if (self) {
        _queue = [[NSMutableArray alloc] init];
        _show_queue = [[NSMutableArray alloc] init];
        _sprite_queue = [[NSMutableArray alloc] init];
        _hold = FALSE;
        _army_gen_tick = 0;
        _wave_show_tick = 0;
        _tick = 0;
        _min_tick = 0;
        _sec_tick = WAVE_START_RATE;
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Waves: " fontName:@"Outlier.ttf" fontSize:15];
        [label setAnchorPoint:ccp(0,1)];
        [label setPosition:ccp(-100,0)];
        [self setAnchorPoint:ccp(0,1)];
        [self addChild:label];
        //_min = [CCLabelTTF labelWithString:@"Solar Colony" fontName:@"Marker Felt" fontSize:12];
        //_sec = [CCLabelTTF labelWithString:[self getSecString] fontName:@"Outlier.ttf" fontSize:15];
        //[_sec setAnchorPoint:ccp(0,1)];
        //[_sec setPosition:ccp([label boundingBox].size.width, 0)];
        //[self addChild:_sec];
        [self genertateAIarmy];
    }

    return self;
}
- (NSString *) getSecString
{
    return [NSString stringWithFormat:@"%2d", _sec_tick];
}
- (void) updateTick
{
    if(!_hold){
        if(_sec_tick == 0){
            _sec_tick = WAVE_START_RATE;
            //[self startWave];
        }
        _tick++;
        if(_tick == 60){
            _army_gen_tick++;
            _wave_show_tick++;
            _sec_tick--;
            _tick = 0;
            //[_sec setString:[self getSecString]];
        }
        if(_army_gen_tick == ARMY_GEN_RATE){
            _army_gen_tick = 0;
            [self genertateAIarmy];
        }
        if(_wave_show_tick == WAVE_SHOW_RATE){
            // TO DO: still need to implement show the queue in here
            _wave_show_tick = 0;
            [self showArmy];
            // TO DO: add wave in _queue into show queue
        }
    }
}
- (void) refreshTick
{
    _hold = FALSE;
    [self resumeAnimate];
    //[_sec setString:[self getSecString]];
}

#pragma mark - Army operation

- (void) pauseAnimate
{
    int count = [_sprite_queue count];
    for(int i=0; i<count; i++){
        CCSprite *qitem = (CCSprite*)[_sprite_queue objectAtIndex:i];
        [qitem pauseSchedulerAndActions];
    }
}

- (void) resumeAnimate
{
    int count = [_sprite_queue count];
    for(int i=0; i<count; i++){
        CCSprite *qitem = (CCSprite*)[_sprite_queue objectAtIndex:i];
        [qitem resumeSchedulerAndActions];
    }
    
}

- (void) startWave
{
    _hold = TRUE;
    [self pauseAnimate];
    Wave *target = (Wave *)[_show_queue objectAtIndex:0];
    [[GridMap map] showMessage:[NSString stringWithFormat:@"%@ Attack!", target.attacker]];
    [[WaveController controller] addWave:target];
    [_show_queue removeObjectAtIndex:0];
    CCSprite *qitem = (CCSprite*)[_sprite_queue objectAtIndex:0];
    [_sprite_queue removeObjectAtIndex:0];
    [qitem setVisible:FALSE];
    [self removeChild:qitem cleanup:YES];
    [[WaveController controller] startWave];
}

- (void) showArmy
{
    int count = [_queue count];
    if(count == 0) {
        _wave_show_tick = WAVE_SHOW_RATE - 1;
        return;
    }
    Wave *target = (Wave *)[_queue objectAtIndex:0];
    [_queue removeObjectAtIndex:0];
    [_show_queue addObject:target];
    CCSprite *qitem = [CCSprite spriteWithFile:@"angrybomb.png"];
    [qitem setPosition:ccp(0,-5)];
    [self addChild: qitem];
    [_sprite_queue addObject:qitem];
    id move = [CCMoveTo actionWithDuration:WAVE_START_RATE position:ccp(125,-5)];
    id wrapperAction = [CCCallFunc actionWithTarget:self selector:@selector(startWave)];
    id sequence = [CCSequence actions: move, wrapperAction, nil];
    [qitem runAction:sequence];
    NSLog(@"ArmyQueue: %d waves in show queue", [_show_queue count]);
}

- (void) addArmy: (Army *) army
{
    int count = [army count];
    for(int i=0; i<count; i++){
        [_queue addObject:[army popWave]];
    }
    [army autorelease];
    NSLog(@"ArmyQueue: %d waves in queue", [_queue count]);
}

- (void) genertateAIarmy
{
    NSLog(@"ArmyQueue: generate AI army");
    // add one AI army in queue
    Army *army = [Army army: AI_REQUEST Attacker:AI_REQUEST];
    for(int x=0; x<3; x++){
        Wave *wave = [Wave wave];
        for (int i=0; i<3; i++) {
            //CCLOG(@"runner!!!");
            Soldier *temp;
            if(x ==0){
                wave.race = @"human";
                temp = [BasicSoldier human:(int)100 ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
            }else if(x == 1){
                wave.race = @"robot";
                temp = [BasicSoldier robot:(int)100 ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
            }else{
                wave.race = @"magic";
                temp = [BasicSoldier mage:(int)100 ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
            }
            [wave addSoldier: temp];
        }
        for (int i=0; i<3; i++) {
            //CCLOG(@"attacker!!!");
            Soldier *temp;
            if(x ==0)
                temp = [HumanSoldier typeA:(int)100 ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
            else if(x == 1)
                temp = [RobotSoldier typeA:(int)100 ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
            else
                temp = [MageSoldier typeA:(int)100 ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
            [wave addSoldier: temp];
        }
        [army addWave: wave];
    }
    [self addArmy: army];
}
@end
