//
//  ThreadSafeMutableArray.m
//  SolarColony
//
//  Created by Student on 2/19/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "ThreadSafeMutableArray.h"
#import "SimpleAudioEngine.h"
@implementation ThreadSafeMutableArray
@synthesize myArray;
- (id)init
{
    self = [super init];
    if (self) {
     //  delegateQueue = dispatch_queue_create("com.PSPDFKit.cacheDelegateQueue",DISPATCH_QUEUE_CONCURRENT);
        dispatch_queue_t concurrent_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    return self;
}



@end
