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
    int map[GridMapWidth][GridMapHeight];
}

#pragma mark - Create and Destroy

+ (instancetype) map
{
    return [[self alloc] init];
}

- (instancetype) init
{
    self = [super init];
    
    // initialize map array with default value -1
    for(int i=0; i<GridMapWidth; i++){
        for(int j=0; j<GridMapHeight; j++){
            map[i][j] = -1;
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

- (void) setTower:(int) val X:(int) x Y:(int) y
{
    map[x][y] = val;
}

- (BOOL) hasTowerAtX:(int) x Y:(int) y
{
    if(map[x][y] == -1)
        return FALSE;
    else
        return TRUE;
}

- (int) getTowerAtX:(int) x Y:(int) y
{
    return map[x][y];
}

@end
