//
//  GridMap.m
//  SolarColony
//
//  Created by Student on 2/7/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//
//
//
//

#import "GridMap.h"
#import "ModelsConstants.h"

@implementation GridMap
{
    char _map [GridMapWidth][GridMapHeight];
}

#pragma mark - Create and Destroy

+ (instancetype) map
{
    return [[self alloc] init];
}

- (instancetype) init
{
    self = [super init];
    if (!self) return(nil);
    
    // initialize map array with default status 'X'
    for(int i=0; i<GridMapWidth; i++){
        for(int j=0; j<GridMapHeight; j++){
            _map[i][j] = 'X';
        }
    }
    
    // done
    return self;
}

- (void) dealloc
{
    [super dealloc];
    [self release];
}

#pragma mark - operation of map array

- (void) setMap:(char) status X:(int) x Y:(int) y
{
    _map[x][y] = status;
}

- (char) getStatusAtX:(int) x Y:(int) y
{
    return _map[x][y];
}

- (BOOL) canBuildTowerAtX:(int) x Y:(int) y
{
    if(_map[x][y] == CLOSED || _map[x][y] == UNAVAILABLE)
        return FALSE;
    else
        return TRUE;
}

- (BOOL) canPassAtX:(int) x Y:(int) y
{
    if(_map[x][y] == CLOSED || _map[x][y] == TOWER)
        return FALSE;
    else
        return TRUE;
}

- (void) draw
{
    // draw a grid
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    int width_step = screenSize.width/GridMapWidth;
    int height_step = screenSize.height/GridMapHeight;
    for(int i=0; i<=width_step; i++){
        ccDrawLine(ccp(i * width_step, 0), ccp(i * width_step, screenSize.height));
    }
    for(int i=0; i<=height_step; i++){
        ccDrawLine(ccp(0, i * height_step), ccp(screenSize.width, i * height_step));
    }
}

@end
