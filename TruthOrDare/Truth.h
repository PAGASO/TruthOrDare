//
//  Truth.h
//  TruthOrDare
//
//  Created by Administrator on 28/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Truth : NSObject
{
	NSString *primaryKey;
	NSString *ln_EN_Truths;
    
    sqlite3 *database;
	
}

@property (nonatomic, retain) NSString *primaryKey;
@property (nonatomic, retain) NSString *ln_EN_Truths;

-(id)getAllTruthsInEnglishLanguage:(sqlite3 *)database;

@end
