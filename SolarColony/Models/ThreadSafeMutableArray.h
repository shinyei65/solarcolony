//
//  ThreadSafeMutableArray.h
//  SolarColony
//
//  Created by Student on 2/19/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface ThreadSafeMutableArray :NSObject
@property (nonatomic, strong) NSMutableArray *myArray;
@end
