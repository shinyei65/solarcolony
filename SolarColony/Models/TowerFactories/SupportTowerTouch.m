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
        raceType=gameStatusEssentialsSingleton.raceType;
    }
    return self;
}

#pragma mark - UI control

- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInView:[touch view]];
    CGPoint drop = [touch locationInView:[touch view]];
    // calculate select cell
    drop = [self convertToWorldSpaceAR:[[CCDirector sharedDirector] convertToGL:loc]];
    CGRect towerBounding;
   
    CCLOG(@"printing fine");
    for (TowerGeneric* tower in gameStatusEssentialsSingleton.towers) {
        CGPoint dropTest = [self convertToWorldSpace:[[CCDirector sharedDirector] convertToGL:ccp([tower getBoundingBoxTower].origin.x,[tower getBoundingBoxTower].origin.y)]];
        towerBounding=CGRectMake(dropTest.x, dropTest.y, [tower getBoundingBoxTower].size.width, [tower getBoundingBoxTower].size.width);
        CCLOG(@"--------printing LOS AT %f %f",loc.x,loc.y);
        //CCLOG(@"--------printing CONVERTED LOS AT %f %f",drop.x,drop.y);
        //CCLOG(@"--------printing TOWER TAT LOS AT %f %f",[tower getBoundingBoxTower].origin.x,[tower getBoundingBoxTower].origin.y);
        CCLOG(@"--------printing TOWER TAT LOS AT %f %f",dropTest.x,dropTest.y);
        // if (CGRectContainsPoint([tower getBoundingBoxTower], loc )) {
           if (CGRectContainsPoint(towerBounding, loc )) {
               //CCLOG(@"***************** CONTAINS TOWER *****************");
               //isUpgradable=true;
               [tower setMenuUpgradeVisible:true];
               centerTower=loc;
               
               if([raceType isEqualToString:@"Robot"]){
                   // ABILITY FOR ROBOT
                  /* if ([tower towerTowerId]==3) {
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
                   }*/
               }else if([raceType isEqualToString:@"Magic"]){
                   // ABILITY FOR WIZARD
                /*   if ([tower towerTowerId]==6) {
                       towerHelper=tower;
                       [tower setActionTowerLocation:[tower getBoundingBoxTower].origin];
                   } else {
                      for (TowerGeneric* towerSearchIndex in gameStatusEssentialsSingleton.towers) {
                           if ([towerHelper isEqual:towerSearchIndex]) {
                              
                               [tower beignHealed];
                           }
                       }
                   }*/
               }else if([raceType isEqualToString:@"Human"]){
                   // ABILITY FOR HUMAN
                   /*if ([tower towerTowerId]==9) {
                       towerHelper=tower;
                       [tower setActionTowerLocation:[tower getBoundingBoxTower].origin];
                   } else {
                       for (TowerGeneric* towerSearchIndex in gameStatusEssentialsSingleton.towers) {
                           if (towerHelper == towerSearchIndex) {
                               [tower setTowerPower:[towerSearchIndex selectAction]];
                           }
                       }
                   }*/
               }
         
           }else{
               [tower setMenuUpgradeVisible:false];
               isUpgradable=FALSE;
           }
       }
    
}



-(void) draw {
    if (isUpgradable)
    {
        ccDrawColor4F(150, 100, 150, 255);
        CGPoint center = centerTower;
        CGFloat radius = 70.f;
        CGFloat angle = 0.f;
        NSInteger segments = 6;
        BOOL drawLineToCenter = NO;
        
        ccDrawCircle(center, radius, angle, segments, drawLineToCenter);
    }
}



- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
 
}

- (void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
 
   
}
@end
