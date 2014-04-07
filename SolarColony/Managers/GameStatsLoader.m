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
- (id) init
{
    self = [super init];
    
    if (self) {
        
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
        void (^selectedCase)(NSString *) = @{
                                   @"mapIndexFile" : ^(NSString *val){
                                       NSLog(@"mapIndexFile");
                                       GameStatusEssentialsSingleton *gameStatus=[GameStatusEssentialsSingleton sharedInstance];
                                       [gameStatus setMapIndexName: val];
                                   },
                                   @"mapImageFile" : ^(NSString *val){
                                       NSLog(@"mapImageFile");
                                       GameStatusEssentialsSingleton *gameStatus=[GameStatusEssentialsSingleton sharedInstance];
                                       [gameStatus setMapImageName: val];
                                   },
                                   }[key];
        
        if (selectedCase != nil)
            selectedCase(value);
    }
}
@end
