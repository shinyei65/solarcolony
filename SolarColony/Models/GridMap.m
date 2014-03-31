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
    CircleSliderButtonScene *_towermenu2;
    CGPoint _start;
    CGPoint _goal;
    
    //UI touch variable
    CGPoint _touchPREVIOUS;
    CGPoint _touchCURRENT;
    CGPoint _view_pos;
    CGFloat initialDistance;
    CGFloat zoomFactor;
    CCLabelTTF *message;
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
    self = [super init];
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
    //CCSprite *background = [CCSprite spriteWithFile:mapname];
    //background.anchorPoint = CGPointMake(0, 0);
    //[self addChild:background];
    self.tileMap = [CCTMXTiledMap tiledMapWithTMXFile:mapname];
    self.background = [_tileMap layerNamed:@"Background"];
    self.tileMap.anchorPoint = CGPointMake(0, 0);
    [self addChild:_tileMap z:-1];
    
    GridLinesLayer *lines = [GridLinesLayer layer];
    lines.anchorPoint = CGPointMake(0, 0);
    [self addChild:lines];
    
    // setup tower menu
    _towermenu2 = [CircleSliderButtonScene menu];
    [_towermenu2 setVisible: FALSE];
    [self addChild: _towermenu2 z:99];
    [self setTouchEnabled: YES];
    
    // set up message
    message = [CCLabelTTF labelWithString:@"AI Attck!!" fontName:@"Outlier.ttf" fontSize:15];
    [message setAnchorPoint:ccp(0.5,0.5)];
    [message setPosition: ccp(_screenSize.width*0.5,_screenSize.height*0.5)];
    [message setVisible:FALSE];
    [self addChild: message];
    
    // done
    return self;
}

- (void) showMessage: (NSString *) str
{
    [message setString:str];
    [message setVisible:TRUE];
    id delay = [CCDelayTime actionWithDuration: 1.0f];
    id wrapperAction = [CCCallFunc actionWithTarget:self selector:@selector(hideMessage)];
    id sequence = [CCSequence actions: delay, wrapperAction, nil];
    [self runAction:sequence];
}

- (void) hideMessage
{
    [message setVisible:FALSE];
}

- (void) dealloc
{
    [_towermenu2 release]; _towermenu2 = nil;
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

- (void) removeTower: (id) tower
{
    //[self removeChild:tower];
    [tower setVisible:false];
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
        CGPoint new_pos = self.position;
        CGFloat diff_x = _touchCURRENT.x - _touchPREVIOUS.x;
        CGFloat diff_y = _touchCURRENT.y - _touchPREVIOUS.y;
        // if outside of visible area, don't pan
        CGPoint view_bot_left = [self convertToNodeSpace:ccp(0,0)];
        CGPoint view_top_right = [self convertToNodeSpace:ccp(_screenSize.width, _screenSize.height)];
        CGPoint map_bot_left = [self convertToNodeSpace:ccp(self.position.x,self.position.y)];
        NSLog(@"GridMap: map_bot_left(%g,%g)", map_bot_left.x, map_bot_left.y);
        if (diff_x < 0) { // move left
            NSLog(@"GridMap: move left");
            // if top right of view still in the map area
            if(view_top_right.x < _screenSize.width)
                new_pos.x += diff_x;
        } else if (diff_x > 0) { // move right
            NSLog(@"GridMap: move right");
            // if bot left of view still in the map area
            if(view_bot_left.x > 0)
                new_pos.x += diff_x;
        }
        if (diff_y < 0) { // move down
            NSLog(@"GridMap: move down");
            // if top right of view still in the map area
            if(view_top_right.y < _screenSize.height)
                new_pos.y += diff_y;
        } else if (diff_y > 0) { // move up
            NSLog(@"GridMap: move up");
            // if bot left of view still in the map area
            if(view_bot_left.y > 0)
                new_pos.y += diff_y;
        }
        [self setPosition:new_pos];
    } else if ([touches count] == 2) {
        NSArray *twoTouch = [touches allObjects];
        
        UITouch *tOne = [twoTouch objectAtIndex:0];
        UITouch *tTwo = [twoTouch objectAtIndex:1];
        CGPoint firstTouch = [tOne locationInView:[tOne view]];
        CGPoint secondTouch = [tTwo locationInView:[tTwo view]];
        CGPoint pinchCenter = ccpMidpoint(firstTouch, secondTouch);
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
                //self.scale = zoomFactor;
                [self scale:zoomFactor scaleCenter:pinchCenter];
            }
            initialDistance = currentDistance;
        } else if (currentDistance - initialDistance < 0) {
            // zoom out
            if (self.scale >= 1.0f) {
                zoomFactor -= zoomFactor *0.05f;
                if(zoomFactor < 1.0f)
                    zoomFactor = 1.0f;
                //self.scale = zoomFactor;
                [self scale:zoomFactor scaleCenter:pinchCenter];
            }
            
            initialDistance = currentDistance;
        }
    }
}

- (void) scale:(CGFloat) newScale scaleCenter:(CGPoint) scaleCenter {
    // scaleCenter is the point to zoom to..
    // If you are doing a pinch zoom, this should be the center of your pinch.
    
    // Get the original center point.
    //CGPoint oldCenterPoint = ccp(scaleCenter.x * self.scale, scaleCenter.y * self.scale);
    
    // Set the scale.
    self.scale = newScale;
    
    // Get the new center point.
    //CGPoint newCenterPoint = ccp(scaleCenter.x * self.scale, scaleCenter.y * self.scale);
    
    // Then calculate the delta.
    //CGPoint centerPointDelta  = ccpSub(oldCenterPoint, newCenterPoint);
    
    // Now adjust your layer by the delta.
    //self.position = ccpAdd(self.position, centerPointDelta);
    
    // move the map back to view area
    CGPoint new_pos = self.position;
    CGPoint view_bot_left = [self convertToNodeSpace:ccp(0,0)];
    CGPoint view_top_right = [self convertToNodeSpace:ccp(_screenSize.width, _screenSize.height)];
    if(view_top_right.x > _screenSize.width)
        new_pos.x += (view_top_right.x - _screenSize.width);
    if(view_bot_left.x < 0)
        new_pos.x += view_bot_left.x;
    if(view_top_right.y > _screenSize.height)
        new_pos.y += (view_top_right.y - _screenSize.height);
    if(view_bot_left.y < 0)
        new_pos.y += view_bot_left.y;
    [self setPosition:new_pos];
}

- (void) selectCell: (CGPoint) index
{
    // hide tower menu if already selected
    if(!_selected){
        if(![self canBuildTowerAtX:index.x Y:index.y])
            return;
        CGPoint loc = [self convertMapIndexToGL:index];
        
        // move the anchor to menu center
        //CGSize menuSize = [_towermenu boundingBox].size;
        CGSize menuSize = [_towermenu2 boundingBox].size;
        //drop tower in middle box
        CGPoint locationItem = [self convertMapIndexToGL:index];
        //locationItem.x+= (menuSize.width*.33);
        locationItem.x+= (22);
        menuLocation=locationItem;
        
        CCLOG(@" location %f", [_towermenu2 getMapLocation].x);   //I just get location.x = 0
        CCLOG(@"menuSize.height %f", menuSize.height);   //I just get location.y = 0
        
        CCLOG(@"wEnd location.x %f", menuLocation.x);   //I just get location.x = 0
        CCLOG(@"wEnd location.y %f", menuLocation.y);   //I just get location.y = 0
        
        loc.x -= menuSize.width / 2;
        loc.y -= menuSize.height / 2;
        // move the menu to cell center
        loc.x += _width_step / 2;
        loc.y -= _height_step / 2;
        
        [_towermenu2 setMapLocation:index];
        [_towermenu2 setPosition: loc];
        [_towermenu2 setVisible: TRUE];
        
        _selected = TRUE;
    }else{
        [self hideTowerMenu];
    }
}
//hide tower menu
- (void) hideTowerMenu
{
    [_towermenu2 setVisible: FALSE];
    _selected = FALSE;
}
//return tower menu
- (CircleSliderButtonScene*) getTowerMenu{
    return _towermenu2;
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
