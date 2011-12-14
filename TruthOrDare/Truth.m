//
//  Truth.m
//  TruthOrDare
//
//  Created by Administrator on 28/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Truth.h"

static sqlite3_stmt *init_statement = nil;

@implementation Truth 
@synthesize primaryKey, ln_EN_Truths;

-(id)getAllTruthsInEnglishLanguage:(sqlite3 *)db
{
    if (self = [super init]) 
    {
        database = db;
        
        if (init_statement == nil) 
        {
            const char *sql = "SELECT ln_EN FROM tblTruth";
            if (sqlite3_prepare_v2(database, sql, -1, &init_statement, NULL) != SQLITE_OK) 
            {
                NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
            }
        }
       
        //sqlite3_bind_int(init_statement, 1, primaryKey);
        if (sqlite3_step(init_statement) == SQLITE_ROW) 
        {
            self.ln_EN_Truths = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 1)];
        } 
        
        // Reset the statement for future reuse.
        sqlite3_reset(init_statement);
    }

    return self;
}




-(id)init
{
	primaryKey = @"";
	ln_EN_Truths = @"";
	
	return self;
}

-(void)dealloc
{
	
	[primaryKey release];
    [ln_EN_Truths release];
	
	
	[super dealloc];
}


@end
