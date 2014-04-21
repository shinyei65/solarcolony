//
//  MusicManagerSingleton.m
//  SolarColony
//
//  Created by Serena Wu on 2/14/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "MusicManagerSingleton.h"

@interface MusicManagerSingleton (private)
-(BOOL)initOpenAL;
-(NSUInteger)nextSource;
-(AudioFileID) openAudioFile:(NSString *)theFilePath;
-(UInt32)FileSize:(AudioFileID)fileDescriptor;

@end

@implementation MusicManagerSingleton
static int musicNum = 5;
static MusicManagerSingleton *shareSoundManager = nil;

+(MusicManagerSingleton *)shareSoundManager{
    
    
    if(shareSoundManager == nil)
    {
        shareSoundManager = [[super allocWithZone:NULL]init];
    }
    return shareSoundManager;
}





-(id)init
{
    if(self = [super init])
    {
        NSString* BGStr = @"Military_Might.mp3";
        EffectArray = [[NSMutableArray alloc]init];
        [self preLoadEffect];
        [[SimpleAudioEngine sharedEngine]preloadBackgroundMusic:BGStr];
        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:BGStr];
        [[SimpleAudioEngine sharedEngine]setBackgroundMusicVolume:0.5];
        
        isPlayingSound=true;
        isBackGround = true;
        
    }
    return self;
    
}
-(void) playBackGroundMusic{
    [[SimpleAudioEngine sharedEngine]resumeBackgroundMusic];
    isBackGround = true;
}
-(void) pauseBackGroundMusic{
    [[SimpleAudioEngine sharedEngine]pauseBackgroundMusic];
    isBackGround = false;
}




-(void) preLoadEffect{
    for(int i = 1 ; i <= musicNum ; i++){
        NSString* musicName = [[NSString stringWithFormat:@"sound %d", i] stringByAppendingString:@".wav"];
        [[SimpleAudioEngine sharedEngine]preloadEffect:musicName];
        [EffectArray addObject:musicName];
    }
}

-(void) pauseEffect{
    for (int i = 0 ; i < [EffectArray count] ; i++)
    {
        NSString* musicName =(NSString*)[EffectArray objectAtIndex:i];
        [[SimpleAudioEngine sharedEngine] unloadEffect:musicName];
        
        isPlayingSound=false;
    }
    
    
}
-(void) resumeEffect{
    for (int i = 0 ; i < [EffectArray count] ; i++)
    {
        
        [[SimpleAudioEngine sharedEngine] resumeEffect:[[EffectArray objectAtIndex:i] intValue]];
            isPlayingSound = TRUE;
    }

}
-(void) playEffect:(NSString*)filePath {
    if(isPlayingSound)
    {
        
        [[SimpleAudioEngine sharedEngine]playEffect:filePath];
    }
    else{
        [self pauseEffect];
    }
}

-(BOOL)isSoundButton{
    bool buttonOn;
    buttonOn = isPlayingSound;
    return buttonOn;
}

-(BOOL)isMusicButton{
    bool buttonOn;
    buttonOn = isBackGround;
    return buttonOn;
}


-(void)dealloc
{
    
    [super dealloc];
}

// We don't want to allocate a new instance, so return the current one.
+ (id)allocWithZone:(NSZone*)zone {
    return [[self shareSoundManager] retain];
}

// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

// Once again - do nothing, as we don't have a retain counter for this object.
- (id)retain {
    return self;
}

// Replace the retain counter so we can never release this object.
- (NSUInteger)retainCount {
    return NSUIntegerMax;
}


//Do nothing, other than return the shared instance - as this is expected from autorelease.
- (id)autorelease {
    return self;
}


@end
