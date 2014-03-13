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
int SOL_GEN_RATE = 60; // 60 ticks per sec

@implementation WaveController {
    int _tick;
    int _hold_tick;
    BOOL _in_wave;
    NSMutableArray *_queue;
    NSMutableArray *_monitor;
    Wave *_wave;
    NSObject *_mylock;
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
    _in_wave = FALSE;
    _queue = [[NSMutableArray alloc] init];
    _monitor = [[NSMutableArray alloc] init];
    _tick = 0;
    _mylock = [[NSObject alloc] init];
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
    @synchronized(_mylock){
        //NSLog(@"WaveController: tick = %d", _tick);
        //NSLog(@"WaveController: number of %d wave in queue", [_queue count]);
        if(_in_wave){
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
    }
}

- (void) addWave: (Wave *) wave
{
    [_queue addObject: wave];
    NSLog(@"WaveController: %d waves in queue", [_queue count]);
}

- (void) generateSoldier
{
    //NSLog(@"WaveController: generate a soldier");
    GridMap *grid = [GridMap map];
    CGPoint start = [grid getStartIndex];
    Soldier *sol = [_wave popSoldier];
    [_monitor addObject: sol];
    [sol setPOSITION:start.x Y:start.y];
    [sol setPosition:[grid convertMapIndexToCenterGL:start]];
    [grid addChild:sol z:1];
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

- (void) startWave
{
    NSLog(@"WaveController: start a wave");
    @synchronized(_mylock){
        _wave = (Wave *)[_queue objectAtIndex: 0];
        _hold_tick = _tick;
        _tick = SOL_GEN_RATE - 1;
        _in_wave = TRUE;
    }
}

- (void) endWave
{
    NSLog(@"WaveController: end a wave");
    [_queue removeObjectAtIndex: 0];
    [gameStatusEssentialsSingleton removeAllSoldiers];
    for(int i=0; i<[_wave count]; i++){
        Soldier *sol = [_wave popSoldier];
        [sol removeFromParent];
        [sol release];
    }
    if([_wave getEndFlag]){
        [[NetWorkManager NetWorkManager] getAttackRequest];
        [[NetWorkManager NetWorkManager] deleteAttackRequest:@"03-05-2015%2000:00:00"];
    }
    
    [_wave release]; _wave = nil;
    _tick = _hold_tick;
    _in_wave = FALSE;
    [[ArmyQueue layer] refreshTick];
}

@end
