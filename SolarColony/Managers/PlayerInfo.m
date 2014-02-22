//
//  PlayerInfo.m
//  SolarColony
//
//  Created by Student on 2/21/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "PlayerInfo.h"

@implementation PlayerInfo{
    int player_resource;
    int player_life;
}

static PlayerInfo* sharedInstance = nil;

+(instancetype)Player{
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:nil] init];
    }
    
    return sharedInstance;
}

-(instancetype)init{
    self = [super init];
    return self;
}
-(int)getLife{
    return player_life;
}
-(void)setLife:(int)life{
    player_life = life;
}
-(int)getResource{
    return player_resource;
}
-(void)setResource:(int)resource{
    player_resource = resource;
}



@end
