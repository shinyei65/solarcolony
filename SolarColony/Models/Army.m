//
//  Army.m
//  SolarColony
//
//  Created by Charles on 2/18/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "Army.h"
#import "Soldier.h";

@implementation Army {
    NSMutableArray *_list;
}

#pragma mark - Create and Destroy

+ (instancetype) army
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
