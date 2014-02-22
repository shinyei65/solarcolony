//
//  DefenseSettingsScene.m
//  SolarColony
//
//  Created by Student on 2/20/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "DefenseSettingsScene.h"
#import "CCScrollLayer.h"

@implementation DefenseSettingsScene
@synthesize mobileDisplaySize;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	DefenseSettingsScene *layer = [DefenseSettingsScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        transitionManagerSingleton=[TransitionManagerSingleton sharedInstance];
        
        CCLabelTTF *splash = [CCLabelTTF labelWithString:@"Select tower" fontName:@"Marker Felt" fontSize:32];
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        
        [splash setPosition:ccp(mobileDisplaySize.width*.3, mobileDisplaySize.height*.95)];
        
        [self addChild:splash];
        [self addChild:[self scrollLayer]];
        [self addChild:[self loadMenu]];
        [self addChild:[self loadMutableTowersMenu]];
      //  [self addChild:[self loadSelectorTowersMenu]];
        
    }
    return self;
}

- (CCMenu*)loadMenu
{
    CCMenuItemFont *manuItemStart=[CCMenuItemFont itemWithString:@"back" target:self selector:@selector(moveToScene:)];
    
    CCMenu *mainMenu=[CCMenu menuWithItems:manuItemStart, nil];
    
    [mainMenu alignItemsHorizontallyWithPadding:20];
    
    [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2 - 50)];
    
    return mainMenu;
    
}

-(CCMenu*) loadMutableTowersMenu{
    item1=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(setTowerofTypes:)];
    item2=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(setTowerofTypes:)];
    item3=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(setTowerofTypes:)];
    item4=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(setTowerofTypes:)];
    item5=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(setTowerofTypes:)];
    item6=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(setTowerofTypes:)];
    item7=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(setTowerofTypes:)];
    item8=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(setTowerofTypes:)];
    item9=[CCMenuItemFont itemWithString:@" " target:self selector:@selector(setTowerofTypes:)];
    CCMenu *towerMenus = [CCMenu menuWithItems:item1, item2, item3, item4, item5, item6, item7, item8, item9, nil];
    
    [towerMenus  alignItemsInGridWithPadding:ccp(25, 25) columns:3];
    [towerMenus setPosition:ccp( mobileDisplaySize.width*.4, mobileDisplaySize.height*.4)];
    
    return towerMenus;
   
}

-(CCMenu*) loadSelectorTowersMenu{
    CCMenuItemFont *Titem1=[CCMenuItemFont itemWithString:@"TowerA" target:self selector:@selector(setTowerofType:)];
    CCMenuItemFont *Titem2=[CCMenuItemFont itemWithString:@"TowerB" target:self selector:@selector(setTowerofType:)];
    CCMenuItemFont *Titem3=[CCMenuItemFont itemWithString:@"TowerC" target:self selector:@selector(setTowerofType:)];
    CCMenuItemFont *Titem4=[CCMenuItemFont itemWithString:@"TowerD" target:self selector:@selector(setTowerofType:)];
    CCMenuItemFont *Titem5=[CCMenuItemFont itemWithString:@"TowerE" target:self selector:@selector(setTowerofType:)];
    CCMenuItemFont *Titem6=[CCMenuItemFont itemWithString:@"TowerF" target:self selector:@selector(setTowerofType:)];
    CCMenuItemFont *Titem7=[CCMenuItemFont itemWithString:@"TowerG" target:self selector:@selector(setTowerofType:)];
  
    CCMenu *towerMenus = [CCMenu menuWithItems:Titem1, Titem2, Titem3, Titem4, Titem5, Titem6, Titem7,  nil];
    
    [towerMenus  alignItemsVertically];
    
    [towerMenus setPosition:ccp( mobileDisplaySize.width*.8, mobileDisplaySize.height*.3)];
    
    return towerMenus;
    
}

- (void) setTowerofType:(id) towerType{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)towerType;
    CCLOG(@"clicke**");
    if ([menuItem.label.string isEqualToString:@"TowerA"]) {
        [item1 setString:@"TowerA"];
    } else if ([menuItem.label.string isEqualToString:@"TowerB"]) {
        [item2 setString:@"TowerB"];
    } else if ([menuItem.label.string isEqualToString:@"TowerC"]) {
        [item3 setString:@"TowerC"];
    } else if ([menuItem.label.string isEqualToString:@"TowerD"]) {
        [item4 setString:@"TowerD"];
    } else if ([menuItem.label.string isEqualToString:@"TowerE"]) {
        [item5 setString:@"TowerE"];
    } else if ([menuItem.label.string isEqualToString:@"TowerF"]) {
        [item6 setString:@"TowerF"];
    } else if ([menuItem.label.string isEqualToString:@"TowerG"]) {
        [item7 setString:@"TowerG"];
    }
}

// Creates new Scroll Layer with pages returned from scrollLayerPages.
- (CCScrollLayer *) scrollLayer
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    // Create the scroller and pass-in the pages (set widthOffset to 0 for fullscreen pages).
    CCScrollLayer *scroller = [CCScrollLayer nodeWithLayers: [self scrollLayerPages] widthOffset: 0.48f * screenSize.width ];
    scroller.pagesIndicatorPosition = ccp(screenSize.width * 0.5f, screenSize.height - 30.0f);
    
    // New feature: margin offset - to slowdown scrollLayer when scrolling out of it contents.
    // Comment this line or change marginOffset to screenSize.width to disable this effect.
    scroller.marginOffset = 0.5f * screenSize.width;
    
    return scroller;
}

// Returns array of CCLayers - pages for ScrollLayer.
- (NSArray *) scrollLayerPages
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    // PAGE 1 - Simple Label in the center.
    CCLayer *page4= [CCLayer node];
    [page4 addChild:[self getMenuForTower:@"TowerA" Location:ccp( screenSize.width *.7 , screenSize.height/2 )]];
    // PAGE 2 - Simple Label in the center.
    CCLayer *page5= [CCLayer node];
    [page5 addChild:[self getMenuForTower:@"TowerB" Location:ccp( screenSize.width *.7 , screenSize.height/2 )]];
    // PAGE 3 - Simple Label in the center.
    CCLayer *page6=[CCLayer node];
    [page6 addChild:[self getMenuForTower:@"TowerC" Location:ccp( screenSize.width *.7 , screenSize.height/2 )]];
    // PAGE 4 - Simple Label in the center.
    CCLayer *page7=[CCLayer node];
    [page7 addChild:[self getMenuForTower:@"TowerD" Location:ccp( screenSize.width *.7 , screenSize.height/2 )]];
    // PAGE 5 - Simple Label in the center.
    CCLayer *page8=[CCLayer node];
    [page8 addChild:[self getMenuForTower:@"TowerE" Location:ccp( screenSize.width *.7 , screenSize.height/2 )]];
    // PAGE 6 - Simple Label in the center.
    CCLayer *page9=[CCLayer node];
    [page9 addChild:[self getMenuForTower:@"TowerF" Location:ccp( screenSize.width *.7 , screenSize.height/2 )]];
    // PAGE 7 - Simple Label in the center.
    CCLayer *page10=[CCLayer node];
    [page10 addChild:[self getMenuForTower:@"TowerG" Location:ccp( screenSize.width *.7 , screenSize.height/2 )]];
 
    return [NSArray arrayWithObjects: page4,page5,page6,page7,page8,page9,page10,nil];
}



- (CCMenu*) getMenuForTower:(NSString*) titlePage  Location: (CGPoint) location{
    //Sets  selector for each type of tower created in menu
   // CCLabelTTF *labelTwo = [CCLabelTTF labelWithString:titlePage fontName:@"Marker Felt" fontSize:44];
    CCMenuItemFont *titem = [CCMenuItemFont itemWithString:titlePage target:self selector:@selector(setTowerofType:)];
    CCMenu *menu = [CCMenu menuWithItems: titem,  nil];
    [menu alignItemsVertically];
    menu.position = location;
    return menu;
}

-(void)moveToScene:(id)sender{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    if ([menuItem.label.string isEqualToString:@"back"]) {
        [transitionManagerSingleton transitionTo:1];
    }      
}

- (void)dealloc
{
    [super dealloc];
    
}



@end
