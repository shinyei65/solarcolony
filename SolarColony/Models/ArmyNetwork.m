//
//  ArmyNetwork.m
//  SolarColony
//
//  Created by Eder Figueroa Ortiz on 3/7/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "ArmyNetwork.h"

@implementation ArmyNetwork

- (id)init
{
    self = [super init];
    if (self) {
         numberOfsoldiers=0;
         idFriendSend=0;
         idFriendRecieve=0;
         SoldierTypeRace=[[NSMutableDictionary alloc] init];
    }
    return self;
}

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

@end








