//
//  Friends.m
//  SolarColony
//
//  Created by Po-Yi Lee on 2/8/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "Friends.h"
#import "HomeScene.h"
#import "TowerHuman.h"

@implementation Friends
@synthesize mobileDisplaySize;


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Friends *layer = [Friends node];
	
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
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        CCSprite *bg = [CCSprite spriteWithFile:@"universe-wallpaper1.jpg"];
        bg.position = ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5);
        [self addChild:bg];
        [self addChild:[self loadMenu]];
        


    }
    return self;
}

- (CCMenu*)loadMenu
{
    CCMenuItemFont *menuItemBack=[CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(moveToScene:)];
    CCMenuItemFont *frd1 = [CCMenuItemFont itemWithString:@"Jimmy"];
    frd1.fontName = @"Outlier.ttf";
    frd1.fontSize = 20;
    [frd1.label setColor:ccc3(200, 200, 230)];
    menuItemBack.tag=1;
    CCMenuItemImage *FriendsMenu = [CCMenuItemImage itemWithNormalImage:@"friend_menu_clipped.png" selectedImage:@"friend_menu_clipped.png"];
    CCMenuItemImage *bar1 = [CCMenuItemImage itemWithNormalImage:@"friend_bar.png" selectedImage:@"friend_bar.png"];
    CCMenuItemImage *bar2 = [CCMenuItemImage itemWithNormalImage:@"friend_bar.png" selectedImage:@"friend_bar.png"];
    CCMenuItemImage *bar3 = [CCMenuItemImage itemWithNormalImage:@"friend_bar.png" selectedImage:@"friend_bar.png"];
    CCMenuItemImage *bar4 = [CCMenuItemImage itemWithNormalImage:@"friend_bar.png" selectedImage:@"friend_bar.png"];
    CCMenuItemImage *bar5 = [CCMenuItemImage itemWithNormalImage:@"friend_bar.png" selectedImage:@"friend_bar.png"];
    CCMenuItemImage *bar6 = [CCMenuItemImage itemWithNormalImage:@"friend_bar.png" selectedImage:@"friend_bar.png"];
    CCMenuItemImage *bar7 = [CCMenuItemImage itemWithNormalImage:@"friend_bar.png" selectedImage:@"friend_bar.png"];
    CCMenuItemImage *bar8 = [CCMenuItemImage itemWithNormalImage:@"friend_bar.png" selectedImage:@"friend_bar.png"];
    
    CCMenuItem *addFrdBotton=[CCMenuItemImage itemWithNormalImage:@"addFriend_button.png" selectedImage:@"addFriend_button_sel.png" target:self selector:@selector(addFriend)];
    CCMenu *mainMenu=[CCMenu menuWithItems: nil];
    [mainMenu addChild:addFrdBotton z:1];
    [mainMenu addChild:FriendsMenu z:2];
    [mainMenu addChild:menuItemBack z:1];
    [mainMenu addChild:bar1 z:3];
    [mainMenu addChild:bar2 z:3];
    [mainMenu addChild:bar3 z:3];
    [mainMenu addChild:bar4 z:3];
    [mainMenu addChild:bar5 z:3];
    [mainMenu addChild:bar6 z:3];
    [mainMenu addChild:bar7 z:3];
    [mainMenu addChild:bar8 z:3];
    [mainMenu addChild:frd1 z:4];
    
    addFrdBotton.position = ccp(-5,108);
    FriendsMenu.position = ccp(-13,-33);
    menuItemBack.position = ccp(200, -140);
    bar1.scale = 1.2;
    bar2.scale = 1.2;
    bar3.scale = 1.2;
    bar4.scale = 1.2;
    bar5.scale = 1.2;
    bar6.scale = 1.2;
    bar7.scale = 1.2;
    bar8.scale = 1.2;
    
    bar1.position = ccp(-15,10);
    frd1.position = ccp(-55,66);
    bar2.position = ccp(-15,-18);
    bar3.position = ccp(-15,-46);
    bar4.position = ccp(-15,-74);
    bar5.position = ccp(-15,-102);
    bar6.position = ccp(-15,-130);
    bar7.position = ccp(-15,-158);
    bar8.position = ccp(-15,-186);
    
    FriendsMenu.opacity = 200;
    //[mainMenu alignItemsVerticallyWithPadding:10];
    
    [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2)];

    
    return mainMenu;

}

-(void)moveToScene:(id)sender
{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    if ([menuItem.label.string isEqualToString:@"Back"]) {
        [transitionManagerSingleton transitionTo:1];
    }
}

- (void)dealloc
{
    [super dealloc];
}

-(void)addFriend{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Please enter friends's name" message:@"\n\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    myAlertView.tag = 0;
    myAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *myTextField = [myAlertView textFieldAtIndex:0];
    myTextField.placeholder=@"Player";
    [myTextField becomeFirstResponder];
    [myTextField setBackgroundColor:[UIColor whiteColor]];
    [myAlertView addSubview:myTextField];
    [myAlertView show];
    [myAlertView release];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==0 && buttonIndex == 1) {
        UITextField *textfield = [alertView textFieldAtIndex:0];
        BOOL empty = [[NetWorkManager NetWorkManager] signInUser:textfield.text];
        if(empty){
            UIAlertView *existAert = [[UIAlertView alloc] initWithTitle:@"" message:@"The player name doesn't exist!" delegate:self cancelButtonTitle:@"check" otherButtonTitles:nil];
            existAert.tag = 1;
   
            [existAert show];
            [existAert release];

        }
        else{
            
        }
    }
    
    else if (alertView.tag==1 && buttonIndex == 0){
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Please enter friends's name" message:@"\n\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
        myAlertView.tag = 0;
        myAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *myTextField = [myAlertView textFieldAtIndex:0];
        myTextField.placeholder=@"Player";
        [myTextField becomeFirstResponder];
        [myTextField setBackgroundColor:[UIColor whiteColor]];
        [myAlertView addSubview:myTextField];
        [myAlertView show];
        [myAlertView release];
    }
    
}


@end
