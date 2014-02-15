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


static BOOL BGon = YES;

@interface MusicManagerSingleton : NSObject {
    NSMutableDictionary *EffectDic;
    
}

+(MusicManagerSingleton *)shareSoundManager;

-(id)init;
-(void) preLoadBackGroundMusic:(NSString *)filename fileExt:(NSString *)theFileExt;
-(void) BackGroundMusic;
-(void) preLoadEffect:(NSString *)filename fileExt:(NSString *)theFileExt;
-(void) EffectMusic:(int)EffectState;

-(void) SetBackgroundVolume:(ALfloat)theVolume;
-(void) ShutDownManager;


@end

