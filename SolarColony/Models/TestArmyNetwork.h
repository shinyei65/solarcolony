//
//  TestArmyNetwork.h
//  SolarColony
//
//  Created by Student on 3/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "JSONModel.h"

@interface SoldierTypeNetwork : JSONModel
@property (nonatomic, strong) NSString *soldiertype;
@property (nonatomic, strong) NSString *quantity;

@end

@protocol SoldierTypeNetwork;

@interface WaveNetwork : JSONModel
@property (nonatomic, strong) NSMutableArray<SoldierTypeNetwork> *soldiersArray;

@end

@protocol WaveNetwork;

@interface ArmyNetworkRequest : JSONModel
@property (nonatomic, strong) NSMutableArray<WaveNetwork> *wavesArray;
@property (nonatomic, strong) NSString *race;
@end