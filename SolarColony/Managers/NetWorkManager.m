//
//  NetWorkManager.m
//  SolarColony
//
//  Created by Student on 3/10/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "NetWorkManager.h"

static NetWorkManager *sharedNetWorkManager = nil;

@implementation NetWorkManager{
    NSURL *url;
    
    
}

+(id)NetWorkManager{
    if(sharedNetWorkManager == nil){
        sharedNetWorkManager = [[super allocWithZone:nil] init];
    }
    return sharedNetWorkManager;

}

-(id)init{

    self = [super init];
    return self;
}

-(void)sendAttackRequest:(Army*)sendingArmy
{
    
    url = [NSURL URLWithString:@"http://solarcolony-back.appspot.com/request?user_name=default_user"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *jsonRequest = @"attacker=Jimmy&army={ \"waves\": [ { \"soldiers\": [ { \"type\": \"RobotSoldier_Basic\", \"number\": 5 }, { \"type\": \"RobotSoldier_Special\", \"number\": 6 } ] } ]}";
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    NSLog(@"-------send request------- ");
    [request release];
    [url release];
}


@end
