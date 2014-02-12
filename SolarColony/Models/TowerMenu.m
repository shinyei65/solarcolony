//
//  TowerMenu.m
//  SolarColony
//
//  Created by charles on 2/11/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "TowerMenu.h"
#import "CCMenu+Layout.h"


@implementation TowerMenu

#pragma mark - Create and Destroy

+ (instancetype) menu
{
    return [[self alloc] init];
}

- (instancetype) init
{
    self = [super init];
    if (!self) return(nil);
    
    CCMenuItemFont *item1=[CCMenuItemFont itemWithString:@"A" target:self selector:@selector(moveToScenee:)];
    CCMenuItemFont *item2=[CCMenuItemFont itemWithString:@"B" target:self selector:@selector(moveToScenee:)];
    CCMenuItemFont *item3=[CCMenuItemFont itemWithString:@"C" target:self selector:@selector(moveToScenee:)];
    CCMenuItemFont *item4=[CCMenuItemFont itemWithString:@"D" target:self selector:@selector(moveToScenee:)];
    CCMenuItemFont *item5=[CCMenuItemFont itemWithString:@"E" target:self selector:@selector(moveToScenee:)];
    CCMenuItemFont *item6=[CCMenuItemFont itemWithString:@"F" target:self selector:@selector(moveToScenee:)];
    CCMenuItemFont *item7=[CCMenuItemFont itemWithString:@"G" target:self selector:@selector(moveToScenee:)];
    CCMenuItemFont *item8=[CCMenuItemFont itemWithString:@"H" target:self selector:@selector(moveToScenee:)];
    CCMenuItemFont *item9=[CCMenuItemFont itemWithString:@"I" target:self selector:@selector(moveToScenee:)];
    self = [CCMenu menuWithItems:item1, item2, item3, item4, item5, item6, item7, item8, item9, nil];
    
    [self alignItemsInGridWithPadding:ccp(5, 5) columns:3];
    
    return self;
}

@end
