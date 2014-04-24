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
        NSMutableDictionary *hrunner = [NSMutableDictionary dictionaryWithDictionary:@{@"health": @0, @"speed": @0, @"price": @0, @"reward": @0}];
        NSMutableDictionary *hattacker = [NSMutableDictionary dictionaryWithDictionary:@{@"health": @0, @"speed": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0}];
        NSMutableDictionary *human = [NSMutableDictionary new];
        [human setObject:htower1 forKey:@"Tower1"];
        [human setObject:htower2 forKey:@"Tower2"];
        [human setObject:hrunner forKey:@"Runner"];
        [human setObject:hattacker forKey:@"Attacker1"];
        // robot init
        NSMutableDictionary *rtower1 = [NSMutableDictionary dictionaryWithDictionary:@{@"health": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0}];
        NSMutableDictionary *rtower2 = [NSMutableDictionary dictionaryWithDictionary:@{@"health": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0}];
        NSMutableDictionary *rrunner = [NSMutableDictionary dictionaryWithDictionary:@{@"health": @0, @"speed": @0, @"price": @0, @"reward": @0}];
        NSMutableDictionary *rattacker = [NSMutableDictionary dictionaryWithDictionary:@{@"health": @0, @"speed": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0}];
        NSMutableDictionary *robot = [NSMutableDictionary new];
        [robot setObject:rtower1 forKey:@"Tower1"];
        [robot setObject:rtower2 forKey:@"Tower2"];
        [robot setObject:rrunner forKey:@"Runner"];
        [robot setObject:rattacker forKey:@"Attacker1"];
        // magic init
        NSMutableDictionary *mtower1 = [NSMutableDictionary dictionaryWithDictionary:@{@"health": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0}];
        NSMutableDictionary *mtower2 = [NSMutableDictionary dictionaryWithDictionary:@{@"health": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0}];
        NSMutableDictionary *mrunner = [NSMutableDictionary dictionaryWithDictionary:@{@"health": @0, @"speed": @0, @"price": @0, @"reward": @0}];
        NSMutableDictionary *mattacker = [NSMutableDictionary dictionaryWithDictionary:@{@"health": @0, @"speed": @0, @"price": @0, @"reward": @0, @"attspeed": @0, @"power": @0}];
        NSMutableDictionary *magic = [NSMutableDictionary new];
        [magic setObject:mtower1 forKey:@"Tower1"];
        [magic setObject:mtower2 forKey:@"Tower2"];
        [magic setObject:mrunner forKey:@"Runner"];
        [magic setObject:mattacker forKey:@"Attacker1"];
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
                                       [gameStatus setMapIndexName: [val retain]];
                                   },
                                   @"mapImageFile" : ^(NSString *val, GameStatsLoader * me){
                                       GameStatusEssentialsSingleton *gameStatus=[GameStatusEssentialsSingleton sharedInstance];
                                       [gameStatus setMapImageName: [val retain]];
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
                                               [me.stats[@"Magic"][@"Tower1"] removeObjectForKey:@"health"];
                                               me.stats[@"Magic"][@"Tower1"][@"health"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"price"]) {
                                               [me.stats[@"Magic"][@"Tower1"] removeObjectForKey:@"price"];
                                               me.stats[@"Magic"][@"Tower1"][@"price"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"reward"]) {
                                               [me.stats[@"Magic"][@"Tower1"] removeObjectForKey:@"reward"];
                                               me.stats[@"Magic"][@"Tower1"][@"reward"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"attspeed"]) {
                                               [me.stats[@"Magic"][@"Tower1"] removeObjectForKey:@"attspeed"];
                                               me.stats[@"Magic"][@"Tower1"][@"attspeed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"power"]) {
                                               [me.stats[@"Magic"][@"Tower1"] removeObjectForKey:@"power"];
                                               me.stats[@"Magic"][@"Tower1"][@"power"] = @([[pair objectAtIndex:1] integerValue]);
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
                                               [me.stats[@"Magic"][@"Tower2"] removeObjectForKey:@"reward"];
                                               me.stats[@"Magic"][@"Tower2"][@"reward"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"attspeed"]) {
                                               [me.stats[@"Magic"][@"Tower2"] removeObjectForKey:@"attspeed"];
                                               me.stats[@"Magic"][@"Tower2"][@"attspeed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"power"]) {
                                               [me.stats[@"Magic"][@"Tower2"] removeObjectForKey:@"power"];
                                               me.stats[@"Magic"][@"Tower2"][@"power"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                       }
                                   },
                                   @"humanRunner" : ^(NSString *val, GameStatsLoader * me){
                                       NSArray *attrs = [val componentsSeparatedByString:@","];
                                       for (NSString *attr in attrs) {
                                           NSArray *pair = [attr componentsSeparatedByString:@"="];
                                           if ([[pair objectAtIndex:0] isEqualToString:@"health"]) {
                                               [me.stats[@"Human"][@"Runner"] removeObjectForKey:@"health"];
                                               me.stats[@"Human"][@"Runner"][@"health"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"price"]) {
                                               [me.stats[@"Human"][@"Runner"] removeObjectForKey:@"price"];
                                               me.stats[@"Human"][@"Runner"][@"price"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"reward"]) {
                                               [me.stats[@"Human"][@"Runner"] removeObjectForKey:@"reward"];
                                               me.stats[@"Human"][@"Runner"][@"reward"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"speed"]) {
                                               [me.stats[@"Human"][@"Runner"] removeObjectForKey:@"speed"];
                                               me.stats[@"Human"][@"Runner"][@"speed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                       }
                                   },
                                   @"humanAttacker1" : ^(NSString *val, GameStatsLoader * me){
                                       NSArray *attrs = [val componentsSeparatedByString:@","];
                                       for (NSString *attr in attrs) {
                                           NSArray *pair = [attr componentsSeparatedByString:@"="];
                                           if ([[pair objectAtIndex:0] isEqualToString:@"health"]) {
                                               [me.stats[@"Human"][@"Attacker1"] removeObjectForKey:@"health"];
                                               me.stats[@"Human"][@"Attacker1"][@"health"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"price"]) {
                                               [me.stats[@"Human"][@"Attacker1"] removeObjectForKey:@"price"];
                                               me.stats[@"Human"][@"Attacker1"][@"price"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"reward"]) {
                                               [me.stats[@"Human"][@"Attacker1"] removeObjectForKey:@"reward"];
                                               me.stats[@"Human"][@"Attacker1"][@"reward"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"speed"]) {
                                               [me.stats[@"Human"][@"Attacker1"] removeObjectForKey:@"speed"];
                                               me.stats[@"Human"][@"Attacker1"][@"speed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"attspeed"]) {
                                               [me.stats[@"Human"][@"Attacker1"] removeObjectForKey:@"attspeed"];
                                               me.stats[@"Human"][@"Attacker1"][@"attspeed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"power"]) {
                                               [me.stats[@"Human"][@"Attacker1"] removeObjectForKey:@"power"];
                                               me.stats[@"Human"][@"Attacker1"][@"power"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                       }
                                   },
                                   @"robotRunner" : ^(NSString *val, GameStatsLoader * me){
                                       NSArray *attrs = [val componentsSeparatedByString:@","];
                                       for (NSString *attr in attrs) {
                                           NSArray *pair = [attr componentsSeparatedByString:@"="];
                                           if ([[pair objectAtIndex:0] isEqualToString:@"health"]) {
                                               [me.stats[@"Robot"][@"Runner"] removeObjectForKey:@"health"];
                                               me.stats[@"Robot"][@"Runner"][@"health"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"price"]) {
                                               [me.stats[@"Robot"][@"Runner"] removeObjectForKey:@"price"];
                                               me.stats[@"Robot"][@"Runner"][@"price"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"reward"]) {
                                               [me.stats[@"Robot"][@"Runner"] removeObjectForKey:@"reward"];
                                               me.stats[@"Robot"][@"Runner"][@"reward"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"speed"]) {
                                               [me.stats[@"Robot"][@"Runner"] removeObjectForKey:@"speed"];
                                               me.stats[@"Robot"][@"Runner"][@"speed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                       }
                                   },
                                   @"robotAttacker1" : ^(NSString *val, GameStatsLoader * me){
                                       NSArray *attrs = [val componentsSeparatedByString:@","];
                                       for (NSString *attr in attrs) {
                                           NSArray *pair = [attr componentsSeparatedByString:@"="];
                                           if ([[pair objectAtIndex:0] isEqualToString:@"health"]) {
                                               [me.stats[@"Robot"][@"Attacker1"] removeObjectForKey:@"health"];
                                               me.stats[@"Robot"][@"Attacker1"][@"health"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"price"]) {
                                               [me.stats[@"Robot"][@"Attacker1"] removeObjectForKey:@"price"];
                                               me.stats[@"Robot"][@"Attacker1"][@"price"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"reward"]) {
                                               [me.stats[@"Robot"][@"Attacker1"] removeObjectForKey:@"reward"];
                                               me.stats[@"Robot"][@"Attacker1"][@"reward"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"speed"]) {
                                               [me.stats[@"Robot"][@"Attacker1"] removeObjectForKey:@"speed"];
                                               me.stats[@"Robot"][@"Attacker1"][@"speed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"attspeed"]) {
                                               [me.stats[@"Robot"][@"Attacker1"] removeObjectForKey:@"attspeed"];
                                               me.stats[@"Robot"][@"Attacker1"][@"attspeed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"power"]) {
                                               [me.stats[@"Robot"][@"Attacker1"] removeObjectForKey:@"power"];
                                               me.stats[@"Robot"][@"Attacker1"][@"power"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                       }
                                   },
                                   @"magicRunner" : ^(NSString *val, GameStatsLoader * me){
                                       NSArray *attrs = [val componentsSeparatedByString:@","];
                                       for (NSString *attr in attrs) {
                                           NSArray *pair = [attr componentsSeparatedByString:@"="];
                                           if ([[pair objectAtIndex:0] isEqualToString:@"health"]) {
                                               [me.stats[@"Magic"][@"Runner"] removeObjectForKey:@"health"];
                                               me.stats[@"Magic"][@"Runner"][@"health"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"price"]) {
                                               [me.stats[@"Magic"][@"Runner"] removeObjectForKey:@"price"];
                                               me.stats[@"Magic"][@"Runner"][@"price"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"reward"]) {
                                               [me.stats[@"Magic"][@"Runner"] removeObjectForKey:@"reward"];
                                               me.stats[@"Magic"][@"Runner"][@"reward"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"speed"]) {
                                               [me.stats[@"Magic"][@"Runner"] removeObjectForKey:@"speed"];
                                               me.stats[@"Magic"][@"Runner"][@"speed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                       }
                                   },
                                   @"magicAttacker1" : ^(NSString *val, GameStatsLoader * me){
                                       NSArray *attrs = [val componentsSeparatedByString:@","];
                                       for (NSString *attr in attrs) {
                                           NSArray *pair = [attr componentsSeparatedByString:@"="];
                                           if ([[pair objectAtIndex:0] isEqualToString:@"health"]) {
                                               [me.stats[@"Magic"][@"Attacker1"] removeObjectForKey:@"health"];
                                               me.stats[@"Magic"][@"Attacker1"][@"health"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"price"]) {
                                               [me.stats[@"Magic"][@"Attacker1"] removeObjectForKey:@"price"];
                                               me.stats[@"Magic"][@"Attacker1"][@"price"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"reward"]) {
                                               [me.stats[@"Magic"][@"Attacker1"] removeObjectForKey:@"reward"];
                                               me.stats[@"Magic"][@"Attacker1"][@"reward"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"speed"]) {
                                               [me.stats[@"Magic"][@"Attacker1"] removeObjectForKey:@"speed"];
                                               me.stats[@"Magic"][@"Attacker1"][@"speed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"attspeed"]) {
                                               [me.stats[@"Magic"][@"Attacker1"] removeObjectForKey:@"attspeed"];
                                               me.stats[@"Magic"][@"Attacker1"][@"attspeed"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                           if ([[pair objectAtIndex:0] isEqualToString:@"power"]) {
                                               [me.stats[@"Magic"][@"Attacker1"] removeObjectForKey:@"power"];
                                               me.stats[@"Magic"][@"Attacker1"][@"power"] = @([[pair objectAtIndex:1] integerValue]);
                                           }
                                       }
                                   },
                                   }[key];
        
        if (selectedCase != nil)
            selectedCase(value, self);
    }
}
@end
