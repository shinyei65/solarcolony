//
//  WavesLayer.m
//  SolarColony
//
//  Created by Po-Yi Lee on 3/7/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "WavesLayer.h"


@implementation WavesLayer
@synthesize mobileDisplaySize;

-(id)init{

    if(self=[super init]){

        transitionManagerSingleton = [TransitionManagerSingleton sharedInstance];
        CCMenuItemFont *wave1=[CCMenuItemFont itemWithString:@"Wave 1" target:self selector:nil];
//    CCMenuItemFont *wave2=[CCMenuItemFont itemWithString:@"Wave 2" target:self selector:nil];
//    CCMenuItemFont *wave3=[CCMenuItemFont itemWithString:@"Wave 3" target:self selector:nil];
        item1=[CCMenuItemFont itemWithString:@" " target:self selector:nil];
        item2=[CCMenuItemFont itemWithString:@" " target:self selector:nil];
        item3=[CCMenuItemFont itemWithString:@" " target:self selector:nil];
        item4=[CCMenuItemFont itemWithString:@" " target:self selector:nil];
        item5=[CCMenuItemFont itemWithString:@" " target:self selector:nil];
        item6=[CCMenuItemFont itemWithString:@" " target:self selector:nil];

        [wave1 setFontSize:20];
        [item1 setFontSize:15];
        [item2 setFontSize:15];
        [item3 setFontSize:15];
        [item4 setFontSize:15];
        [item5 setFontSize:15];
        [item6 setFontSize:15];
        CCMenu *WaveMenus;

        WaveMenus = [CCMenu menuWithItems: wave1,item1, item2, item3, item4, item5, item6, nil];
        //[WaveMenus  alignItemsInGridWithPadding:ccp(25, 25) columns:3];

        [WaveMenus alignItemsInColumns:[NSNumber numberWithInt:1], [NSNumber numberWithInt:3], [NSNumber numberWithInt:3], nil];

        [WaveMenus setPosition:ccp( mobileDisplaySize.width/3, mobileDisplaySize.height-65)];

        [self addChild:WaveMenus];

    }

    return self;
}

-(void)dealloc{
    [super dealloc];
}

@end
