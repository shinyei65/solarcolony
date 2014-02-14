//
//  WaveController.m
//  SolarColony
//
//  Created by Student on 2/14/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "WaveController.h"
#import "GridMap.h"

@implementation WaveController {
    BOOL _status;
    NSMutableArray *_queue;
}

#pragma mark - Create and Destroy

+ (instancetype) controller
{
    return [[self alloc] init];
}

- (instancetype) init
{
    self = [super init];
    if (!self) return(nil);
    
    // initialize variable
    _status = TRUE;
    _queue = [NSMutableArray array];
    
    return self;
}

- (void) dealloc
{
    [super dealloc];
    [self release];
}

#pragma mark - Wave operation

- (BOOL) getStatus
{
    return _status;
}

- (void) update
{
    
}

@end
