//
//  PlayerInfo.h
//  SolarColony
//
//  Created by Student on 2/21/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameStatusEssentialsSingleton.h"

@interface PlayerInfo : NSObject
{
    NSString *username;
}

+(instancetype) Player;
-(instancetype)init;
-(int)getLife;
-(void)setLife:(int)life;
-(int)getResource;
-(void)setResource:(int)resource;
-(void)increaseResource:(ccTime)time;
-(NSString*)getUsername;
-(void)setUsername:(NSString*)name;
-(id)initWithCoder:(NSCoder *)decoder;
-(void)encodeWithCoder:(NSCoder *)encoder;

@property (nonatomic, strong) NSString* username;

@end
