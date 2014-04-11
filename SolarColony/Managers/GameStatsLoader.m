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
        // human init
        NSMutableDictionary *htower1 = [NSMutableDictionary dictionaryWithDictionary:@{@"health": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0}];
        NSMutableDictionary *htower2 = [NSMutableDictionary dictionaryWithDictionary:@{@"health": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0}];
        NSMutableDictionary *human = [NSMutableDictionary new];
        [human setObject:htower1 forKey:@"Tower1"];
        [human setObject:htower2 forKey:@"Tower2"];
        // robot init
        NSMutableDictionary *rtower1 = [NSMutableDictionary dictionaryWithDictionary:@{@"health": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0}];
        NSMutableDictionary *rtower2 = [NSMutableDictionary dictionaryWithDictionary:@{@"health": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0}];
        NSMutableDictionary *robot = [NSMutableDictionary new];
        [robot setObject:rtower1 forKey:@"Tower1"];
        [robot setObject:rtower2 forKey:@"Tower2"];
        // magic init
        NSMutableDictionary *mtower1 = [NSMutableDictionary dictionaryWithDictionary:@{@"health": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0}];
        NSMutableDictionary *mtower2 = [NSMutableDictionary dictionaryWithDictionary:@{@"health": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0}];
        NSMutableDictionary *magic = [NSMutableDictionary new];
        [magic setObject:mtower1 forKey:@"Tower1"];
        [magic setObject:mtower2 forKey:@"Tower2"];
        // root init
        [stats setObject:human forKey:@"Human"];
        [stats setObject:robot forKey:@"Robot"];
        [stats setObject:magic forKey:@"Magic"];
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
                                               [me.stats[@"Robot"][@"Tower1"] removeObjectForKey:@"health"];
                                               [me.stats[@"Robot"][@"Tower1"] setObject:@([[pair objectAtIndex:1] integerValue]) forKey:@"health"];
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"price"]) {
                                               [me.stats[@"Robot"][@"Tower1"] removeObjectForKey:@"price"];
                                               me.stats[@"Robot"][@"Tower1"][@"price"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"reward"]) {
                                               [me.stats[@"Robot"][@"Tower1"] removeObjectForKey:@"reward"];
                                               me.stats[@"Robot"][@"Tower1"][@"reward"] = @([[pair objectAtIndex:1] integerValue]);
                                               
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"attspeed"]) {
                                               [me.stats[@"Robot"][@"Tower1"] removeObjectForKey:@"attspeed"];
                                               me.stats[@"Robot"][@"Tower1"][@"attspeed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"power"]) {
                                               [me.stats[@"Robot"][@"Tower1"] removeObjectForKey:@"power"];
                                               me.stats[@"Robot"][@"Tower1"][@"power"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                       }
                                   },
                                   @"robotTower2" : ^(NSString *val, GameStatsLoader * me){
                                       NSArray *attrs = [val componentsSeparatedByString:@","];
                                       for (NSString *attr in attrs) {
                                           NSArray *pair = [attr componentsSeparatedByString:@"="];
                                           if ([[pair objectAtIndex:0] isEqualToString:@"health"]) {
                                               [me.stats[@"Robot"][@"Tower2"] removeObjectForKey:@"health"];
                                               me.stats[@"Robot"][@"Tower2"][@"health"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"price"]) {
                                               [me.stats[@"Robot"][@"Tower2"] removeObjectForKey:@"price"];
                                               me.stats[@"Robot"][@"Tower2"][@"price"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"reward"]) {
                                               [me.stats[@"Robot"][@"Tower2"] removeObjectForKey:@"reward"];
                                               me.stats[@"Robot"][@"Tower2"][@"reward"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"attspeed"]) {
                                               [me.stats[@"Robot"][@"Tower2"] removeObjectForKey:@"attspeed"];
                                               me.stats[@"Robot"][@"Tower2"][@"attspeed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"power"]) {
                                               [me.stats[@"Robot"][@"Tower2"] removeObjectForKey:@"power"];
                                               me.stats[@"Robot"][@"Tower2"][@"power"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                       }
                                   },
                                   @"humanTower1" : ^(NSString *val, GameStatsLoader * me){
                                       NSArray *attrs = [val componentsSeparatedByString:@","];
                                       for (NSString *attr in attrs) {
                                           NSArray *pair = [attr componentsSeparatedByString:@"="];
                                           if ([[pair objectAtIndex:0] isEqualToString:@"health"]) {
                                               [me.stats[@"Human"][@"Tower1"] removeObjectForKey:@"health"];
                                               me.stats[@"Human"][@"Tower1"][@"health"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"price"]) {
                                               [me.stats[@"Human"][@"Tower1"] removeObjectForKey:@"price"];
                                               me.stats[@"Human"][@"Tower1"][@"price"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"reward"]) {
                                               [me.stats[@"Human"][@"Tower1"] removeObjectForKey:@"reward"];
                                               me.stats[@"Human"][@"Tower1"][@"reward"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"attspeed"]) {
                                               [me.stats[@"Human"][@"Tower1"] removeObjectForKey:@"attspeed"];
                                               me.stats[@"Human"][@"Tower1"][@"attspeed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"power"]) {
                                               [me.stats[@"Human"][@"Tower1"] removeObjectForKey:@"power"];
                                               me.stats[@"Human"][@"Tower1"][@"power"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                       }
                                   },
                                   @"humanTower2" : ^(NSString *val, GameStatsLoader * me){
                                       NSArray *attrs = [val componentsSeparatedByString:@","];
                                       for (NSString *attr in attrs) {
                                           NSArray *pair = [attr componentsSeparatedByString:@"="];
                                           if ([[pair objectAtIndex:0] isEqualToString:@"health"]) {
                                               [me.stats[@"Human"][@"Tower2"] removeObjectForKey:@"health"];
                                               me.stats[@"Human"][@"Tower2"][@"health"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"price"]) {
                                               [me.stats[@"Human"][@"Tower2"] removeObjectForKey:@"price"];
                                               me.stats[@"Human"][@"Tower2"][@"price"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"reward"]) {
                                               [me.stats[@"Human"][@"Tower2"] removeObjectForKey:@"reward"];
                                               me.stats[@"Human"][@"Tower2"][@"reward"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"attspeed"]) {
                                               [me.stats[@"Human"][@"Tower2"] removeObjectForKey:@"attspeed"];
                                               me.stats[@"Human"][@"Tower2"][@"attspeed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"power"]) {
                                               [me.stats[@"Human"][@"Tower2"] removeObjectForKey:@"power"];
                                               me.stats[@"Human"][@"Tower2"][@"power"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                       }
                                   },
                                   @"magicTower1" : ^(NSString *val, GameStatsLoader * me){
                                       NSArray *attrs = [val componentsSeparatedByString:@","];
                                       for (NSString *attr in attrs) {
                                           NSArray *pair = [attr componentsSeparatedByString:@"="];
                                           if ([[pair objectAtIndex:0] isEqualToString:@"health"]) {
                                               [me.stats[@"Maigc"][@"Tower1"] removeObjectForKey:@"health"];
                                               me.stats[@"Maigc"][@"Tower1"][@"health"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"price"]) {
                                               [me.stats[@"Maigc"][@"Tower1"] removeObjectForKey:@"price"];
                                               me.stats[@"Maigc"][@"Tower1"][@"price"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"reward"]) {
                                               [me.stats[@"Maigc"][@"Tower1"] removeObjectForKey:@"reward"];
                                               me.stats[@"Maigc"][@"Tower1"][@"reward"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"attspeed"]) {
                                               [me.stats[@"Maigc"][@"Tower1"] removeObjectForKey:@"attspeed"];
                                               me.stats[@"Maigc"][@"Tower1"][@"attspeed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"power"]) {
                                               [me.stats[@"Maigc"][@"Tower1"] removeObjectForKey:@"power"];
                                               me.stats[@"Maigc"][@"Tower1"][@"power"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                       }
                                   },
                                   @"magicTower2" : ^(NSString *val, GameStatsLoader * me){
                                       NSArray *attrs = [val componentsSeparatedByString:@","];
                                       for (NSString *attr in attrs) {
                                           NSArray *pair = [attr componentsSeparatedByString:@"="];
                                           if ([[pair objectAtIndex:0] isEqualToString:@"health"]) {
                                               [me.stats[@"Maigc"][@"Tower2"] removeObjectForKey:@"health"];
                                               me.stats[@"Maigc"][@"Tower2"][@"health"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"price"]) {
                                               [me.stats[@"Maigc"][@"Tower2"] removeObjectForKey:@"price"];
                                               me.stats[@"Maigc"][@"Tower2"][@"price"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"reward"]) {
                                               [me.stats[@"Maigc"][@"Tower2"] removeObjectForKey:@"reward"];
                                               me.stats[@"Maigc"][@"Tower2"][@"reward"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"attspeed"]) {
                                               [me.stats[@"Maigc"][@"Tower2"] removeObjectForKey:@"attspeed"];
                                               me.stats[@"Maigc"][@"Tower2"][@"attspeed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"power"]) {
                                               [me.stats[@"Maigc"][@"Tower2"] removeObjectForKey:@"power"];
                                               me.stats[@"Maigc"][@"Tower2"][@"power"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                       }
                                   },
                                   }[key];
        
        if (selectedCase != nil)
            selectedCase(value, self);
    }
}
@end
