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
    NSMutableArray* Armys;
    int seletedFrd;
    int army_num;
    CCMenu *mainMenu;
    CCMenu *ArmyList;
}
@synthesize mobileDisplaySize;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AttackScene *layer = [AttackScene node];
	
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
        
        //Game status global variables
        gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
        networkManager = [NetWorkManager NetWorkManager];
        friends = [[NSUserDefaults standardUserDefaults]  objectForKey:@"friends"];
        seletedFrd = -2;
        mobileDisplaySize= [[CCDirector sharedDirector] winSize];
        if(gameStatusEssentialsSingleton.getArmyFirstVisit == true)
        {
            Armys = gameStatusEssentialsSingleton.ArmySettings;
            army_num = 1;
            [Armys addObject:[self CreateArmy]];
            gameStatusEssentialsSingleton.ArmyFirstVisit = false;
        }
        else{
            Armys = gameStatusEssentialsSingleton.ArmySettings;
            army_num = [gameStatusEssentialsSingleton.ArmySettings count] + 1;
        }

        CCSprite *bg = [CCSprite spriteWithFile:@"AttackPage_wallpaper.jpg"];
        bg.position = ccp(mobileDisplaySize.width*.5, mobileDisplaySize.height*.5);
        [self addChild:bg];

        [self addChild:[self loadMenu]];
        [self addChild:[self loadArmyList]];
    }
    return self;
}

- (CCMenu*)loadArmyList{
    NSMutableArray* Army_arr = [NSMutableArray array];
    //Plus button
    CCMenuItem *addItemButton = [CCMenuItemImage itemWithNormalImage:@"AddButton.png" selectedImage:@"AddButton_select.png" target:self selector:@selector(AddNewItem)];
    /*[Army_arr addObject:addItemButton];
    
    for(int i = 0 ; i <= [Armys count]; i++){
        i++;
        CCMenuItemFont *menuItemArmy=[CCMenuItemFont itemWithString:[NSString stringWithFormat:@"Army %d",i] target:self selector:@selector(moveToScene:)];
        [menuItemArmy setFontSize:20];
        [Army_arr addObject:menuItemArmy];
    }
    */
    CCMenuItemFont *menuItemArmy=[CCMenuItemFont itemWithString:[NSString stringWithFormat:@"Army %d",1] target:self selector:@selector(moveToScene:)];
    [menuItemArmy setFontSize:20];
    [Army_arr addObject:menuItemArmy];
    ArmyList = [CCMenu menuWithArray:Army_arr];
    [ArmyList alignItemsVertically];
    [ArmyList setPosition:ccp(mobileDisplaySize.width/2 - 150, mobileDisplaySize.height/2) ];
    return ArmyList;
    
}



- (CCMenu*)loadMenu
{

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
    
    mainMenu=[CCMenu menuWithItems:attackBotton,menuItemBack,nil];
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
    if (seletedFrd >= 0 && seletedFrd < [friends count]) {
        Army* test;
        [[NetWorkManager NetWorkManager] sendAttackRequest:test attackTarget:[friends objectAtIndex:seletedFrd]];
        //CCLOG(@"SEND ATTACK!!!");
    }
}

-(void)moveToScene:(id)sender{
    CCMenuItemFont* menuItem = (CCMenuItemFont*)sender;
    gameStatusEssentialsSingleton.ArmySettings = Armys;
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
        
        if (temp.tag == seletedFrd) {
            CCSprite *newimg = [CCSprite spriteWithTexture:[[CCSprite spriteWithFile:@"friend_bar.png"]texture]];
            CCSprite *newimg_sel = [CCSprite spriteWithTexture:[[CCSprite spriteWithFile:@"friend_bar.png"]texture]];
            [temp setNormalImage:newimg];
            [temp setSelectedImage:newimg_sel];
            seletedFrd = -2;
        }
        else{
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
        }
        NSLog(@"seletedFrd: %d",seletedFrd);
    }
}

-(ArmySetting*)CreateArmy{
    ArmySetting* createArmy = [[ArmySetting alloc]initArmy:army_num];
    army_num++;
    return createArmy;
}
                     

-(void)AddNewItem{
    NSString *ArmyItemStr =[NSString stringWithFormat:@"Army %i",army_num];
    CCMenuItemFont* ArmyNum = [CCMenuItemFont itemWithString: ArmyItemStr target:self selector:@selector(setSoldierinWave:)];
    ArmyNum.tag = army_num;
    [ArmyNum setFontSize:20];
    [ArmyNum setZOrder:2];
    [ArmyList addChild:ArmyNum];
    [ArmyList alignItemsVertically];
    [Armys addObject:[self CreateArmy]];
}



- (void)dealloc
{
    [super dealloc];
    
}



@end

@implementation ArmySetting {
    int index;
    NSMutableArray *_list;
}
+ (instancetype) setting: (int) idx
{
    return [[self alloc] initArmy:idx];
}

- (instancetype) initArmy:(int)idx
{
    self = [super init];
    if (!self) return(nil);
    index = idx;
    _list = [[NSMutableArray alloc] init];
    return self;
}
-(NSMutableArray*) getList{
    return _list;
}
@end
