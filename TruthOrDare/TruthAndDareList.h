//
//  TruthAndDareList.h
//  TruthOrDare
//
//  Created by Administrator on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "TruthOrDareAppDelegate.h"
#import "Spinner.h"

@interface TruthAndDareList : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tblTruth;
    TruthOrDareAppDelegate *appDelegate;
    NSMutableArray *arrTruth;
    NSMutableArray *arrTruthId;
    NSMutableArray *arrTruthGender;
    NSMutableArray *arrTruthPlayer;
    NSMutableArray *arrTruthDirty;
    NSMutableArray *arrDare;
    NSMutableArray *arrDareId;
    NSMutableArray *arrDareGender;
    NSMutableArray *arrDarePlayer;
    NSMutableArray *arrDareDirty;
    
    sqlite3 *database;
    BOOL flgTruth;
    BOOL flgDare;
    
    
    IBOutlet UIButton *btnBack;
    IBOutlet UIButton *btnTruth;
    IBOutlet UIButton *btnDare;
    
    Spinner *spinner;
    
    
}

-(IBAction)truthList;
-(IBAction)dareList;

-(void)getTruthList;
-(void)getDareList;

-(IBAction)back;
-(IBAction)filter;
-(IBAction)add;

@end
