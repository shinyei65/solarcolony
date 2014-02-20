//
//  WaveQueue.m
//  SolarColony
//
//  Created by Student on 2/19/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "WaveQueue.h"

static WaveQueue *sharedInstance = nil;

@implementation WaveQueue
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
    if (!self) return(nil);
    CCSprite *back = [CCSprite spriteWithFile:@"queue_back.jpg"];
    [back setScale:4.0];
    [self addChild:back];
    CCSprite *arrow = [CCSprite spriteWithFile:@"queue_arrow.jpeg"];
    [arrow setScale:4.0];
    [self addChild:arrow];
    CCSprite *start = [CCSprite spriteWithFile:@"queue_start.png"];
    [start setScale:4.0];
    [self addChild:start];

    return self;
}
@end
