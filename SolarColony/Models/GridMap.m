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
    CGSize _screenSize;
    float _width_step;
    float _height_step;
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
    
    _screenSize = [[CCDirector sharedDirector] winSize];
    _width_step = _screenSize.width/GridMapWidth;
    _height_step = _screenSize.height/GridMapHeight;
    
    // initialize map array with default status 'X'
    for(int i=0; i<GridMapWidth; i++){
        for(int j=0; j<GridMapHeight; j++){
            _map[i][j] = 'X';
        }
    }
    
    [self setTouchEnabled: YES];
    
    // done
    return self;
}

- (void) dealloc
{
    [super dealloc];
    [self release];
}

#pragma mark - operation of map

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

- (CGPoint) convertToMapIndex: (CGPoint) loc
{
    loc.x = floor(loc.x / _width_step);
    loc.y = floor((_screenSize.height - loc.y) / _height_step);
    return loc;
}

#pragma mark - UI control

- (void) draw
{
    // draw a grid
    for(int i=0; i<=_width_step; i++){
        ccDrawLine(ccp(i * _width_step, 0), ccp(i * _width_step, _screenSize.height));
    }
    for(int i=0; i<=_height_step; i++){
        ccDrawLine(ccp(0, i * _height_step), ccp(_screenSize.width, i * _height_step));
    }
}

- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInView:[touch view]];
    loc = [self convertToMapIndex:[[CCDirector sharedDirector] convertToGL:loc]];
    NSLog(@"Cell(%g,%g)", loc.x, loc.y);
}

- (void) selectCell: (CGPoint) index
{
    
}

@end
