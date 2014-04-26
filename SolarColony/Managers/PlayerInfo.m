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
    GameStatusEssentialsSingleton *gameStatusEssentialsSingleton;

}

@synthesize username;
@synthesize friends;

static PlayerInfo* sharedInstance = nil;
static const int resource_inc_amount = 10;
static const float resource_inc_time = 5;

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
    friends = [[NSMutableArray alloc] init];
    // getting an NSString object
    //[standardUserDefaults setObject:@"Jimmy" forKey:@"Username"];
    //NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    //[standardUserDefaults removePersistentDomainForName:appDomain];
    return self;
}
-(int)getLife{
    return player_life;
}
-(void)setLife:(int)life{
    player_life = life;
}
-(int)getResource{
    @synchronized(self){
        return player_resource;
    }
}
-(void)setResource:(int)resource{
    @synchronized(self){
        if (resource >= 0) {
        player_resource = resource;
        [[NSUserDefaults standardUserDefaults] setInteger:resource forKey:@"resource"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

-(void)increaseResource:(ccTime)time{
    resource_increase_CD_time += time;
    if(resource_increase_CD_time >= resource_inc_time){
        player_resource += resource_inc_amount;
        resource_increase_CD_time = 0;
    }
}


- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self->player_resource = [decoder decodeIntForKey:@"player_resource"];
        self->player_life = [decoder decodeIntForKey:@"player_life"];
        username = [[decoder decodeObjectForKey:@"username"] retain];
        //NSArray *tempFrd =[[decoder decodeObjectForKey:@"friends"] retain];
       // CCLOG(@"friends: %@",tempFrd);
        //friends = [[NSMutableArray alloc] initWithArray:tempFrd copyItems:TRUE];
        friends = [[decoder decodeObjectForKey:@"friends"] retain];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt:player_resource forKey:@"player_resource"];
    [encoder encodeInt:player_life forKey:@"player_life"];
    [encoder encodeObject:username forKey:@"username"];
    [encoder encodeObject:friends forKey:@"friends"];

}


@end
