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

static MusicManagerSingleton *shareSoundManager = nil;

+(MusicManagerSingleton *)shareSoundManager{
    
    
    if(shareSoundManager == nil)
    {
        shareSoundManager = [[super allocWithZone:NULL]init];
    }
    return shareSoundManager;
}

+(id)allocWithZone:(NSZone *)zone
{
    return [[self shareSoundManager] retain];
}

-(id)init
{
    if(self = [super init])
    {
        NSString* BGStr = @"background.mp3";
        [[SimpleAudioEngine sharedEngine]preloadBackgroundMusic:BGStr];
        
        if(BGon){
            [[SimpleAudioEngine sharedEngine]playBackgroundMusic:BGStr];
        }
        else{
            [[SimpleAudioEngine sharedEngine]pauseBackgroundMusic];
        }
    }
    
}

-(void) preLoadBackGroundMusic:(NSString *)filename fileExt:(NSString *)theFileExt{
    
}
-(void) BackGroundMusic{
    [[SimpleAudioEngine sharedEngine]pauseBackgroundMusic];
    BGon = NO;
    
}
-(void) preLoadEffect:(NSString *)filename fileExt:(NSString *)theFileExt{
    NSString* filePath = [[NSBundle mainBundle]pathForResource:filename ofType:theFileExt];
    
    [[SimpleAudioEngine sharedEngine]preloadEffect:filePath];
    
}
-(void) EffectMusic:(int)EffectState{
    
}
-(void) SetBackgroundVolume:(ALfloat)theVolume{
    
}


-(void) ShutDownManager{
    if(shareSoundManager != nil)
    {
        [self dealloc];
    }
}

-(void)dealloc{
        [super release];
}



@end
