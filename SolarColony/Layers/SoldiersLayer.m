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
        
        //Game status global variables
        gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
        
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
        [SoldierMenu  alignItemsVertically];
        [SoldierMenu setPosition:ccp(0, mobileDisplaySize.height*.9)];
        
        //SETS UP COUNTER FOR SOLIDERS;
        counterA=0;
        counterB=0;
        counterC=0;
        counterD=0;
        counterE=0;
        counterF=0;
        
        [self addChild:[self loadMutablesoldierMenuNumber]];
        [self addChild:SoldierMenu];

    }
    return self;
}


-(CCMenu*) loadMutablesoldierMenuNumber{
    item1=[CCMenuItemFont itemWithString:@"0" target:self selector:nil];
    [item1 setFontSize:20];
    item2=[CCMenuItemFont itemWithString:@"0" target:self selector:nil];
    [item2 setFontSize:20];
    item3=[CCMenuItemFont itemWithString:@"0" target:self selector:nil];
    [item3 setFontSize:20];
    item4=[CCMenuItemFont itemWithString:@"0" target:self selector:nil];
    [item4 setFontSize:20];
    item5=[CCMenuItemFont itemWithString:@"0" target:self selector:nil];
    [item5 setFontSize:20];
    item6=[CCMenuItemFont itemWithString:@"0" target:self selector:nil];
    [item6 setFontSize:20];
 
    soldierMenus = [CCMenu menuWithItems:item1, item2, item3, item4, item5, item6, nil];
    
    [soldierMenus  alignItemsVertically];
    [soldierMenus setPosition:ccp(70, mobileDisplaySize.height*.9)];
    
    return soldierMenus;
    
}

-(void) setSoldierinWave:(id) soldierType{
    CCMenuItemFont *menuItem = (CCMenuItemFont*)soldierType;
    
    if ([menuItem.label.string isEqualToString:@"Soldier A"]) {
        counterA++;
        [item1 setString:[NSString stringWithFormat:@"%d", counterA]];
        NSString* wave= [gameStatusEssentialsSingleton currentWave];
        NSMutableDictionary * tempdictonary=[[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] objectForKey:wave];
        CCLOG(@"mente %@",[tempdictonary objectForKey:@"SA"]);
        [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterA] forKey:@"SA"];
        CCLOG(@"%@",[tempdictonary objectForKey:@"SA"]);
        [[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] setObject:tempdictonary forKey:wave];
    }else if([menuItem.label.string isEqualToString:@"Soldier B"]){
        counterB++;
        [item2 setString:[NSString stringWithFormat:@"%d", counterB]];
        NSString* wave= [gameStatusEssentialsSingleton currentWave];
        NSMutableDictionary * tempdictonary=[[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] objectForKey:wave];
        CCLOG(@"mente %@",[tempdictonary objectForKey:@"SB"]);
        [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterB] forKey:@"SB"];
        CCLOG(@"%@",[tempdictonary objectForKey:@"SB"]);
        [[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] setObject:tempdictonary forKey:wave];
    }else if([menuItem.label.string isEqualToString:@"Soldier C"]){
        counterC++;
        [item3 setString:[NSString stringWithFormat:@"%d", counterC]];
        NSString* wave= [gameStatusEssentialsSingleton currentWave];
        NSMutableDictionary * tempdictonary=[[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] objectForKey:wave];
        CCLOG(@"mente %@",[tempdictonary objectForKey:@"SC"]);
        [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterC] forKey:@"SC"];
        CCLOG(@"%@",[tempdictonary objectForKey:@"SC"]);
        [[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] setObject:tempdictonary forKey:wave];
    }else if([menuItem.label.string isEqualToString:@"Soldier D"]){
        counterD++;
        [item4 setString:[NSString stringWithFormat:@"%d", counterD]];
        NSString* wave= [gameStatusEssentialsSingleton currentWave];
        NSMutableDictionary * tempdictonary=[[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] objectForKey:wave];
        CCLOG(@"mente %@",[tempdictonary objectForKey:@"SD"]);
        [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterD] forKey:@"SD"];
        CCLOG(@"%@",[tempdictonary objectForKey:@"SD"]);
        [[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] setObject:tempdictonary forKey:wave];
    }else if([menuItem.label.string isEqualToString:@"Soldier E"]){
        counterE++;
        [item5 setString:[NSString stringWithFormat:@"%d", counterE]];
        NSString* wave= [gameStatusEssentialsSingleton currentWave];
        NSMutableDictionary * tempdictonary=[[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] objectForKey:wave];
        CCLOG(@"mente %@",[tempdictonary objectForKey:@"SE"]);
        [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterE] forKey:@"SE"];
        CCLOG(@"%@",[tempdictonary objectForKey:@"SE"]);
        [[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] setObject:tempdictonary forKey:wave];
    }else if([menuItem.label.string isEqualToString:@"Soldier F"]){
        counterF++;
        [item6 setString:[NSString stringWithFormat:@"%d", counterF]];
        NSString* wave= [gameStatusEssentialsSingleton currentWave];
        NSMutableDictionary * tempdictonary=[[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] objectForKey:wave];
        CCLOG(@"mente %@",[tempdictonary objectForKey:@"SF"]);
        [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterF] forKey:@"SF"];
        CCLOG(@"%@",[tempdictonary objectForKey:@"SF"]);
        [[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] setObject:tempdictonary forKey:wave];
    }
    
}



-(void)dealloc{
    [super dealloc];
}

@end
