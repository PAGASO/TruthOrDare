//
//  EditTruthOrDareViewController.h
//  TruthOrDare
//
//  Created by Administrator on 30/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "TruthOrDareAppDelegate.h"

@interface EditTruthOrDareViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
{
    IBOutlet UIButton *btnBack;
    IBOutlet UIButton *btnSave;
    IBOutlet UILabel *lblTitle;
    IBOutlet UITextView *txtEdit;
    IBOutlet UITableView *tblEdit;
    
    NSString *strTitle;
    NSString *strValue;
    
    NSString *strPrimaryKey;
    NSString *strDirtiness;
    NSString *strGender;
    NSString *strPlayers;
    NSString *strActive;
    
    NSString *strOrigin;
    
    NSString *strLastId;
    
    sqlite3 *database;
    TruthOrDareAppDelegate *appDelegate;
    
    NSString *strAlertMessage;
    NSMutableDictionary *dictAlertMessage;
    
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
    UIButton *btn5;
    UIButton *btn6;
    
    BOOL flgCategory;
    NSString *strFirstCategory;
    NSString *strSecondCategory;
    NSString *strThirdCategory;
    
    
}

@property (nonatomic, retain) NSString *strTitle;
@property (nonatomic, retain) NSString *strValue;
@property (nonatomic, retain) NSString *strPrimaryKey;
@property (nonatomic, retain) NSString *strDirtiness;
@property (nonatomic, retain) NSString *strGender;
@property (nonatomic, retain) NSString *strPlayers;
@property (nonatomic, retain) NSString *strActive;
@property (nonatomic, retain) NSString *strOrigin;
@property (nonatomic, retain) NSString *strLastId;

-(IBAction)back;
-(IBAction)save:(id)sender;
-(void)updateDatabase;


@end
