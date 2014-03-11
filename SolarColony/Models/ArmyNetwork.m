//
//  ArmyNetwork.m
//  SolarColony
//
//  Created by Eder Figueroa Ortiz on 3/7/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "ArmyNetwork.h"

@implementation ArmyNetwork
@synthesize numberOfsoldiers;
@synthesize idFriendSend;
@synthesize idFriendRecieve;
@synthesize soldierTypeRace;
@synthesize waveComplexStructure;

- (id)init
{
    self = [super init];
    if (self) {
         numberOfsoldiers=0;
         idFriendSend=0;
         idFriendRecieve=0;
         soldierTypeRace=[[NSMutableDictionary alloc] init];
         waveComplexStructure=[[NSMutableDictionary alloc] init];
        
        //set up all waves
        
        
        NSMutableDictionary *wave1 = [NSMutableDictionary
                                     dictionaryWithDictionary:@{
                                                                @"SA": @"0",
                                                                @"SB" : @"0",
                                                                @"SC" : @"0",
                                                                @"SD" : @"0",
                                                                @"SE" : @"0",
                                                                @"SF" : @"0",
                                                                }];
        
        NSMutableDictionary *wave2 = [NSMutableDictionary
                                      dictionaryWithDictionary:@{
                                                                 @"SA": @"0",
                                                                 @"SB" : @"0",
                                                                 @"SC" : @"0",
                                                                 @"SD" : @"0",
                                                                 @"SE" : @"0",
                                                                 @"SF" : @"0",
                                                                 }];
        NSMutableDictionary *wave3 = [NSMutableDictionary
                                      dictionaryWithDictionary:@{
                                                                 @"SA": @"0",
                                                                 @"SB" : @"0",
                                                                 @"SC" : @"0",
                                                                 @"SD" : @"0",
                                                                 @"SE" : @"0",
                                                                 @"SF" : @"0",
                                                                 }];
        NSMutableDictionary *wave4 = [NSMutableDictionary
                                      dictionaryWithDictionary:@{
                                                                 @"SA": @"0",
                                                                 @"SB" : @"0",
                                                                 @"SC" : @"0",
                                                                 @"SD" : @"0",
                                                                 @"SE" : @"0",
                                                                 @"SF" : @"0",
                                                                 }];
        NSMutableDictionary *wave5 = [NSMutableDictionary
                                      dictionaryWithDictionary:@{
                                                                 @"SA": @"0",
                                                                 @"SB" : @"0",
                                                                 @"SC" : @"0",
                                                                 @"SD" : @"0",
                                                                 @"SE" : @"0",
                                                                 @"SF" : @"0",
                                                                 }];
        NSMutableDictionary *wave6 = [NSMutableDictionary
                                      dictionaryWithDictionary:@{
                                                                 @"SA": @"0",
                                                                 @"SB" : @"0",
                                                                 @"SC" : @"0",
                                                                 @"SD" : @"0",
                                                                 @"SE" : @"0",
                                                                 @"SF" : @"0",
                                                                 }];
        NSMutableDictionary *wave7 = [NSMutableDictionary
                                      dictionaryWithDictionary:@{
                                                                 @"SA": @"0",
                                                                 @"SB" : @"0",
                                                                 @"SC" : @"0",
                                                                 @"SD" : @"0",
                                                                 @"SE" : @"0",
                                                                 @"SF" : @"0", }];
              
        //place in principal dictionary
        [waveComplexStructure setObject:wave1 forKey:@"w1"];
        [waveComplexStructure setObject:wave2 forKey:@"w2"];
        [waveComplexStructure setObject:wave3 forKey:@"w3"];
        [waveComplexStructure setObject:wave4 forKey:@"w4"];
        [waveComplexStructure setObject:wave5 forKey:@"w5"];
        [waveComplexStructure setObject:wave6 forKey:@"w6"];
        [waveComplexStructure setObject:wave7 forKey:@"w7"];
    }
    return self;
}
/*
-(void) setNumberOfSoldiers:(int) numSoldiers{
    numberOfsoldiers=numSoldiers;
}

-(int) getNumberOfSoldiers{
    return numberOfsoldiers;
}

-(void) setIdFriendSend:(int) idFriend{
    idFriendSend=idFriend;
}

-(int) getIdFriendSend{
    return idFriendSend;
}

-(void) setIdFriendRecieve:(int) idFriend{
    idFriendRecieve=idFriend;
}

-(int) getIdFriendRecieve{
     return idFriendRecieve;
}

-(void) setSoldierTypeRace:(NSMutableDictionary*) soldiers{
    SoldierTypeRace=soldiers;
}

-(NSMutableDictionary*) getSoldierTypeRace{
    return SoldierTypeRace;
}

-(void) addSoldierTypeRace:(NSString*) soldierRace NumSoldiers:(int) numsoldiers{
    [SoldierTypeRace setObject:numsoldiers forKey:soldierRace];
}

-(int) addSoldierTypeRace:(NSString*) soldierRace{
    
    return  [SoldierTypeRace objectForKey:soldierRace];
}
*/
@end








