//
//  WaveQueue.m
//  SolarColony
//
//  Created by Student on 2/19/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "WaveQueue.h"
#import "WaveController.h"

static WaveQueue *sharedInstance = nil;
int WAVE_START_RATE = 12;

@implementation WaveQueue {
    CCLabelTTF *_min;
    CCLabelTTF *_sec;
    int _min_tick;
    int _sec_tick;
    int _tick;
    BOOL _hold;
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
@end
