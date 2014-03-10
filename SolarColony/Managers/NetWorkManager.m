//
//  NetWorkManager.m
//  SolarColony
//
//  Created by Student on 3/10/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "NetWorkManager.h"

static NetWorkManager *sharedNetWorkManager = nil;

@implementation NetWorkManager

+NetWorkManager{
    if(sharedNetWorkManager == nil){
        sharedNetWorkManager = [[super allocWithZone:nil] init];
    }
    return sharedNetWorkManager;

}

-(id)init{

    NSString *jsonRequest = @"attacker=[Jimmy]&army=[ \"waves\": [ { \"soldiers\": [ { \"type\": \"attacker\", \"number\": 2 }, { \"type\": \"runner\", \"number\": 2 } ] } ] ]";
    
    NSURL *url = [NSURL URLWithString:@"http://solarcolony-back.appspot.com/request?user_name=default_user"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    [NSURLConnection connectionWithRequest:[request autorelease] delegate:self];
    return self;
}

@end
