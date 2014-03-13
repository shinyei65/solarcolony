//
//  ArmyNetwork.h
//  SolarColony
//
//  Created by Eder Figueroa Ortiz on 3/7/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "JSONModel.h"

@interface ArmyNetwork : JSONModel

    @property (nonatomic, strong) NSMutableDictionary *waveComplexStructure;
    @property (nonatomic, strong) NSString *race;
/*
-(void) setNumberOfSoldiers:(int) numSoldiers;

-(int) getNumberOfSoldiers;
-(void) setIdFriendSend:(int) idFriend;
-(int) getIdFriendSend;
-(void) setIdFriendRecieve:(int) idFriend;
-(int) getIdFriendRecieve;
-(void) setSoldierTypeRace:(NSMutableDictionary*) soldiers;
-(NSMutableDictionary*) getSoldierTypeRace;
-(void) addSoldierTypeRace:(NSString*) soldierRace NumSoldiers:(int) numsoldiers;
-(int) addSoldierTypeRace:(NSString*) soldierRace;*/
@end
