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
    _monitor = [[NSMutableArray alloc] init];
    _tick = 0;
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

- (void) startWave: (Wave *) target
{
    NSLog(@"WaveController: start a wave");
    _wave = target;
    _tick = SOL_GEN_RATE - 1;
}

- (void) endWave
{
    NSLog(@"WaveController: end a wave");
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
        int status = [[NetWorkManager NetWorkManager] getAttackRequest];
        [[NetWorkManager NetWorkManager] deleteAttackRequest:@"03-05-2015%2000:00:00"];
        NSLog(@"----status: %d",status);
    }
    
    [_wave release]; _wave = nil;
    [[ArmyQueue layer] endWave];
}

@end
