//
//  TestArmyNetwork.m
//  SolarColony
//
//  Created by Student on 3/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "TestArmyNetwork.h"

@implementation TestArmyNetwork
@synthesize soldiertype;
@synthesize quantity;

- (id)init
{
    self = [super init];
    if (self) {
        soldiertype=[[NSString alloc] init];
        quantity=[[NSString alloc] init];
    }
    return self;
}

@end

@implementation WaveNetwork
@synthesize races;
@synthesize waves;

- (id)init
{
    self = [super init];
    if (self) {
         //http://stackoverflow.com/questions/14958883/ios-serialize-deserialize-complex-json-generically-from-nsobject-class
    }
    return self;
}

-(void) addNewWave{
    
}

-(void) addSoldier{
    
}
@end