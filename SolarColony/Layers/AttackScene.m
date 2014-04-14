//
//  AttackScene.m
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "AttackScene.h"

static const int origin_X_ForName = 18;
static const int origin_Y_ForName = 66;
static const int nameYDistance = 28;

@implementation AttackScene{
    NSMutableArray* friends;
    int seletedFrd;
    CCMenu *mainMenu;
}
@synthesize mobileDisplaySize;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AttackScene *layer = [AttackScene node];
    
    AttackScene *selectlayer = [AttackScene node];
	
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
        networkManager = [NetWorkManager NetWorkManager];
        friends = [[NSUserDefaults standardUserDefaults]  objectForKey:@"friends"];
        seletedFrd = [friends count];
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        
        int *army_num = 1;
       // [splash setPosition:ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5)];
        CCSprite *bg = [CCSprite spriteWithFile:@"AttackPage_wallpaper.jpg"];
        bg.position = ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5);
        [self addChild:bg];

        [self addChild:[self loadMenu]];
    }
    return self;
}




- (CCMenu*)loadMenu
{
    
    
    
    
    CCMenuItemFont *menuItemArmy1=[CCMenuItemFont itemWithString:@"Army 1" target:self selector:@selector(moveToScene:)];
    menuItemArmy1.position = ccp(-200, 0);
    [menuItemArmy1 setFontSize:20];

    CCMenuItem *attackBotton=[CCMenuItemImage itemWithNormalImage:@"attackBotton.png" selectedImage:@"attackBotton_select.png" target:self selector:@selector(sendAttack)];
    attackBotton.position = ccp(200, 0);
    CCMenuItemFont *menuItemBack=[CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(moveToScene:)];
    menuItemBack.position = ccp(200, -140);
    
    CCMenuItemImage *FriendsMenu = [CCMenuItemImage itemWithNormalImage:@"friend_menu_clipped.png" selectedImage:@"friend_menu_clipped.png"];
    CCMenuItemImage *bar1 = [CCMenuItemImage itemWithNormalImage:@"friend_bar.png" selectedImage:@"friend_bar.png" target:self selector:@selector(selectFriend:)];
    CCMenuItemImage *bar2 = [CCMenuItemImage itemWithNormalImage:@"friend_bar.png" selectedImage:@"friend_bar.png" target:self selector:@selector(selectFriend:)];
    CCMenuItemImage *bar3 = [CCMenuItemImage itemWithNormalImage:@"friend_bar.png" selectedImage:@"friend_bar.png" target:self selector:@selector(selectFriend:)];
    CCMenuItemImage *bar4 = [CCMenuItemImage itemWithNormalImage:@"friend_bar.png" selectedImage:@"friend_bar.png" target:self selector:@selector(selectFriend:)];
    CCMenuItemImage *bar5 = [CCMenuItemImage itemWithNormalImage:@"friend_bar.png" selectedImage:@"friend_bar.png" target:self selector:@selector(selectFriend:)];
    CCMenuItemImage *bar6 = [CCMenuItemImage itemWithNormalImage:@"friend_bar.png" selectedImage:@"friend_bar.png" target:self selector:@selector(selectFriend:)];
    CCMenuItemImage *bar7 = [CCMenuItemImage itemWithNormalImage:@"friend_bar.png" selectedImage:@"friend_bar.png" target:self selector:@selector(selectFriend:)];
    CCMenuItemImage *bar8 = [CCMenuItemImage itemWithNormalImage:@"friend_bar.png" selectedImage:@"friend_bar.png" target:self selector:@selector(selectFriend:)];
    //[CCMenuItemImage itemWithNormalImage:<#(NSString *)#> selectedImage:<#(NSString *)#> target:self selector:(selectFriend)]
    
    FriendsMenu.position = ccp(20,-33);
    FriendsMenu.opacity = 200;
    bar1.scale = 1.2;
    bar1.tag = 0;
    bar2.scale = 1.2;
    bar2.tag = 1;
    bar3.scale = 1.2;
    bar3.tag = 2;
    bar4.scale = 1.2;
    bar4.tag = 3;
    bar5.scale = 1.2;
    bar5.tag = 4;
    bar6.scale = 1.2;
    bar6.tag = 5;
    bar7.scale = 1.2;
    bar7.tag = 6;
    bar8.scale = 1.2;
    bar8.tag = 7;
    
    bar1.position = ccp(origin_X_ForName,origin_Y_ForName);
    bar2.position = ccp(origin_X_ForName,origin_Y_ForName-nameYDistance);
    bar3.position = ccp(origin_X_ForName,origin_Y_ForName-nameYDistance*2);
    bar4.position = ccp(origin_X_ForName,origin_Y_ForName-nameYDistance*3);
    bar5.position = ccp(origin_X_ForName,origin_Y_ForName-nameYDistance*4);
    bar6.position = ccp(origin_X_ForName,origin_Y_ForName-nameYDistance*5);
    bar7.position = ccp(origin_X_ForName,origin_Y_ForName-nameYDistance*6);
    bar8.position = ccp(origin_X_ForName,origin_Y_ForName-nameYDistance*7);
    
    mainMenu=[CCMenu menuWithItems:menuItemArmy1,attackBotton,menuItemBack,nil];
    
    [mainMenu addChild:FriendsMenu z:2];
    [mainMenu addChild:bar1 z:1];
    [mainMenu addChild:bar2 z:1];
    [mainMenu addChild:bar3 z:1];
    [mainMenu addChild:bar4 z:1];
    [mainMenu addChild:bar5 z:1];
    [mainMenu addChild:bar6 z:1];
    [mainMenu addChild:bar7 z:1];
    [mainMenu addChild:bar8 z:1];
    
    

    for (int i =0 ; i < [friends count]; i++) {
        
        CCMenuItemFont *newFriend = [CCMenuItemFont itemWithString:[friends objectAtIndex:i]];
        [mainMenu addChild:newFriend z:4];
        newFriend.fontName = @"Outlier.ttf";
        newFriend.fontSize = 20;
        [newFriend.label setColor:ccc3(200, 200, 230)];
        newFriend.position = ccp(origin_X_ForName, origin_Y_ForName - nameYDistance*i);
        
        
    }

    
    [mainMenu setPosition:ccp( mobileDisplaySize.width/2, mobileDisplaySize.height/2)];
    
    return mainMenu;
    
}

-(void)sendAttack{
    Army* test;
    [[NetWorkManager NetWorkManager] sendAttackRequest:test];
    CCLOG(@"SEND ATTACK!!!");
    }

-(void)moveToScene:(id)sender{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    if ([menuItem.label.string isEqualToString:@"Back"]) {
        [transitionManagerSingleton transitionTo:1];
    } else if ([menuItem.label.string isEqualToString:@"Army 1"]) {
        [transitionManagerSingleton transitionTo:9];
    }

}
                     
-(void)selectFriend:(id)sender{
    NSLog(@"selected!!!");
    CCMenuItemImage *temp = (CCMenuItemImage*)sender;
    if (temp.tag < [friends count]) {
        CCSprite *newimg = [CCSprite spriteWithTexture:[[CCSprite spriteWithFile:@"friend_bar_sel.png"]texture]];
        CCSprite *newimg_sel = [CCSprite spriteWithTexture:[[CCSprite spriteWithFile:@"friend_bar_sel.png"]texture]];
        [temp setNormalImage:newimg];
        [temp setSelectedImage:newimg_sel];
        
        for (CCMenuItemImage *recover in mainMenu.children) {
            if (recover.tag == seletedFrd) {
                CCSprite *newimg = [CCSprite spriteWithTexture:[[CCSprite spriteWithFile:@"friend_bar.png"]texture]];
                CCSprite *newimg_sel = [CCSprite spriteWithTexture:[[CCSprite spriteWithFile:@"friend_bar.png"]texture]];
                [recover setNormalImage:newimg];
                [recover setSelectedImage:newimg_sel];
            }
        }
        seletedFrd = temp.tag;
        NSLog(@"seletedFrd: %d",seletedFrd);
    }
}
                     

-(void)AddNewItem:(id)sender{
    
}



- (void)dealloc
{
    [super dealloc];
    
}



@end
