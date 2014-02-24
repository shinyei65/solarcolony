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
#import "GameStatusEssentialsSingleton.h"


@implementation GridMap
{
    char _map[GridMapWidth][GridMapHeight];
    float _width_step;
    float _height_step;
    BOOL _selected;
    BOOL _isMoved;
    CGSize _screenSize;
    TowerMenu *_towermenu;
    CGPoint _start;
    CGPoint _goal;
    
    //UI touch variable
    CGPoint _touchPREVIOUS;
    CGPoint _touchCURRENT;
    CGPoint _view_pos;
    CGFloat initialDistance;
    CGFloat zoomFactor;
}
@synthesize menuLocation;
static GridMap *sharedInstance = nil;

#pragma mark - Create and Destroy

+ (GridMap *) map
{
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

- (instancetype) init
{
    self = [super initWithColor:ccc4(0, 153, 0, 255)];
    if (!self) return(nil);
    
    _screenSize = [[CCDirector sharedDirector] winSize];
    _width_step = _screenSize.width/GridMapWidth;
    _height_step = _screenSize.height/GridMapHeight;
    _selected = FALSE;
    _isMoved = FALSE;
    initialDistance = 0;
    zoomFactor = 1;
    _view_pos = ccp(0,0);
    
    // initialize map array with default status 'X'
    /*for(int i=0; i<GridMapWidth; i++){
        for(int j=0; j<GridMapHeight; j++){
            _map[i][j] = 'X';
        }
    }*/
    
    // initialize map from file
    NSString *mapname = [[GameStatusEssentialsSingleton sharedInstance] getGameMapName];
    NSString *txtFilePath = [[NSBundle mainBundle] pathForResource:mapname ofType:@"txt"];
    NSString *contents = [NSString stringWithContentsOfFile:txtFilePath encoding:NSUTF8StringEncoding error:nil];
    NSArray* allLinedStrings = [contents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    for(int i=0; i<[allLinedStrings count]; i++){
        NSString* line = [allLinedStrings objectAtIndex:i];
        //NSLog(@"line: %@", line);
        if(i == 0){
            NSArray *listItems = [line componentsSeparatedByString:@", "];
            _start = ccp([[listItems objectAtIndex:0] integerValue], [[listItems objectAtIndex:1] integerValue]);
            continue;
        }
        for(int j=0; j<GridMapWidth; j++){
            _map[j][i-1] = [line characterAtIndex:j];
            if(_map[j][i-1] == GOAL)
                _goal = ccp(i-1, j);
        }
    }
    mapname = [[GameStatusEssentialsSingleton sharedInstance] getGameMapImagename];
    CCSprite *background = [CCSprite spriteWithFile:mapname];
    background.anchorPoint = CGPointMake(0, 0);
    [self addChild:background];
    
    GridLinesLayer *lines = [GridLinesLayer layer];
    lines.anchorPoint = CGPointMake(0, 0);
    [self addChild:lines];
    
    // setup tower menu
    _towermenu = [TowerMenu menu];
    [_towermenu setVisible: FALSE];
    [self addChild: _towermenu z:99];
    [self setTouchEnabled: YES];
    
    
    // done
    return self;
}

- (void) dealloc
{
    [_towermenu release]; _towermenu = nil;
    [self release];
    [super dealloc];
}

#pragma mark - operation of map

- (CGPoint) getStartIndex
{
    return _start;
}

- (CGPoint) getGoalIndex
{
    return _goal;
}

- (void) addTower: (id) tower index: (CGPoint) idx z: (NSInteger) z
{
    [self setMap:TOWER X:idx.x Y:idx.y];
    [self addChild: tower z: z];
}

- (CGSize) getCellSize
{
    return CGSizeMake(_width_step, _height_step);
}

- (char) getFullMap
{
    return _map;
}
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
    if(_map[x][y] == EMPTY)
        return TRUE;
    else
        return FALSE;
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
- (CGPoint) convertMapIndexToGL: (CGPoint) index
{
    index.x = index.x * _width_step;
    index.y = (GridMapHeight - index.y) * _height_step;
    return index;
}
- (CGPoint) convertMapIndexToCenterGL: (CGPoint) index
{
    index.x = index.x * _width_step;
    index.y = (GridMapHeight - index.y) * _height_step;
    CGSize cellSize = [self getCellSize];
    index.x += cellSize.width / 2;
    index.y -= cellSize.height / 2;
    return index;
}
- (BOOL) isIndexInsideMap: (CGPoint) index
{
    if(index.x < 0 || index.x >= GridMapWidth)
        return FALSE;
    else if(index.y < 0 || index.y >= GridMapHeight)
        return FALSE;
    else
        return TRUE;
}

#pragma mark - UI control

- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([touches count] == 1) {
        // stored touch loc
        UITouch *touch = [touches anyObject];
        _touchCURRENT = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
        _touchPREVIOUS = _touchCURRENT;
        CGPoint world_pos = [self convertToNodeSpace:ccp(0,0)];
        CGPoint top_right = [self convertToNodeSpace:ccp([self boundingBox].size.width,[self boundingBox].size.height)];
        NSLog(@"GridMap: top_right(%g,%g)", top_right.x, top_right.y);
        NSLog(@"GridMap: world_pos(%g,%g)", world_pos.x, world_pos.y);
        NSLog(@"GridMap: self(%g,%g)", self.position.x, self.position.y);
    }else if([touches count] == 2) {
        // Get points of both touches
        NSArray *twoTouch = [touches allObjects];
        UITouch *tOne = [twoTouch objectAtIndex:0];
        UITouch *tTwo = [twoTouch objectAtIndex:1];
        CGPoint firstTouch = [tOne locationInView:[tOne view]];
        CGPoint secondTouch = [tTwo locationInView:[tTwo view]];
        
        // Find the distance between those two points
        initialDistance = sqrt(pow(firstTouch.x - secondTouch.x, 2.0f) + pow(firstTouch.y - secondTouch.y, 2.0f));
        NSLog(@"GridMap: two fingers touch began! initD=%f",initialDistance);
    }
}

- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([touches count] == 1) {
        if(!_isMoved){
            UITouch *touch = [touches anyObject];
            CGPoint loc = [touch locationInView:[touch view]];
            // calculate select cell
            loc = [self convertToNodeSpace:[[CCDirector sharedDirector] convertToGL:loc]];
            loc = [self convertToMapIndex:loc];
            if([self isIndexInsideMap:loc]){
                //NSLog(@"Cell(%g,%g)", loc.x, loc.y);
                [self selectCell: loc];
            }
        }else{
            _isMoved = FALSE;
        }
    }
}

- (void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] == 1) {
        _isMoved = TRUE;
        // calcualte move distane
        UITouch *touch = [touches anyObject];
        _touchPREVIOUS = _touchCURRENT;
        _touchCURRENT = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
        CGPoint prev_pos = self.position;
        CGPoint new_pos = self.position;
        CGFloat diff_x = _touchCURRENT.x - _touchPREVIOUS.x;
        CGFloat diff_y = _touchCURRENT.y - _touchPREVIOUS.y;
        // if outside of visible area, don't pan
        CGPoint node_pos = [self convertToWorldSpace:ccp(0,0)];
        CGPoint view_bot_left = [self convertToNodeSpace:ccp(0,0)]; // view bot left
        CGPoint map_top_right = [self convertToNodeSpace:ccp([self boundingBox].size.width,[self boundingBox].size.height)];
        //NSLog(@"GridMap: view_bot_left(%g,%g)", view_bot_left.x, view_bot_left.y);
        //NSLog(@"GridMap: node_pos(%g,%g)", node_pos.x, node_pos.y);
        //NSLog(@"GridMap: prev_pos(%g,%g)", prev_pos.x, prev_pos.y);
        //NSLog(@"GridMap: new_pos(%g,%g)", new_pos.x, new_pos.y);
        //NSLog(@"GridMap: diff(%g,%g)", [self boundingBox].size.width, [self boundingBox].size.height);
        if (diff_x < 0) { // move left
            NSLog(@"GridMap: move left");
            NSLog(@"GridMap: view_bot_left(%g,%g)", view_bot_left.x, view_bot_left.y);
            NSLog(@"GridMap: map_top_right(%g,%g)", map_top_right.x, map_top_right.y);
            if((view_bot_left.x+_screenSize.width) < map_top_right.x)
                new_pos.x += diff_x;
        } else if (diff_x > 0) { // move right
            NSLog(@"GridMap: move right");
        }
        if (diff_y < 0) { // move down
            NSLog(@"GridMap: move down");
        } else if (diff_y > 0) { // move up
            NSLog(@"GridMap: move up");
        }
        /*if(world_pos.x < 0)
            pos.x = prev_pos.x - node_pos.x;
        else if(world_pos.x > (top_right.x-_screenSize.width))
            pos.x -= world_pos.x;
        if(world_pos.y < 0)
            pos.y += world_pos.y;
        else if(world_pos.y >= (top_right.y-_screenSize.height))
            pos.y += world_pos.y;*/
        [self setPosition:new_pos];
    } else if ([touches count] == 2) {
        NSArray *twoTouch = [touches allObjects];
        
        UITouch *tOne = [twoTouch objectAtIndex:0];
        UITouch *tTwo = [twoTouch objectAtIndex:1];
        CGPoint firstTouch = [tOne locationInView:[tOne view]];
        CGPoint secondTouch = [tTwo locationInView:[tTwo view]];
        CGFloat currentDistance = sqrt(pow(firstTouch.x - secondTouch.x, 2.0f) + pow(firstTouch.y - secondTouch.y, 2.0f));
        if (initialDistance == 0) {
            initialDistance = currentDistance;
            // set to 0 in case the two touches weren't at the same time
        } else if (currentDistance - initialDistance > 0) {
            // zoom in
            if (self.scale < 2.0f) {
                zoomFactor += zoomFactor *0.05f;
                if(zoomFactor > 2.0f)
                    zoomFactor = 2.0f;
                self.scale = zoomFactor;
            }
            // Still To Do - make view centered on pinch
            CGPoint world_pos = [self convertToNodeSpace:ccp(0,0)];
            initialDistance = currentDistance;
        } else if (currentDistance - initialDistance < 0) {
            // zoom out
            if (self.scale >= 1.0f) {
                zoomFactor -= zoomFactor *0.05f;
                if(zoomFactor < 1.0f)
                    zoomFactor = 1.0f;
                self.scale = zoomFactor;
            }
            
            initialDistance = currentDistance;
        }
    }
}

- (void) selectCell: (CGPoint) index
{
    // hide tower menu if already selected
    if(!_selected){
        if(![self canBuildTowerAtX:index.x Y:index.y])
            return;
        CGPoint loc = [self convertMapIndexToGL:index];
        
        // move the anchor to menu center
        CGSize menuSize = [_towermenu boundingBox].size;
        
        //drop tower in middle box
        CGPoint locationItem = [self convertMapIndexToGL:index];
        locationItem.x+= (menuSize.width*.33);
        menuLocation=locationItem;
               
        CCLOG(@"wEnd location.x %f", menuLocation.x);   //I just get location.x = 0
        CCLOG(@"wEnd location.y %f", menuLocation.y);   //I just get location.y = 0
        
        loc.x -= menuSize.width / 2;
        loc.y -= menuSize.height / 2;
        // move the menu to cell center
        loc.x += _width_step / 2;
        loc.y -= _height_step / 2;
        [_towermenu setMapLocation:index];
        [_towermenu setPosition: loc];
        [_towermenu setVisible: TRUE];
        
        _selected = TRUE;
    }else{
        [self hideTowerMenu];
    }
}
//hide tower menu
- (void) hideTowerMenu
{
    [_towermenu setVisible: FALSE];
    _selected = FALSE;
}
//return tower menu
- (TowerMenu*) getTowerMenu{
    return _towermenu;
}

- (void)setTowerMenuPosition:(CGPoint) loc{
    menuLocation=loc;
}

- (CGPoint) getTowerMenuPosition{
    return menuLocation;
}

@end

@implementation GridLinesLayer {
    float _width_step;
    float _height_step;
    CGSize _screenSize;
}
+(instancetype) layer
{
    return [[self alloc] init];
}
-(instancetype) init
{
    self = [super init];
    if (!self) return(nil);
    _screenSize = [[CCDirector sharedDirector] winSize];
    _width_step = _screenSize.width/GridMapWidth;
    _height_step = _screenSize.height/GridMapHeight;
    return self;
}
- (void) draw
{
    [super draw];
    // draw a grid
    for(int i=0; i<=GridMapWidth; i++){
        ccDrawLine(ccp(i * _width_step, 0), ccp(i * _width_step, _screenSize.height));
    }
    for(int i=0; i<=GridMapHeight; i++){
        ccDrawLine(ccp(0, i * _height_step), ccp(_screenSize.width, i * _height_step));
    }
}
@end
