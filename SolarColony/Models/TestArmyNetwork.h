//
//  TestArmyNetwork.h
//  SolarColony
//
//  Created by Student on 3/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "JSONModel.h"

@interface TestArmyNetwork : JSONModel
@property (nonatomic, strong) NSString *soldiertype;
@property (nonatomic, strong) NSString *quantity;
 
@end

@protocol TestArmyNetwork;

@interface WaveNetwork : JSONModel
@property (nonatomic, strong) NSMutableArray<TestArmyNetwork> *waves;
@property (nonatomic, strong) NSString *races;
@end
