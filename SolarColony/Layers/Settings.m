//
//  Settings.m
//  SolarColony
//
//  Created by Po-Yi Lee on 2/10/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "Settings.h"
#import "HomeScene.h"
#import "SimpleAudioEngine.h"

@implementation Settings
@synthesize mobileDisplaySize;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Settings *layer = [Settings node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    self = [super init];
    if (self) {
        transitionManagerSingleton=[TransitionManagerSingleton sharedInstance];
        musicManagerSingleton = [MusicManagerSingleton shareSoundManager];
        
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        
        
        [self addChild:[self loadMenu]];
    }
    return self;
}
- (CCMenu*)loadMenu
{
    
    
    CCMenuItemFont *menuItemAccount=[CCMenuItemFont itemWithString:@"Account"];
    menuItemAccount.tag=1;
    
    CCMenuItemFont *menuItemMusic=[CCMenuItemFont itemWithString:@"Music"];
    menuItemMusic.tag=2;
  /*  MusicOn = [[CCMenuItemImage itemFromNormalImage:@"soundOn.png"
                                       selectedImage:@"soundOn.png" target:nil selector:nil]retain];
    
    
    MusicOff = [[CCMenuItemImage itemFromNormalImage:@"soundOff.png"
                                        selectedImage:@"soundOff.png" target:nil selector:nil]retain];
    CCMenuItemToggle *musicToggleItem = [CCMenuItemToggle itemWithTarget:self
                                                                selector:@selector(MusicButtonTapped:)
                                                                   items:MusicOn, MusicOff, nil];
   */
    
    CCMenuItemFont *menuItemSound=[CCMenuItemFont itemWithString:@"Sound"];
    menuItemSound.tag=3;
    _SoundOn = [CCMenuItemImage itemFromNormalImage:@"soundOn.png" selectedImage:@"soundOn.png" target:nil selector:nil];
    _SoundOff = [CCMenuItemImage itemFromNormalImage:@"soundOff.png" selectedImage:@"soundOff.png" target:nil selector:nil];
    CCMenuItemToggle *soundToggleItem = [CCMenuItemToggle itemWithTarget:self
                                                                selector:@selector(SoundButtonTapped:)
                                                                   items:_SoundOn, _SoundOff, nil];
    
    CCMenuItemFont *menuItemBack=[CCMenuItemFont itemWithString:@"Back"
                                                         target:self selector:@selector(moveToScene:)];
    menuItemBack.tag=4;
    
    //CCMenu *mainMenu=[CCMenu menuWithItems: menuItemAccount, menuItemMusic, musicToggleItem, menuItemSound, soundToggleItem, menuItemBack, nil];
    //CCMenu *mainMenu=[CCMenu menuWithItems: menuItemAccount, menuItemMusic, musicToggleItem, menuItemBack, nil];
    CCMenu *mainMenu=[CCMenu menuWithItems: menuItemAccount, menuItemSound, soundToggleItem, menuItemBack, nil];
    
    
    [mainMenu alignItemsInColumns:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:1], nil];
    //[mainMenu alignItemsVerticallyWithPadding:20];
    
    [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2 - 50)];
    
          return mainMenu;
    
}

-(void)moveToScene:(id)sender
{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    if ([menuItem.label.string isEqualToString:@"Back"]) {
        [transitionManagerSingleton transitionTo:4];
    }
}

-(void) MusicButtonTapped: (id)sender
{
    CCMenuItemToggle *menu = (CCMenuItemToggle *)sender;
    if(menu.selectedItem == MusicOn){
        [[SimpleAudioEngine sharedEngine]resumeBackgroundMusic];
    }
    else if(menu.selectedItem == MusicOff){
        [[SimpleAudioEngine sharedEngine]pauseBackgroundMusic];
    }
    
}
-(void) SoundButtonTapped: (id)sender
{
    CCMenuItemToggle *menu = (CCMenuItemToggle *)sender;
    if(menu.selectedItem == _SoundOn){
        [musicManagerSingleton resumeEffect];
    }
    else if(menu.selectedItem == _SoundOff){
        [musicManagerSingleton pauseEffect];
    }
    
}

- (void)dealloc
{
  
   [super dealloc];
}



@end
