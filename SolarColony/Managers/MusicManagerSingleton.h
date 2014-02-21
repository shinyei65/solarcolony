//
//  MusicManager.h
//  SolarColony
//
//  Created by Serena Wu on 2/14/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//
#import "SimpleAudioEngine.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <openal/al.h>
#import <OpenAL/alc.h>

#import <Foundation/Foundation.h>
#import "cocos2d.h"




@interface MusicManagerSingleton : NSObject {
    NSMutableArray *EffectArray;
    bool isPlayingSound;
    bool isBackGround;
}

+(id)shareSoundManager;

-(id)init;
-(void) playBackGroundMusic;
-(void) pauseBackGroundMusic;
-(void) resumeEffect;
-(void) playEffect:(NSString*)filePath;
-(void) pauseEffect;
-(void) preLoadEffect;
-(BOOL)isMusicButton;
-(BOOL)isSoundButton;
@end

