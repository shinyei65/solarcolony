//
//  NetWorkManager.m
//  SolarColony
//
//  Created by Student on 3/10/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "NetWorkManager.h"
#import "ArmyNetwork.h"
#import "ArmyQueue.h"
#import "BasicSoldier.h"
#import "HumanSoldier.h"
#import "RobotSoldier.h"
#import "MageSoldier.h"
#import "WavesOfSoldiers.h"
static NetWorkManager *sharedNetWorkManager = nil;

@implementation NetWorkManager{
    NSOperationQueue *queue;
    int tagOfArmy;
}

+(id)NetWorkManager{
    if(sharedNetWorkManager == nil){
        sharedNetWorkManager = [[super allocWithZone:nil] init];
    }
    return sharedNetWorkManager;
    
}

-(id)init{
    
    self = [super init];
    if(self){
        queue = [[NSOperationQueue alloc] init];
        tagOfArmy = 1;
    }
    return self;
}

-(void)sendAttackRequest:(Army*)sendingArmy attackTarget:(NSString *)target
{
    NSString *jtest = [[NetWorkManager NetWorkManager] generateJSONfromWaveSettings];
    if(jtest){
        CCLOG(jtest);
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Your army is sent to %@ !", target] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [myAlertView show];
        [myAlertView release];
    }else{
        CCLOG(@"no soldiers");
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"No soldiers in your army !" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [myAlertView show];
        [myAlertView release];
        return;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://solarcolony-back.appspot.com/request?user_name=%@",target]];
    NSLog(@"sending url: %@",[NSString stringWithFormat:@"http://solarcolony-back.appspot.com/request?user_name=%@",target]);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *jsonRequest = [NSString stringWithFormat:@"attacker=%@&army=%@",[PlayerInfo Player].username, jtest];
    NSLog(@"Json Request: %@",jsonRequest);
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *ResponseData, NSError *error){
        
        if ([ResponseData length] >0 && error == nil)
        {
            [[[GameStatusEssentialsSingleton sharedInstance] WaveSettings] removeAllObjects];
            [[GameStatusEssentialsSingleton sharedInstance] setWaveFirstVisit:true];
            [request release];
            
        }
        else if ([ResponseData length] == 0 && error == nil)
        {
            [[[GameStatusEssentialsSingleton sharedInstance] WaveSettings] removeAllObjects];
            [[GameStatusEssentialsSingleton sharedInstance] setWaveFirstVisit:true];
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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://solarcolony-back.appspot.com/request?user_name=%@",[PlayerInfo Player].username]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *ResponseData, NSError *error){
        
        if ([ResponseData length] >35 && error == nil)
        {
            //NSLog(@"length: %d",[ResponseData length]);
            [self deleteAttackRequest:@"03-05-2015%2000:00:00"];
            //[[ArmyQueue layer] genertateTestarmy];
            [self generateArmyFromNetworkResource:ResponseData];
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
    
    NSString* url_string = [NSString stringWithFormat:@"http://solarcolony-back.appspot.com/request?user_name=%@&&date=", [PlayerInfo Player].username];
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

-(BOOL)signInUser:(NSString*)username
{
    NSString* url_string = @"http://solarcolony-back.appspot.com/account";
    NSURL *url = [NSURL URLWithString:url_string];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"text/html" forHTTPHeaderField:@"Accept"];
    NSString *requestStr = [NSString stringWithFormat:@"user_name=%@", username];
    NSData *requestData = [NSData dataWithBytes:[requestStr UTF8String] length:[requestStr length]];
    [request setHTTPBody:requestData];
    NSHTTPURLResponse *response = nil;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    if ([response statusCode] == 200)
    {
        NSString *result = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        NSLog(@"NetworkManerger: result = %@", result);
        [request release];
        if([result isEqualToString:@"failed"]){
            return FALSE;
        }else{
            return TRUE;
        }
    }else{
        NSLog(@"NetworkManerger: statusCode = %ld", (long)[response statusCode]);
        [request release];
    }
    return FALSE;
}

-(BOOL)checkUser:(NSString*)username
{
    NSString* url_string = [NSString stringWithFormat:@"http://solarcolony-back.appspot.com/account?id=gogog22510&user_name=%@",username];
    NSURL *url = [NSURL URLWithString:url_string];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"text/html" forHTTPHeaderField:@"Accept"];
    NSHTTPURLResponse *response = nil;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    if ([response statusCode] == 200)
    {
        NSString *result = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        NSLog(@"NetworkManerger: result = %@", result);
        [request release];
        if([result isEqualToString:@"exist"]){
            return true;
        }else{
            return FALSE;
        }
    }else{
        NSLog(@"NetworkManerger: statusCode = %ld", (long)[response statusCode]);
        [request release];
    }
    return FALSE;
}

-(void)setRewardtoAttacker:(NSString *) attacker Reward:(int) reward
{
    NSString* url_string = [NSString stringWithFormat:@"http://solarcolony-back.appspot.com/reward?user_name=%@", attacker];
    NSLog(@"%@",url_string);
    NSURL *url = [NSURL URLWithString:url_string];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *formRequest = [NSString stringWithFormat:@"value=%d", reward];
    NSData *requestData = [NSData dataWithBytes:[formRequest UTF8String] length:[formRequest length]];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *ResponseData, NSError *error){
        
        if (error == nil)
        {
            NSLog(@"NetworkManerger: update attacker success");
            [request release];
        }else{
            NSLog(@"Error = %@", error);
            [request release];
        }
    }];

}

-(void)getReward
{
    NSString* url_string = [NSString stringWithFormat:@"http://solarcolony-back.appspot.com/reward?id=gogog22510&user_name=%@", [PlayerInfo Player].username];
    NSURL *url = [NSURL URLWithString:url_string];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"text/html" forHTTPHeaderField:@"Accept"];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *ResponseData, NSError *error){
        
        if ([ResponseData length] >0 && error == nil)
        {
            NSString *result = [[NSString alloc] initWithData:ResponseData encoding:NSUTF8StringEncoding];
            int reward = [result integerValue];
            //NSLog(@"NetworkManerger: reward = %@",result);
            if(reward > 0){
                NSLog(@"NetworkManerger: reward = %d",[result integerValue]);
                int newResource = [[PlayerInfo Player] getResource] + reward;
                [[PlayerInfo Player] setResource:newResource];
                [[GridMap map] showMessage:@"Gain Reward From your Army!!"];
                [self resetReward];
            }else
                [[ArmyQueue layer] resetGetRewardFlag];
            [request release];
        }else if (error != nil){
            NSLog(@"Error = %@", error);
            [request release];
        }
    }];

}
-(void)resetReward
{
    NSString* url_string = [NSString stringWithFormat:@"http://solarcolony-back.appspot.com/reward?user_name=%@",[PlayerInfo Player].username];
    NSURL *url = [NSURL URLWithString:url_string];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"DELETE"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSHTTPURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSLog(@"\n\n\nNetworkManerger: reset \n\n\n");
    if ([response statusCode] == 200)
    {
        NSLog(@"NetworkManerger: reset success");
        [[ArmyQueue layer] resetGetRewardFlag];
        [request release];
    }else{
        NSLog(@"NetworkManerger: statusCode = %ld", (long)[response statusCode]);
        [request release];
    }

}

-(void) generateArmyFromNetworkResource:(NSData *)data{
    //NSLog(@"data: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (!json) {
        NSLog(@"Error parsing JSON: %@", error);
    }else{
        NSArray* requests = [json objectForKey:@"requests"];
        //NSLog(@"requests = %d",[requests count]);
        for(NSDictionary *req in requests){
            
            Army *army = [Army army: [[req objectForKey:@"id"] retain] Attacker:[[req objectForKey:@"attacker"] retain]];
            NSDictionary *armyDic = [req objectForKey:@"army"];
            NSString *race = [[armyDic objectForKey:@"race"] retain];
            int raceType;
            if([race isEqualToString:@"Human"])
                raceType = 0;
            else if([race isEqualToString:@"Robot"])
                raceType = 1;
            else
                raceType = 2;
            NSArray *waves = [armyDic objectForKey:@"wavesArray"];
            for(NSDictionary *wav in waves){
                Wave *wave = [Wave wave];
                wave.race = race;
                NSArray *sols = [wav objectForKey:@"soldiersArray"];
                for(NSDictionary *sol in sols){
                    NSString *type = [sol objectForKey:@"soldiertype"];
                    int quantity = [[sol objectForKey:@"quantity"] integerValue];
                    int level = [[sol objectForKey:@"level"] integerValue];
                    Soldier * (^selectedCase)() = @{
                                                    @"Human": @{
                                                            @"A" : ^{
                                                                //return [BasicSoldier human:(int)10 ATTACK:(int)2 Speed:(int)2 ATTACK_SP:(int)2];
                                                                return [BasicSoldier soldierWithRace:@"Human"];
                                                            },
                                                            @"B" : ^{
                                                                return [HumanSoldier soldierWithType:@"typeA"];
                                                            },
                                                            },
                                                    @"Robot": @{
                                                            @"A" : ^{
                                                                //return [BasicSoldier robot:(int)10 ATTACK:(int)2 Speed:(int)2 ATTACK_SP:(int)2];
                                                                return [BasicSoldier soldierWithRace:@"Robot"];
                                                            },
                                                            @"B" : ^{
                                                                return [RobotSoldier soldierWithType:@"typeA"];
                                                            },
                                                            },
                                                    @"Magic": @{
                                                            @"A" : ^{
                                                                //return [BasicSoldier mage:(int)10 ATTACK:(int)2 Speed:(int)2 ATTACK_SP:(int)2];
                                                                return [BasicSoldier soldierWithRace:@"Magic"];
                                                            },
                                                            @"B" : ^{
                                                                return [MageSoldier soldierWithType:@"typeA"];
                                                            },
                                                            },
                                                    }[race][type];
                    while(quantity > 0){
                        Soldier *temp;
                        temp = selectedCase();
                        if([type isEqualToString:@"A"]){
                            [temp setHEALTH:pow(1.3, tagOfArmy+level)*[temp getHEALTH]];
                            [temp setSPEED:pow(1.4, tagOfArmy+level)*[temp getSPEED]];
                        }else{
                            [temp setHEALTH:(int)pow(1.3, tagOfArmy+level)*[temp getHEALTH]];
                            [temp setATTACK:(int)pow(1.4, tagOfArmy+level)*[temp getATTACK]];
                            [temp setSPEED:(int)pow(1.2, tagOfArmy+level)*[temp getSPEED]];
                        }
                        [wave addSoldier: temp];
                        quantity--;
                    }
                }
                [army addWave: wave];
            }
            [[ArmyQueue layer] addArmy:army];
            //NSLog(@"WAVECOUNT = %d", [army count]);
        }
    }
    //CCLOG(test);
}
- (NSString *) generateJSONfromWaveSettings
{
    NSMutableArray * settings = [[GameStatusEssentialsSingleton sharedInstance] WaveSettings];
    int sum = 0;
    for(WaveSetting * ws in settings){
        for(SoldierSetting *ss in [ws getList]){
            sum += [ss getCount];
        }
    }
    if(sum == 0) return nil;
    NSString *root = @"{\"wavesArray\": [";
    NSString *tail = [NSString stringWithFormat:@"], \"race\": \"%@\"}", [[GameStatusEssentialsSingleton sharedInstance] raceType]];
    NSMutableArray *arr = [NSMutableArray array];
    for(WaveSetting * ws in settings){
        NSString *tmp = [ws toJSONstring];
        if(tmp)
            [arr addObject:tmp];
    }
    root = [root stringByAppendingString:[arr componentsJoinedByString:@","]];
    return [root stringByAppendingString:tail];
}

@end
