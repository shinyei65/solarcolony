//
//  SoldiersLayer.m
//  SolarColony
//
//  Created by Po-Yi Lee on 3/7/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "SoldiersLayer.h"
#import "WavesLayer.h"

@implementation SoldiersLayer{
    int wave_sol[8][3];
    int cur_wave;
}
@synthesize mobileDisplaySize;

-(id)init{
    
    if(self=[super init]){
        
        //Game status global variables
        gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
        //SETS UP COUNTER FOR SOLIDERS;
        //add
/*        if(gameStatusEssentialsSingleton.getSoldierInit == false)
        {
            counterA=0;
            counterB=0;
            counterC=0;
            //CCLOG(@"Initialization %i",counterA);
            
            gameStatusEssentialsSingleton.soldierInit = true;
        }
        else{
            counterA = gameStatusEssentialsSingleton.GetCounterA;
            wave_sol[cur_wave][0] = counterA;
            counterB = gameStatusEssentialsSingleton.GetCounterB;
            wave_sol[cur_wave][1] = counterB;
            counterC = gameStatusEssentialsSingleton.GetCounterC;
            wave_sol[cur_wave][2] = counterC;
            
        }
 */
        CCLOG(@"Initialization %i",wave_sol[cur_wave][0]);
        
        [self addChild:[self loadWave]];
        [self addChild:[self loadMutablesoldierMenuNumber]];
        //[self addChild:SoldierMenu];
        
    }
    return self;
}


-(CCMenu*) loadWave{
    CCMenuItemFont *soldierA=[CCMenuItemFont itemWithString:@"Soldier A" target:self selector:@selector(setSoldierinWave:)];
    CCMenuItemFont *soldierB=[CCMenuItemFont itemWithString:@"Soldier B" target:self selector:@selector(setSoldierinWave:)];
    CCMenuItemFont *soldierC=[CCMenuItemFont itemWithString:@"Soldier C" target:self selector:@selector(setSoldierinWave:)];
    
    
    [soldierA setFontSize:20];
    [soldierB setFontSize:20];
    [soldierC setFontSize:20];
    
    CCMenu *SoldierMenu = [CCMenu menuWithItems:soldierA, soldierB, soldierC, nil];
    [SoldierMenu  alignItemsVertically];
    [SoldierMenu setPosition:ccp(0, mobileDisplaySize.height*.9)];
    
    return SoldierMenu;
}


-(CCMenu*) loadMutablesoldierMenuNumber{
    item1=[CCMenuItemFont itemWithString:[NSString stringWithFormat:@"%i", counterA] target:self selector:nil];
    [item1 setFontSize:20];
    item2=[CCMenuItemFont itemWithString:[NSString stringWithFormat:@"%i", counterB] target:self selector:nil];
    [item2 setFontSize:20];
    item3=[CCMenuItemFont itemWithString:[NSString stringWithFormat:@"%i", counterC] target:self selector:nil];
    [item3 setFontSize:20];
    
    //add
    //For increasing
    item4=[CCMenuItemFont itemWithString:@"+" target:self selector:@selector(setSoldierinWave:)];
    [item4 setFontSize:20];
    
    item5=[CCMenuItemFont itemWithString:@"+" target:self selector:@selector(setSoldierinWave:)];
    [item5 setFontSize:20];
    
    item6=[CCMenuItemFont itemWithString:@"+" target:self selector:@selector(setSoldierinWave:)];
    [item6 setFontSize:20];
    
    //For decreasing
    item7=[CCMenuItemFont itemWithString:@"-" target:self selector:@selector(setSoldierinWave:)];
    [item7 setFontSize:20];
    
    item8=[CCMenuItemFont itemWithString:@"-" target:self selector:@selector(setSoldierinWave:)];
    [item8 setFontSize:20];
    
    item9=[CCMenuItemFont itemWithString:@"-" target:self selector:@selector(setSoldierinWave:)];
    [item9 setFontSize:20];
    
    soldierMenus = [CCMenu menuWithItems:item4,item1,item7,item5, item2,item8,item6, item3,item9, nil];
    
    [soldierMenus alignItemsInColumns:[NSNumber numberWithInt:3],[NSNumber numberWithInt:3],[NSNumber numberWithInt:3],nil];
    
    //[soldierMenus  alignItemsVertically];
    [soldierMenus setPosition:ccp(70, mobileDisplaySize.height*.9)];
    
    return soldierMenus;
    
}

-(void) setSoldierNumber:(id) soldierType{
    CCMenuItemFont *menuItem = (CCMenuItemFont*)soldierType;
    
    //add....
    if (menuItem == item4) {
        wave_sol[cur_wave][0]++;
        counterA++;
    }
    if (menuItem == item7) {
        if(counterA >0)
        {
            wave_sol[cur_wave][0]--;
            counterA--;
            
        }
    }
    [item1 setString:[NSString stringWithFormat:@"%d", counterA]];
    NSString* wave= [gameStatusEssentialsSingleton currentWave];
    NSMutableDictionary * tempdictonary=[[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] objectForKey:wave];
    CCLOG(@"mente %@",[tempdictonary objectForKey:@"SA"]);
    [tempdictonary setObject:[NSString stringWithFormat:@"%d", counterA] forKey:@"SA"];
    CCLOG(@"%@",[tempdictonary objectForKey:@"SA"]);
    [[gameStatusEssentialsSingleton.armynetwork waveComplexStructure] setObject:tempdictonary forKey:wave];
    if([menuItem.label.string isEqualToString:@"Soldier B"]){
        wave_sol[cur_wave][1]++;
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
    //add
    gameStatusEssentialsSingleton.counterA = counterA;
    gameStatusEssentialsSingleton.counterB = counterB;
    gameStatusEssentialsSingleton.counterC = counterC;
}

- (void) AddWave: (int) waveID
{
    cur_wave = waveID;
    counterA = wave_sol[cur_wave][0];
    counterB = wave_sol[cur_wave][1];
    [item1 setString:[NSString stringWithFormat:@"%d", wave_sol[cur_wave][0]]];
    [item2 setString:[NSString stringWithFormat:@"%d", wave_sol[cur_wave][1]]];
}

-(void)dealloc{
    [super dealloc];
}

@end
