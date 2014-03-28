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
    float resource_increase_CD_time;
    NSString* username;
    NSUserDefaults *standardUserDefaults;
}

static PlayerInfo* sharedInstance = nil;
static const int resource_inc_amount = 10;
static const float resource_inc_time = 1;

+(instancetype)Player{
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:nil] init];
    }
    
    return sharedInstance;
}

-(instancetype)init{
    self = [super init];
    resource_increase_CD_time = 0;
    /*https://developer.apple.com/library/ios/documentation/cocoa/reference/foundation/Classes/NSUserDefaults_Class/Reference/Reference.html#//apple_ref/occ/instm/NSUserDefaults/removePersistentDomainForName:*/
    //http://codeexamples.wordpress.com/2011/02/12/nsuserdefaults-example/
    
    standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString object
    //[standardUserDefaults setObject:@"Jimmy" forKey:@"Username"];
    //NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    //[standardUserDefaults removePersistentDomainForName:appDomain];
    username = [standardUserDefaults stringForKey:@"Username"];
    
    NSLog(@"test name");
    if(username != nil){
        NSLog(username);
        NSLog(@"usernameis not null");
    }
    else
        NSLog(@"username is null");
    
    
    
    
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

-(void)increaseResource:(ccTime)time{
    resource_increase_CD_time += time;
    if(resource_increase_CD_time >= resource_inc_time){
        player_resource += resource_inc_amount;
        resource_increase_CD_time = 0;
    }
}

-(NSString*)getUsername{
    return username;
}

-(void)setUsername:(NSString*)name{
    username = name;
    [standardUserDefaults setObject:name forKey:@"Username"];
}


@end
