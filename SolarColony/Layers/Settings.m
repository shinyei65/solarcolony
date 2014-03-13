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
        
        CCSprite *bg = [CCSprite spriteWithFile:@"universe-wallpaper5.jpg"];
        bg.position = ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5);
        [self addChild:bg];
        
        [self addChild:[self loadMenu]];
        
    }
    return self;
}
- (CCMenu*)loadMenu
{
    
    CCMenuItemToggle *soundToggleItem;
    CCMenuItemToggle *musicToggleItem;
    CCMenuItemFont *menuItemAccount=[CCMenuItemFont itemWithString:@"Account"];
    menuItemAccount.tag=1;
    
    CCMenuItemFont *menuItemMusic=[CCMenuItemFont itemWithString:@"Music"];
    menuItemMusic.tag=2;
    
    MusicOn = [[CCMenuItemImage itemWithNormalImage:@"On.png"
                                      selectedImage:@"On.png" target:nil selector:nil]retain];
    
    
    MusicOff = [[CCMenuItemImage itemWithNormalImage:@"Off.png"
                                       selectedImage:@"Off.png" target:nil selector:nil]retain];
    if([musicManagerSingleton isMusicButton]){
        musicToggleItem = [CCMenuItemToggle itemWithTarget:self
                                                  selector:@selector(MusicButtonTapped:)
                                                     items:MusicOn, MusicOff, nil];
    }
    else{
        musicToggleItem = [CCMenuItemToggle itemWithTarget:self
                                                  selector:@selector(MusicButtonTapped:)
                                                     items:MusicOff, MusicOn, nil];
    }
    
    
    
    CCMenuItemFont *menuItemSound=[CCMenuItemFont itemWithString:@"Sound"];
    menuItemSound.tag=3;
    
    _SoundOn = [CCMenuItemImage itemWithNormalImage:@"On.png" selectedImage:@"On.png" target:nil selector:nil];
    _SoundOff = [CCMenuItemImage itemWithNormalImage:@"Off.png" selectedImage:@"Off.png" target:nil selector:nil];
    if([musicManagerSingleton isSoundButton]){
        soundToggleItem = [CCMenuItemToggle itemWithTarget:self
                                                  selector:@selector(SoundButtonTapped:)
                                                     items:_SoundOn, _SoundOff, nil];
    }
    else{
        soundToggleItem = [CCMenuItemToggle itemWithTarget:self
                                                  selector:@selector(SoundButtonTapped:)
                                                     items:_SoundOff, _SoundOn, nil];
    }
    CCMenuItemFont *menuItemWeb = [CCMenuItemFont itemWithString:@"Visit Us" target:self selector:@selector(moveToWeb:)];
    CCMenuItemFont *menuItemBack=[CCMenuItemFont itemWithString:@"Back"
                                                         target:self selector:@selector(moveToScene:)];
    menuItemBack.tag=4;
    
    CCMenu *mainMenu=[CCMenu menuWithItems: menuItemAccount, menuItemMusic, musicToggleItem, menuItemSound, soundToggleItem, menuItemWeb, menuItemBack, nil];
    
    
    [mainMenu alignItemsInColumns:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:1],[NSNumber numberWithInt:1], nil];
    
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
-(void)moveToWeb:(id)sender{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    if ([menuItem.label.string isEqualToString:@"Visit Us"]) {
        
        
        NSURL *url = [ [ NSURL alloc ] initWithString: @"http://www-scf.usc.edu/~sophiawu"];
        [[UIApplication sharedApplication] openURL:url];
    }
}


-(void) MusicButtonTapped: (id)sender
{
    CCMenuItemToggle *menu = (CCMenuItemToggle *)sender;
    if(menu.selectedItem == MusicOn){
        
        [musicManagerSingleton playBackGroundMusic];
        
    }
    else if(menu.selectedItem == MusicOff){
        [musicManagerSingleton pauseBackGroundMusic];
        
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
