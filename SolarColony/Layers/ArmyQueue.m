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


static ArmyQueue *sharedInstance = nil;
int WAVE_START_RATE = 4;
int WAVE_ADD_RATE = 1;
int ARMY_GEN_RATE = 12;

@implementation ArmyQueue {
    CCLabelTTF *_min;
    CCLabelTTF *_sec;
    int _min_tick;
    int _sec_tick;
    int _tick;
    int _army_gen_tick;
    int _wave_between_tick;
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
        _army_gen_tick = 0;
        _wave_between_tick = 0;
        _tick = 0;
        _min_tick = 0;
        _sec_tick = WAVE_START_RATE;
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Next Wave: " fontName:@"Outlier.ttf" fontSize:15];
        [label setAnchorPoint:ccp(0,1)];
        [self setAnchorPoint:ccp(0,1)];
        [self addChild:label];
        //_min = [CCLabelTTF labelWithString:@"Solar Colony" fontName:@"Marker Felt" fontSize:12];
        _sec = [CCLabelTTF labelWithString:[self getSecString] fontName:@"Outlier.ttf" fontSize:15];
        [_sec setAnchorPoint:ccp(0,1)];
        [_sec setPosition:ccp([label boundingBox].size.width, 0)];
        [self addChild:_sec];
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
            _hold = TRUE;
            _sec_tick = WAVE_START_RATE;
            [self startWave];
        }
        _tick++;
        if(_tick == 60){
            _army_gen_tick++;
            _wave_between_tick++;
            _sec_tick--;
            _tick = 0;
            [_sec setString:[self getSecString]];
        }
        if(_army_gen_tick == ARMY_GEN_RATE){
            _army_gen_tick = 0;
            [self genertateAIarmy];
        }
        if(_wave_between_tick == WAVE_ADD_RATE){
            // TO DO: still need to implement show the queue in here
            _wave_between_tick = 0;
            // TO DO: add wave in _queue into show queue
        }
    }
}
- (void) refreshTick
{
    _hold = FALSE;
    [_sec setString:[self getSecString]];
}

#pragma mark - Army operation

- (void) startWave
{
    [[WaveController controller] addWave:(Wave *)[_queue objectAtIndex:0]];
    [_queue removeObjectAtIndex:0];
    [[WaveController controller] startWave];
}

- (void) addArmy: (Army *) army
{
    int count = [army count];
    for(int i=0; i<count; i++){
        [_queue addObject:[army popWave]];
    }
    [army release];
    NSLog(@"ArmyQueue: %d waves in queue", [_queue count]);
}

- (void) genertateAIarmy
{
    NSLog(@"ArmyQueue: generate AI army");
    // add one AI army in queue
    Army *army = [Army army];
    for(int x=0; x<3; x++){
        Wave *wave = [Wave wave];
        for (int i=0; i<3; i++) {
            //CCLOG(@"runner!!!");
            Soldier *temp;
            if(x ==0)
                temp = [BasicSoldier human:(int)100 ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
            else if(x == 1)
                temp = [BasicSoldier robot:(int)100 ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
            else
                temp = [BasicSoldier mage:(int)100 ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
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
