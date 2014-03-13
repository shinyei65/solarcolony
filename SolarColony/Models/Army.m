//
//  Army.m
//  SolarColony
//
//  Created by Charles on 2/18/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "Army.h"

@implementation Army {
    NSMutableArray *_list;
}
@synthesize request_id;
@synthesize attacker;

#pragma mark - Create and Destroy

+ (instancetype) army: (NSString *) rid Attacker: (NSString *) att
{
    return [[self alloc] init: rid Attacker:att];
}

- (instancetype) init: (NSString *) rid Attacker: (NSString *) att
{
    self = [super init];
    if (!self) return(nil);
    request_id = rid;
    attacker = att;
    _list = [[NSMutableArray alloc] init];
    return self;
}

- (void) dealloc
{
    [_list release]; _list = nil;
    [self release];
    [super dealloc];
    //CCLOG(@"A army was deallocated");
}

#pragma mark - operation of soldiers

- (int) count
{
    return [_list count];
}
- (void) addWave: (Wave *) wave
{
    wave.request_id = request_id;
    wave.attacker = attacker;
    [_list addObject: wave];
}

- (Wave *) popWave
{
    Wave *wave = (Wave *)[_list objectAtIndex: 0];
    [_list removeObjectAtIndex: 0];
    return wave;
}

@end
