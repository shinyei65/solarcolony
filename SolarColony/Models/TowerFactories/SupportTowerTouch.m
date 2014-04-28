//
//  SupportTowerTouch.m
//  SolarColony
//
//  Created by Student on 4/6/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "SupportTowerTouch.h"
#import "CCParallaxNode-Extras.h"

@implementation SupportTowerTouch

- (id)init
{
    self = [super init];
    if (self) {
        [self setTouchEnabled: YES];
        gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
        raceType=gameStatusEssentialsSingleton.raceType;
        
        //items for the background
        // 1) Create the CCParallaxNode
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        _backgroundNode = [CCParallaxNode node];
        [self addChild:_backgroundNode z:-1];
        
        // 2) Create the sprites we'll add to the CCParallaxNode
        _spacedust1 = [CCSprite spriteWithFile:@"bg_front_spacedust.png"];
        _spacedust2 = [CCSprite spriteWithFile:@"bg_front_spacedust.png"];
        
        
        // 3) Determine relative movement speeds for space dust and background
        CGPoint dustSpeed = ccp(0.05, 0.1);
        
        // 4) Add children to CCParallaxNode
        [_backgroundNode addChild:_spacedust1 z:0 parallaxRatio:dustSpeed positionOffset:ccp(0,winSize.height/2)];
        [_backgroundNode addChild:_spacedust2 z:0 parallaxRatio:dustSpeed positionOffset:ccp(_spacedust1.contentSize.width,winSize.height/2)];
        
        isDroppingTower=false;
        
        [self schedule:@selector(tick:)interval:1/25];
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
        //CCLOG(@"--------printing LOS AT %f %f",loc.x,loc.y);
        //CCLOG(@"--------printing CONVERTED LOS AT %f %f",drop.x,drop.y);
        //CCLOG(@"--------printing TOWER TAT LOS AT %f %f",[tower getBoundingBoxTower].origin.x,[tower getBoundingBoxTower].origin.y);
        //CCLOG(@"--------printing TOWER TAT LOS AT %f %f",dropTest.x,dropTest.y);
        // if (CGRectContainsPoint([tower getBoundingBoxTower], loc )) {
        if (CGRectContainsPoint(towerBounding, loc )) {
            //CCLOG(@"***************** CONTAINS TOWER *****************");
            //isUpgradable=true;
            [tower setMenuUpgradeVisible:true];
            centerTower=loc;
            
            if([raceType isEqualToString:@"Robot"]){
                // ABILITY FOR ROBOT
                if ([tower towerTowerId]==3) {
                    if (![tower getReadySpecial]) {
                        [tower setReadySpecial:true];
                        isDroppingTower=true;
                        towerHelper=tower;
                        [tower setActionTowerLocation:[tower getBoundingBoxTower].origin];
                        break;
                    }else  {
                        [tower setReadySpecial:false];
                        isDroppingTower=false;
                    }
                } else if(isDroppingTower){
                    //tower moved
                    CGPoint maplocationSupport=tower.mapLocation;
                    CGPoint positionSupport=tower.position;
                    tower.mapLocation=towerHelper.mapLocation;
                    [tower setPosition:[towerHelper getLocation]];
                    [tower setLocation:[towerHelper getLocation]];
                
                    for (TowerGeneric* tower in gameStatusEssentialsSingleton.towers) {
                        //support
                        if ([towerHelper isEqual:tower]) {
                            /*[tower setActionTowerLocation:loc];
                             [tower selectAction];
                             [tower setIsDeath:true];
                             isDroppingTower=false;*/
                            tower.mapLocation=maplocationSupport;
                            [tower setActionTowerLocation:positionSupport];
                            [tower selectAction];
                            [tower setIsDeath:true];
                            isDroppingTower=false;
                            break;
                        }
                    }
                }
                
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


// Add new update method
- (void)tick:(ccTime)dt {
    
    CGPoint backgroundScrollVel = ccp(-1000, 0);
    _backgroundNode.position = ccpAdd(_backgroundNode.position, ccpMult(backgroundScrollVel, dt));
    
    spaceDusts = [NSArray arrayWithObjects:_spacedust1, _spacedust2, nil];
    for (CCSprite *spaceDust in spaceDusts) {
        if ([_backgroundNode convertToWorldSpace:spaceDust.position].x < -spaceDust.contentSize.width) {
            [_backgroundNode incrementOffset:ccp(2*spaceDust.contentSize.width,0) forChild:spaceDust];
        }
    }
    // [spaceDusts remo]
    
}

- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
}
@end
