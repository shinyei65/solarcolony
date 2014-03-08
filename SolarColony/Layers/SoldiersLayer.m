//
//  SoldiersLayer.m
//  SolarColony
//
//  Created by Po-Yi Lee on 3/7/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "SoldiersLayer.h"
#import "WavesLayer.h"

@implementation SoldiersLayer
@synthesize mobileDisplaySize;

-(id)init{
    
    if(self=[super init]){
        CCMenuItemFont *soldierA=[CCMenuItemFont itemWithString:@"Soldier A" target:self selector:@selector(setSoldierinWave:)];
        CCMenuItemFont *soldierB=[CCMenuItemFont itemWithString:@"Soldier B" target:self selector:@selector(setSoldierinWave:)];
        CCMenuItemFont *soldierC=[CCMenuItemFont itemWithString:@"Soldier C" target:self selector:@selector(setSoldierinWave:)];
        CCMenuItemFont *soldierD=[CCMenuItemFont itemWithString:@"Soldier D" target:self selector:@selector(setSoldierinWave:)];
        CCMenuItemFont *soldierE=[CCMenuItemFont itemWithString:@"Soldier E" target:self selector:@selector(setSoldierinWave:)];
        CCMenuItemFont *soldierF=[CCMenuItemFont itemWithString:@"Soldier F" target:self selector:@selector(setSoldierinWave:)];
        [soldierA setFontSize:20];
        [soldierB setFontSize:20];
        [soldierC setFontSize:20];
        [soldierD setFontSize:20];
        [soldierE setFontSize:20];
        [soldierF setFontSize:20];
        CCMenu *SoldierMenu = [CCMenu menuWithItems:soldierA, soldierB, soldierC,soldierD, soldierE, soldierF, nil];
        [SoldierMenu  alignItemsInGridWithPadding:ccp(0, 0) columns:1];
      //  [SoldierMenu setPosition:ccp(mobileDisplaySize.width*.75, mobileDisplaySize.height*.4)];
        
        return SoldierMenu;

    }
    return self;
}

-(void) setSoldierinWave:(id) soldierType{
    CCMenuItemFont *menuItem = (CCMenuItemFont*)soldierType;
    
    if ([menuItem.label.string isEqualToString:@"Soldier A"]) {
  //      [item1 setString:@"SoldierA"];
    }else if([menuItem.label.string isEqualToString:@"Soldier B"]){
  //      [item2 setString:@"SoldierB"];
    }else if([menuItem.label.string isEqualToString:@"Soldier C"]){
  //      [item3 setString:@"SoldierC"];
    }else if([menuItem.label.string isEqualToString:@"Soldier D"]){
  //      [item4 setString:@"SoldierD"];
    }else if([menuItem.label.string isEqualToString:@"Soldier E"]){
  //      [item5 setString:@"SoldierE"];
    }else if([menuItem.label.string isEqualToString:@"Soldier F"]){
  //      [item6 setString:@"SoldierF"];
    }
    
}

-(void)dealloc{
    [super dealloc];
}

@end
