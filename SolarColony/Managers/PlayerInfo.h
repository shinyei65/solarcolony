//
//  PlayerInfo.h
//  SolarColony
//
//  Created by Student on 2/21/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerInfo : NSObject

+(instancetype) Player;
-(instancetype)init;
-(int)getLife;
-(void)setLife:(int)life;
-(int)getResource;
-(void)setResource:(int)resource;

@end
