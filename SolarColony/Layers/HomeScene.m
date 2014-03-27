//
//  HomeScene.m
//  SolarColony
//
//  Created by Student on 2/7/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "HomeScene.h"


@implementation HomeScene
@synthesize mobileDisplaySize;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HomeScene *layer = [HomeScene node];
	
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
        musicManagerSingleton = [MusicManagerSingleton shareSoundManager];
        player = [PlayerInfo Player];
        CCLabelTTF *splash = [CCLabelTTF labelWithString:@"Solar Colony" fontName:@"Marker Felt" fontSize:64];
        [splash setColor:ccc3(240,60,20)];
        
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        
        [splash setPosition:ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5+10)];
        
        CCSprite *bg = [CCSprite spriteWithFile:@"universe-wallpaper4.jpg"];
        bg.position = ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5);
    
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Player Name" message:@"\n\n\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Sign In", nil];
        
        UITextField *myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
        myTextField.placeholder=@"Enter User Name";
        [myTextField becomeFirstResponder];
        [myTextField setBackgroundColor:[UIColor whiteColor]];
        myTextField.textAlignment=UITextAlignmentCenter;
        
        // myTextField.layer.cornerRadius=5.0; Use this if you have added QuartzCore framework
        
        [myAlertView addSubview:myTextField];
        [myAlertView show];
        [myAlertView release];
        
        
        [self addChild:bg];
        
        [self addChild:splash];
        [self addChild:[self loadMenu]];
    }
    return self;
}

- (CCMenu*)loadMenu
{
    CCMenuItemImage *manuItemStart=[CCMenuItemImage itemWithNormalImage:@"StartGame.png" selectedImage:@"StartGame.png" target:self selector:@selector(moveToScene:)];
    manuItemStart.tag=1;
    
    CCMenuItemImage *manuItemSettings=[CCMenuItemImage itemWithNormalImage:@"Settings.png"
        selectedImage:@"Settings.png" target:self selector:@selector(moveToScene:)];
    manuItemSettings.tag=2;
    
    CCMenu *mainMenu=[CCMenu menuWithItems:manuItemStart,manuItemSettings, nil];
    
    [mainMenu alignItemsHorizontallyWithPadding:20];
    
    [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2 - 50)];
    
    return mainMenu;
    
}


-(void)moveToScene:(id)sender{
//    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    CCMenuItemImage* menuImage = (CCMenuItemImage*)sender;
    if (menuImage.tag == 1) {
         [transitionManagerSingleton transitionTo:2];
    } else if (menuImage.tag == 2)  {
         [transitionManagerSingleton transitionTo:7];
    }
   // NSLog(menuItem.label.string);

 }



- (void)dealloc
{
    [super dealloc];
    
}



@end
