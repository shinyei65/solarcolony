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

static const int origin_X_ForName = -55;
static const int origin_Y_ForName = 66;
static const int nameYDistance = 28;

@implementation Friends{
    CCMenu *mainMenu;
}
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
    mainMenu=[CCMenu menuWithItems: nil];
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
    
    for (int i =0 ; i < [[PlayerInfo Player].friends count]; i++) {

            
            CCLOG(@"new friend: %@", [[PlayerInfo Player].friends objectAtIndex:i]);
            

            CCMenuItemFont *newFriend = [CCMenuItemFont itemWithString:[[PlayerInfo Player].friends objectAtIndex:i]];
            [mainMenu addChild:newFriend z:4];
            CCLOG(@"new friend: %@", [[PlayerInfo Player].friends objectAtIndex:i]);
            newFriend.fontName = @"Outlier.ttf";
            newFriend.fontSize = 20;
            [newFriend.label setColor:ccc3(200, 200, 230)];
            newFriend.position = ccp(origin_X_ForName, origin_Y_ForName - nameYDistance*[[PlayerInfo Player].friends count]);
            

    }
    
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
        BOOL exist = [[NetWorkManager NetWorkManager] checkUser:textfield.text];
        if(!exist){
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"The player name doesn't exist!" message:@"Please enter friends's name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
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
        else{
            if([[PlayerInfo Player].friends containsObject:textfield.text]){
                UIAlertView *existAlert = [[UIAlertView alloc] initWithTitle:@"The friend is already in your friend list" message:@"" delegate:self cancelButtonTitle:@"Confirm" otherButtonTitles:Nil, nil];
                [existAlert show];
                [existAlert release];
            }
            else{
                CCMenuItemFont *newFriend = [CCMenuItemFont itemWithString:textfield.text];
                CCLOG(@"new friend: %@", textfield.text);
                newFriend.fontName = @"Outlier.ttf";
                newFriend.fontSize = 20;
                [newFriend.label setColor:ccc3(200, 200, 230)];
                CCLOG(@"\nnumber of friends: %d",[[PlayerInfo Player].friends count]);
                newFriend.position = ccp(origin_X_ForName, origin_Y_ForName - nameYDistance*[[PlayerInfo Player].friends count]);
                [mainMenu addChild:newFriend z:4];
                [[PlayerInfo Player].friends addObject:textfield.text];
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[PlayerInfo Player]];
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"playerInfo"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    }
    
    
}


@end
