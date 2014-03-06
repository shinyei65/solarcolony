//
//  ArmyQueue.m
//  SolarColony
//
//  Created by Charles on 2/19/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "ArmyQueue.h"
#import "WaveController.h"
#import "Wave.h"

static ArmyQueue *sharedInstance = nil;
int WAVE_START_RATE = 1;
int WAVE_GEN_RATE = 1;

@implementation ArmyQueue {
    CCLabelTTF *_min;
    CCLabelTTF *_sec;
    int _min_tick;
    int _sec_tick;
    int _tick;
    BOOL _hold;
    NSMutableArray *_queue;
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
        _hold = FALSE;
        _tick = 0;
        _min_tick = 0;
        _sec_tick = WAVE_START_RATE + 2;
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Next Wave: " fontName:@"Marker Felt" fontSize:12];
        [label setColor: ccc3(0,255,255)];
        [label setAnchorPoint:ccp(0,1)];
        [self setAnchorPoint:ccp(0,1)];
        [self addChild:label];
        //_min = [CCLabelTTF labelWithString:@"Solar Colony" fontName:@"Marker Felt" fontSize:12];
        _sec = [CCLabelTTF labelWithString:[self getSecString] fontName:@"Marker Felt" fontSize:12];
        [_sec setAnchorPoint:ccp(0,1)];
        [_sec setPosition:ccp([label boundingBox].size.width, 0)];
        [_sec setColor: ccc3(0,255,255)];
        [self addChild:_sec];
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
            _hold = TRUE;
            _sec_tick = WAVE_START_RATE;
            [[WaveController controller] startWave];
        }
        _tick++;
        if(_tick == 60){
            _sec_tick--;
            _tick = 0;
            [_sec setString:[self getSecString]];
        }
    }
}
- (void) refreshTick
{
    _hold = FALSE;
    [_sec setString:[self getSecString]];
}

#pragma mark - Army operation

- (void) addArmy: (Army *) army
{
    [_queue addObject: army];
    NSLog(@"ArmyQueue: %d armies in queue", [_queue count]);
}

- (void) genertateAIarmy
{
    NSLog(@"ArmyQueue: generate AI army");
    // add one AI army in queue
    Army *army = [Army army];
    Wave *wave = [Wave wave];
    for (int i=0; i<3; i++) {
        CCLOG(@"runner!!!");
        Soldier *temp = [Soldier runner:(int)100 ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
        [wave addSoldier: temp];
    }
    for (int i=0; i<3; i++) {
        CCLOG(@"attacker!!!");
        Soldier *temp = [Soldier attacker:(int)100 ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
        [wave addSoldier: temp];
    }
    [army addWave: wave];
    [self addArmy: army];
}
@end
