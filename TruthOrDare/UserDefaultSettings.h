//
//  UserDefaultSettings.h
//  TruthOrDare
//
//  Created by Administrator on 01/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultSettings : NSObject
{
    NSUserDefaults *prefs;
}

+(UserDefaultSettings *)sharedSetting;


-(void)storeDictionary:(NSDictionary *)dictionary withKey:(NSString *)key;
-(NSDictionary *) retrieveDictionary:(NSString *)key;

-(void)storeArray:(NSArray *)array withKey:(NSString *)key;
-(NSArray *)retrieveArray:(NSString *)key;


@end
