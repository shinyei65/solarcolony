//
//  NetWorkManager.m
//  SolarColony
//
//  Created by Student on 3/10/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "NetWorkManager.h"
#import "ArmyNetwork.h"
static NetWorkManager *sharedNetWorkManager = nil;

@implementation NetWorkManager{
    NSOperationQueue *queue;
}

+(id)NetWorkManager{
    if(sharedNetWorkManager == nil){
        sharedNetWorkManager = [[super allocWithZone:nil] init];
    }
    return sharedNetWorkManager;

}

-(id)init{

    self = [super init];
    queue = [[NSOperationQueue alloc] init];
    return self;
}

-(void)sendAttackRequest:(Army*)sendingArmy
{
 
    NSURL *url = [NSURL URLWithString:@"http://solarcolony-back.appspot.com/request?user_name=default_user"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *jsonRequest = @"attacker=Jimmy&army={ \"waves\": [ { \"soldiers\": [ { \"type\": \"RobotSoldier_Basic\", \"number\": 5 }, { \"type\": \"RobotSoldier_Special\", \"number\": 6 } ] } ]}";
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *ResponseData, NSError *error){
        
        if ([ResponseData length] >0 && error == nil)
        {
            [request release];
            
        }
        else if ([ResponseData length] == 0 && error == nil)
        {
            NSLog(@"Nothing was downloaded.");
            [request release];
        }
        else if (error != nil){
            NSLog(@"Error = %@", error);
            [request release];
        }
        
        
    }];

    NSLog(@"-------send request------- ");

}

-(void)getAttackRequest
{
    
    NSURL *url = [NSURL URLWithString:@"http://solarcolony-back.appspot.com/request?user_name=default_user"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"GET"];

    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *ResponseData, NSError *error){
        
        if ([ResponseData length] >35 && error == nil)
        {
            NSLog(@"length: %d",[ResponseData length]);
            [self deleteAttackRequest:@"03-05-2015%2000:00:00"];
            //[[ArmyQueue layer] ]
            [request release];
            
        }
        else if ([ResponseData length] == 35 && error == nil)
        {
            NSLog(@"Nothing was downloaded.");
            [request release];
        }
        else if (error != nil){
            NSLog(@"Error = %@", error);
            [request release];
        }
        
        
    }];
    
}

-(void)deleteAttackRequest:(NSString*)datetime
{
    
    NSString* url_string = @"http://solarcolony-back.appspot.com/request?user_name=default_user&&date=";
    url_string = [url_string stringByAppendingString:datetime];
    NSURL *url = [NSURL URLWithString:url_string];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    
    [request setHTTPMethod:@"DELETE"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *ResponseData, NSError *error){
        
        if (error != nil){
            NSLog(@"Error = %@", error);
            [request release];
        }
        
        else{
            [request release];
        }
        
        
    }];
    
    NSLog(@"delete!!!!");
    
}

/*
-(Army*)generateArmyFromNetworkResource:(NSString*)sendingArmy{
    NSString * test=@"{\"waveComplexStructure\":{\"w5\":{\"SC\":\"0\",\"SF\":\"0\",\"SB\":\"0\",\"SE\":\"0\",\"SA\":\"0\",\"SD\":\"0\"},\"w3\":{\"SC\":\"0\",\"SF\":\"0\",\"SB\":\"0\",\"SE\":\"0\",\"SA\":\"0\",\"SD\":\"0\"},\"w6\":{\"SC\":\"0\",\"SF\":\"0\",\"SB\":\"0\",\"SE\":\"0\",\"SA\":\"0\",\"SD\":\"0\"},\"w1\":{\"SC\":\"0\",\"SF\":\"0\",\"SB\":\"0\",\"SE\":\"0\",\"SA\":\"0\",\"SD\":\"0\"},\"w4\":{\"SC\":\"0\",\"SF\":\"0\",\"SB\":\"0\",\"SE\":\"0\",\"SA\":\"0\",\"SD\":\"0\"},\"w7\":{\"SC\":\"0\",\"SF\":\"0\",\"SB\":\"0\",\"SE\":\"0\",\"SA\":\"0\",\"SD\":\"0\"},\"w2\":{\"SC\":\"1\",\"SF\":\"1\",\"SB\":\"2\",\"SE\":\"2\",\"SA\":\"5\",\"SD\":\"0\"}},\"race\":\"Robot\"}";
    ArmyNetwork* networkArmy=[[ArmyNetwork alloc] initWithString:test];
    CCLOG(@"mente");
    return nil;
}*/
-(Army*)generateArmyFromNetworkResource:(NSString*)sendingArmy{
    NSString * test=[NSString stringWithString:sendingArmy];
    ArmyNetwork* networkArmy=[[ArmyNetwork alloc] initWithString:test error:&erf];
    
    CCLOG(test);
    return nil;
}


@end
