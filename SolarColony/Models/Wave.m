//
//  Wave.m
//  SolarColony
//
//  Created by Charles on 3/5/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "Wave.h"

@implementation Wave {
    NSMutableArray *_list;
}

#pragma mark - Create and Destroy

+ (instancetype) wave
{
    return [[self alloc] init];
}

- (instancetype) init
{
    self = [super init];
    if (!self) return(nil);
    _list = [[NSMutableArray alloc] init];
    return self;
}

- (void) dealloc
{
    [_list release]; _list = nil;
    [self release];
    [super dealloc];
}

#pragma mark - operation of soldiers

- (int) count
{
    return [_list count];
}
- (void) addSoldier: (Soldier *) sol
{
    [_list addObject: sol];
}

- (Soldier *) popSoldier
{
    Soldier *sol = (Soldier *)[_list objectAtIndex: 0];
    [_list removeObjectAtIndex: 0];
    return sol;
}

@end