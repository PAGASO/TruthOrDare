//
//  TruthOrDareAppDelegate.h
//  TruthOrDare
//
//  Created by Administrator on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface TruthOrDareAppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navigationController;
    sqlite3 *database;
    
    BOOL flgUpdate;
    
    int playerCount;
    
    NSMutableArray *arrDelegateTruth;
    NSMutableArray *arrDelegateDare;
    
}



@property (nonatomic) sqlite3 *database;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (nonatomic, readwrite) BOOL flgUpdate;
@property (nonatomic, retain) NSMutableArray *arrDelegateTruth;
@property (nonatomic, retain) NSMutableArray *arrDelegateDare;
@property (nonatomic, readwrite) int playerCount;


- (void)createEditableCopyOfDatabaseIfNeeded;
- (void)initializeDatabase;

@end
