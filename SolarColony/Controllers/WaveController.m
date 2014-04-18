//
//  WaveController.m
//  SolarColony
//
//  Created by Charles on 2/14/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "WaveController.h"
#import "GameStatusEssentialsSingleton.h"

static WaveController *sharedInstance = nil;
int SOL_GEN_RATE = 1;

@implementation WaveController {
    int _tick;
    int _startTakeTurn;
    int _reward;
    NSMutableArray *_monitor;
    Wave *_wave;
    GameStatusEssentialsSingleton * gameStatusEssentialsSingleton;
}

#pragma mark - Create and Destroy

+ (instancetype) controller
{
    if(sharedInstance == nil){
        sharedInstance = [[super allocWithZone:nil] init];
    }
    return sharedInstance;
}

- (instancetype) init
{
    self = [super init];
    if (!self) return(nil);
    
    // initialize variable
    _monitor = [[NSMutableArray alloc] init];
    _tick = 0;
    _startTakeTurn = 0;
    gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
    return self;
}

- (void) dealloc
{
    [self release];
    [super dealloc];
}

#pragma mark - Wave operation

- (void) update
{
    _tick++;
    if([_wave count]){
        if(_tick == SOL_GEN_RATE){
            // add to monitor and soldier controller
            _tick = 0;
            [self generateSoldier];
        }
    }else{
        // if all monitored soldiers died, end wave
        if(![self checkMonitor]){
            [self endWave];
        }
    }
}

- (void) generateSoldier
{
    //NSLog(@"WaveController: generate a soldier");
    GridMap *grid = [GridMap map];
    CGPoint start = [[[grid getStartIndex] objectAtIndex:_startTakeTurn] CGPointValue];
    Soldier *sol = [_wave popSoldier];
    [_monitor addObject: sol];
    [sol setPOSITION:start.x Y:start.y];
    [sol setPosition:[grid convertMapIndexToCenterGL:start]];
    [grid addChild:sol z:0];
    [gameStatusEssentialsSingleton addSoldier: sol];
}

- (BOOL) checkMonitor
{
    for(int i=0; i<[_monitor count]; i++){
        Soldier *sol = (Soldier *)[_monitor objectAtIndex:i];
        if(sol.visible)
            return TRUE;
    }
    return FALSE;
}

- (void) startWave: (Wave *) target
{
    NSLog(@"WaveController: start a wave");
    _wave = target;
    _tick = SOL_GEN_RATE - 1;
}

- (void) endWave
{
    NSLog(@"WaveController: end a wave");
    _startTakeTurn = (_startTakeTurn + 1) % [[GridMap map] getStartCount];
    [gameStatusEssentialsSingleton removeAllSoldiers];
    int count = [_monitor count];
    //NSLog(@"GridMap: children = %d", [[[GridMap map] children] count]);
    for(int i=0; i<count; i++){
        Soldier *sol = (Soldier *)[_monitor objectAtIndex:0];
        [_monitor removeObjectAtIndex:0];
        [[GridMap map] removeChild:sol cleanup:YES];
        [sol release];
    }
    if([_wave getEndFlag]){
        [[NetWorkManager NetWorkManager] getAttackRequest];
    }
    [self sendAndRefreshReward];
    [_wave release]; _wave = nil;
    [[ArmyQueue layer] endWave];
}

- (void) gainReward:(int) gain
{
    _reward += gain;
}

- (void) sendAndRefreshReward
{
    NSLog(@"REWARD=%d", _reward);
    if(![_wave.attacker isEqualToString:@"AI"] && _reward > 0)
        [[NetWorkManager NetWorkManager] setRewardtoAttacker:_wave.attacker Reward:_reward];
    _reward = 0;
}

@end
