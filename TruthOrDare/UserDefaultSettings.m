//
//  UserDefaultSettings.m
//  TruthOrDare
//
//  Created by Administrator on 01/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UserDefaultSettings.h"

@implementation UserDefaultSettings

static UserDefaultSettings *_sharedSetting;

+(UserDefaultSettings *) sharedSetting
{
    if(!_sharedSetting)
    {
        _sharedSetting = [[UserDefaultSettings alloc] init];
    }
    return _sharedSetting;
}


-(void)storeDictionary:(NSDictionary *)dictionary withKey:(NSString *)key
{
    prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:dictionary forKey:key];
    [prefs synchronize];
}

-(NSDictionary *)retrieveDictionary:(NSString *)key
{
    prefs =[NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [prefs dictionaryForKey:key];
    return dictionary;
}


-(void)storeArray:(NSArray *)array withKey:(NSString *)key
{
    prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:array forKey:key];
    [prefs synchronize];
}
-(NSArray *)retrieveArray:(NSString *)key
{
    prefs =[NSUserDefaults standardUserDefaults];
    NSArray *array = [prefs arrayForKey:key];
    return array;
}

@end
