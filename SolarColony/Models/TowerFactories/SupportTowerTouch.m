//
//  SupportTowerTouch.m
//  SolarColony
//
//  Created by Student on 4/6/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "SupportTowerTouch.h"


@implementation SupportTowerTouch

- (id)init
{
    self = [super init];
    if (self) {
        [self setTouchEnabled: YES];
          gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
        
    }
    return self;
}

#pragma mark - UI control

- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInView:[touch view]];
    // calculate select cell
    //loc = [self convertToNodeSpace:[[CCDirector sharedDirector] convertToGL:loc]];
   
   
    CCLOG(@"printing fine");
    for (TowerGeneric* tower in gameStatusEssentialsSingleton.towers) {
    
           
           if (CGRectContainsPoint([tower getBoundingBoxTower], loc )) {
                CCLOG(@"CONTAINS TOWER*****************");
              
               if ([tower towerTowerId]==3) {
                   towerHelper=tower;
                    [tower setActionTowerLocation:[tower getBoundingBoxTower].origin];
               } else {
                   [tower setPosition:[towerHelper getLocation]];
                   [tower setLocation:[towerHelper getLocation]];
                    for (TowerGeneric* tower in gameStatusEssentialsSingleton.towers) {
                        if ([towerHelper isEqual:tower]) {
                            [tower setActionTowerLocation:loc];
                            [tower selectAction];
                        }
                    }
                   towerHelper=nil;
               }
               
           }else{
            //CCLOG(@"--------printing fine LOS AT %f %f",loc.x,loc.y);
             //  CCLOG(@"--------printing TOWER TAT LOS AT %f %f",[tower getBoundingBoxTower].origin.x,[tower getBoundingBoxTower].origin.y);
           }
       }
       
    
}

- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
 
}

- (void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
 
   
}
@end
