//
//  RootViewController.h
//  TruthOrDare
//
//  Created by Administrator on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "TruthOrDareAppDelegate.h"

@interface RootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tblPlayer;
    IBOutlet UITextField *txtPlayerName;
    IBOutlet UIButton *btnAddPlayer;
    
    
    NSMutableArray *arrPlayers;
    NSMutableArray *arrPlayersGender;
    
    NSArray *arrPlayerName;
    NSArray *arrPlayerGender;
    
    NSString *strAlertMessage;
    NSMutableDictionary* dictAlertMessage;
    
    sqlite3 *database;
    
    TruthOrDareAppDelegate *appDelegate;
    
}

@property (nonatomic, retain) NSMutableArray *arrPlayers;
@property (nonatomic, retain) NSMutableArray *arrPlayersGender;

-(IBAction)addPlayer;
-(IBAction)play;
-(BOOL)checkNameExistence;
-(IBAction)goToSettings;

-(void)getTruthList;
-(void)getDareList;



@end
