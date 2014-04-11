//
//  GameStatsLoader.m
//  SolarColony
//
//  Created by Charles on 4/2/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "GameStatsLoader.h"
#import "GameStatusEssentialsSingleton.h"

@implementation GameStatsLoader
@synthesize robotT1_attspeed;
@synthesize robotT1_health;
@synthesize robotT1_power;
@synthesize robotT1_price;
@synthesize robotT1_reward;
@synthesize robotT2_attspeed;
@synthesize robotT2_health;
@synthesize robotT2_power;
@synthesize robotT2_price;
@synthesize robotT2_reward;
@synthesize stats;

static GameStatsLoader *sharedInstance = nil;
+ (GameStatsLoader *)loader {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}
- (id) init
{
    self = [super init];
    
    if (self) {
        stats = [[NSMutableDictionary alloc] init];
        [stats addEntriesFromDictionary:@{
                  @"Human":@{
                          @"Tower1": @{@"health": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0},
                          @"Tower2": @{@"health": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0}
                  },
                  @"Robot":@{
                          @"Tower1": @{@"health": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0},
                          @"Tower2": @{@"health": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0}
                  },
                  @"Magic":@{
                          @"Tower1": @{@"health": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0},
                          @"Tower2": @{@"health": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0}
                  }
        }];
        [self loadAllStats];
    }
    
    return self;
}
- (void) dealloc
{
    [self release];
    [super dealloc];
}
- (void) loadAllStats
{
    
    NSString *txtFilePath = [[NSBundle mainBundle] pathForResource:@"stats" ofType:@"txt"];
    NSString *contents = [NSString stringWithContentsOfFile:txtFilePath encoding:NSUTF8StringEncoding error:nil];
    NSArray* allLinedStrings = [contents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    for(int i=0; i<[allLinedStrings count]; i++){
        NSString* line = [allLinedStrings objectAtIndex:i];
        //NSLog(@"GameStatsLoader: %@", line);
        NSArray *sets = [line componentsSeparatedByString:@": "];
        NSString *key = [sets objectAtIndex:0];
        NSString *value = [sets objectAtIndex:1];
        void (^selectedCase)(NSString *, GameStatsLoader *) = @{
                                   @"mapIndexFile" : ^(NSString *val, GameStatsLoader * me){
                                       GameStatusEssentialsSingleton *gameStatus=[GameStatusEssentialsSingleton sharedInstance];
                                       [gameStatus setMapIndexName: val];
                                   },
                                   @"mapImageFile" : ^(NSString *val, GameStatsLoader * me){
                                       GameStatusEssentialsSingleton *gameStatus=[GameStatusEssentialsSingleton sharedInstance];
                                       [gameStatus setMapImageName: val];
                                   },
                                   @"robotTower1" : ^(NSString *val, GameStatsLoader * me){
                                       NSArray *attrs = [val componentsSeparatedByString:@","];
                                       for (NSString *attr in attrs) {
                                           NSArray *pair = [attr componentsSeparatedByString:@"="];
                                           if ([[pair objectAtIndex:0] isEqualToString:@"health"]) {
                                               me.robotT1_health = [[pair objectAtIndex:1] integerValue];
                                               //NSLog(@"%@", me.stats[@"Robot"][@"Tower1"][@"health"]);
                                               //[me.stats[@"Robot"][@"Tower1"] removeObjectForKey:@"health"];
                                               //[me.stats[@"Robot"][@"Tower1"] setObject:@([[pair objectAtIndex:1] integerValue]) forKey:@"health"];
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"price"]) {
                                               me.robotT1_price = [[pair objectAtIndex:1] integerValue];
                                               //me.stats[@"Robot"][@"Tower1"][@"price"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"reward"]) {
                                               me.robotT1_reward = [[pair objectAtIndex:1] integerValue];
                                               //me.stats[@"Robot"][@"Tower1"][@"reward"] = @([[pair objectAtIndex:1] integerValue]);
                                               
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"attspeed"]) {
                                               me.robotT1_attspeed = [[pair objectAtIndex:1] integerValue];
                                               //me.stats[@"Robot"][@"Tower1"][@"attspeed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"power"]) {
                                               me.robotT1_power = [[pair objectAtIndex:1] integerValue];
                                               //me.stats[@"Robot"][@"Tower1"][@"power"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                       }
                                   },
                                   @"robotTower2" : ^(NSString *val, GameStatsLoader * me){
                                       NSArray *attrs = [val componentsSeparatedByString:@","];
                                       for (NSString *attr in attrs) {
                                           NSArray *pair = [attr componentsSeparatedByString:@"="];
                                           if ([[pair objectAtIndex:0] isEqualToString:@"health"]) {
                                               me.robotT2_health = [[pair objectAtIndex:1] integerValue];
                                               //me.stats[@"Robot"][@"Tower2"][@"health"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"price"]) {
                                               me.robotT2_price = [[pair objectAtIndex:1] integerValue];
                                               //me.stats[@"Robot"][@"Tower2"][@"price"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"reward"]) {
                                               me.robotT2_reward = [[pair objectAtIndex:1] integerValue];
                                               //me.stats[@"Robot"][@"Tower2"][@"reward"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"attspeed"]) {
                                               me.robotT2_attspeed = [[pair objectAtIndex:1] integerValue];
                                               //me.stats[@"Robot"][@"Tower2"][@"attspeed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"power"]) {
                                               me.robotT2_power = [[pair objectAtIndex:1] integerValue];
                                               //me.stats[@"Robot"][@"Tower2"][@"power"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                       }
                                   },
                                   }[key];
        
        if (selectedCase != nil)
            selectedCase(value, self);
    }
}
/*- (int) getTowerhealth:(NSString *)race Type: (NSString *) towerType
{
    int result = 0;
    if([race isEqualToString:@"Human"]){
        if([towerType isEqualToString:@"Tower1"]){
            
        }else if([towerType isEqualToString:@"Tower2"]){
            
        }
    }else if([race isEqualToString:@"Robot"]){
        if([towerType isEqualToString:@"Tower1"]){
            
        }else if([towerType isEqualToString:@"Tower2"]){
            
        }
    }else{
        if([towerType isEqualToString:@"Tower1"]){
            
        }else if([towerType isEqualToString:@"Tower2"]){
            
        }
    }
    return result;
}
- (int) getTowerPrice:(NSString *)race Type: (NSString *) towerType
{
    int result = 0;
    if([race isEqualToString:@"Human"]){
        if([towerType isEqualToString:@"Tower1"]){
            
        }else if([towerType isEqualToString:@"Tower2"]){
            
        }
    }else if([race isEqualToString:@"Robot"]){
        if([towerType isEqualToString:@"Tower1"]){
            
        }else if([towerType isEqualToString:@"Tower2"]){
            
        }
    }else{
        if([towerType isEqualToString:@"Tower1"]){
            
        }else if([towerType isEqualToString:@"Tower2"]){
            
        }
    }
    return result;
}
- (int) getTowerReward:(NSString *)race Type: (NSString *) towerType
{
    int result = 0;
    if([race isEqualToString:@"Human"]){
        
    }else if([race isEqualToString:@"Robot"]){
        
    }else{
        
    }
    return result;
}
- (int) getTowerAttackSpeed:(NSString *)race Type: (NSString *) towerType
{
    int result = 0;
    if([race isEqualToString:@"Human"]){
        if([towerType isEqualToString:@"Tower1"]){
            
        }else if([towerType isEqualToString:@"Tower2"]){
            
        }
    }else if([race isEqualToString:@"Robot"]){
        if([towerType isEqualToString:@"Tower1"]){
            
        }else if([towerType isEqualToString:@"Tower2"]){
            
        }
    }else{
        if([towerType isEqualToString:@"Tower1"]){
            
        }else if([towerType isEqualToString:@"Tower2"]){
            
        }
    }
    return result;
}
- (int) getTowerPower:(NSString *)race Type: (NSString *) towerType
{
    int result = 0;
    if([race isEqualToString:@"Human"]){
        if([towerType isEqualToString:@"Tower1"]){
            
        }else if([towerType isEqualToString:@"Tower2"]){
            
        }
    }else if([race isEqualToString:@"Robot"]){
        if([towerType isEqualToString:@"Tower1"]){
            
        }else if([towerType isEqualToString:@"Tower2"]){
            
        }
    }else{
        if([towerType isEqualToString:@"Tower1"]){
            
        }else if([towerType isEqualToString:@"Tower2"]){
            
        }
    }
    return result;
}*/
@end
