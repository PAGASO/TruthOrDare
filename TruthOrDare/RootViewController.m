//
//  RootViewController.m
//  TruthOrDare
//
//  Created by Administrator on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "TruthAndDareList.h"
#import "SettingsViewController.h"
#import "UserDefaultSettings.h"
#import "PlayViewController.h"
#import "Popup.h"
#import "Constant.h"


static sqlite3_stmt *getStmt = nil;
static sqlite3_stmt *getStmtDare = nil;

@implementation RootViewController

@synthesize arrPlayers;
@synthesize arrPlayersGender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.title = @"Truth or Dare";
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view from its nib.
    
    tblPlayer.backgroundColor = [UIColor clearColor];
    arrPlayers = [[NSMutableArray alloc] init];
    arrPlayersGender = [[NSMutableArray alloc] init];
    
    [txtPlayerName setFont:[UIFont fontWithName:@"Segoe Print" size:15.0]];
    
    arrPlayerName = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
    if([arrPlayerName count] != 0)
    {
        for(int i=0; i<[arrPlayerName count]; i++)
        {
            [arrPlayers addObject:[arrPlayerName objectAtIndex:i]];
        }
    }
    arrPlayerGender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
    if([arrPlayerGender count] != 0)
    {
        for(int i=0; i<[arrPlayerGender count]; i++)
        {
            [arrPlayersGender addObject:[arrPlayerGender objectAtIndex:i]];
        }
    }
    
    appDelegate = (TruthOrDareAppDelegate *) [UIApplication sharedApplication].delegate;
    [self performSelectorInBackground:@selector(getTruthList) withObject:nil];
    
    
    //[NSThread detachNewThreadSelector:@selector(getTruthList) toTarget:self withObject:nil];
   /* NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
                                                                            selector:@selector(getTruthList)
                                                                              object:nil];
    
    
    [queue addOperation:operation];
    [operation release];
    NSInvocationOperation *operationDare = [[NSInvocationOperation alloc] initWithTarget:self
                                                                            selector:@selector(getDareList)
                                                                              object:nil];

    [queue addOperation:operationDare];
    [operationDare release];
    */
}


-(void)viewWillAppear:(BOOL)animated
{
    
    
   
}



#pragma mark - custom methods
-(IBAction)addPlayer
{
    if ([txtPlayerName.text isEqualToString:@""])
    {
        /*UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Message"
                                                            message:@"Enter Player Name" delegate:self 
                                                  cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];*/
        strAlertMessage = [NSString stringWithFormat:@"Enter Player Name"];
        dictAlertMessage = [[NSMutableDictionary alloc] init];
        [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
        [dictAlertMessage setObject:kWarning forKey:kPopupMessageType];
        //popUpMessageFieldTag = txtEmail.tag;
        [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
        [dictAlertMessage release];
    }
    else
    {
        if([self checkNameExistence])
        {
            [txtPlayerName resignFirstResponder];
            txtPlayerName.text = @"";

            /*UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Message"
                                                                message:@"Player name already exist" delegate:self 
                                                      cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];*/
            strAlertMessage = [NSString stringWithFormat:@"Player name already exist"];
            dictAlertMessage = [[NSMutableDictionary alloc] init];
            [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
            [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
            [dictAlertMessage release];
        }
        else
        {    
            NSString *strPlayerName = txtPlayerName.text;
            int strLen = strPlayerName.length;
            if(strLen > 25)
            {
                /*UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Message"
                                                                    message:@"Maximum 25 Characters" delegate:self 
                                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                [alertView release];*/
                strAlertMessage = [NSString stringWithFormat:@"Maximum 25 Characters"];
                dictAlertMessage = [[NSMutableDictionary alloc] init];
                [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
                [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
                [dictAlertMessage release];

            }
            else
            {
                [txtPlayerName resignFirstResponder];
                [arrPlayers addObject:txtPlayerName.text];
                [arrPlayersGender addObject:@"Male"];
                txtPlayerName.text = @"";
                [tblPlayer reloadData];
                NSArray *arrName = [NSArray arrayWithArray:arrPlayers];
                [[UserDefaultSettings sharedSetting] storeArray:arrName withKey:@"Player Name"];
                NSArray *arrGender = [NSArray arrayWithArray:arrPlayersGender];
                [[UserDefaultSettings sharedSetting] storeArray:arrGender withKey:@"Player Gender"];
            }
        }
    }
}

-(IBAction)addDares
{
    TruthAndDareList *truthAndDareListObj = [[TruthAndDareList alloc] initWithNibName:@"TruthAndDareList" bundle:nil];
    [self.navigationController pushViewController:truthAndDareListObj animated:YES];
}

-(BOOL)checkNameExistence
{
    BOOL flag;
    if([arrPlayers count] != 0)
    {
        for(int i=0; i<[arrPlayers count]; i++)
        {
            if([txtPlayerName.text isEqualToString:[arrPlayers objectAtIndex:i]])
            {
                flag = TRUE;
                break;
            }
            else
            {
                flag = FALSE;  
            }
        }
    }
    else
    {
        flag = FALSE;
    }
    return flag;
}

-(IBAction)goToSettings
{
    SettingsViewController *settingsObj = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    [self.navigationController pushViewController:settingsObj animated:YES];
}

-(IBAction)play
{
    if([arrPlayers count] < 2)
    {
        /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Minimum two players needed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];*/
        strAlertMessage = [NSString stringWithFormat:@"Minimum two players needed"];
        dictAlertMessage = [[NSMutableDictionary alloc] init];
        [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
        [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
        [dictAlertMessage release];
    }
    else
    {
        PlayViewController *playObj = [[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil];
        playObj.arrPlayerName = arrPlayers;
        [self.navigationController pushViewController:playObj animated:YES];
        [playObj release];
    }
}

#pragma mark popup delegate method
- (void)popupViewControllerDidClose:(NSString*)actionType withResponse:(BOOL)response
{
  
}

#pragma mark - textField delegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{
	
        [textField resignFirstResponder];
       
	return YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [arrPlayers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d",indexPath.row];
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = nil;
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
        
    cell.textLabel.text = [arrPlayers objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    [cell.textLabel setFont: [UIFont fontWithName:@"Segoe Print" size:15.0]];

    
    UIButton *btnGender = [UIButton buttonWithType:UIButtonTypeCustom];
    btnGender.frame = CGRectMake(230, 9, 39, 39); 
    if([[arrPlayersGender objectAtIndex:indexPath.row] isEqualToString:@"Male"])
        [btnGender setImage:[UIImage imageNamed:@"malebtn.png"] forState:UIControlStateNormal];
    else
        [btnGender setImage:[UIImage imageNamed:@"femalebtn.png"] forState:UIControlStateNormal];
    btnGender.tag = indexPath.row;
    [btnGender addTarget:self action:@selector(changeGender:) forControlEvents:UIControlEventTouchUpInside];
    [btnGender setUserInteractionEnabled:YES];
    [cell addSubview:btnGender];
    
    UIButton *btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDelete.frame = CGRectMake(275, 9, 39, 39); 
    [btnDelete setImage:[UIImage imageNamed:@"deletebtn.png"] forState:UIControlStateNormal];
    btnDelete.tag = indexPath.row;
    [btnDelete addTarget:self action:@selector(removePlayer:) forControlEvents:UIControlEventTouchUpInside];
    [btnDelete setUserInteractionEnabled:YES];
    [cell addSubview:btnDelete];

    UIImageView *seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 320, 3)];
    [seprator setImage:[UIImage imageNamed:@"divider.png"]];
    [cell addSubview:seprator];
    [seprator release];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell; 
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,0)] autorelease];
    
       
    UIImageView *seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 3)] ;
    [seprator setImage:[UIImage imageNamed:@"divider.png"]];
    [headerView addSubview:seprator];
    [seprator release];
    
    return headerView;
    
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 3.0;
}


-(void)changeGender:(id)sender
{
    NSLog(@"Entere the method");
    UIButton *btn = (UIButton *)sender;
        if([btn.currentImage isEqual:[UIImage imageNamed:@"malebtn.png"]])
        {
            [btn setImage:[UIImage imageNamed:@"femalebtn.png"] forState:UIControlStateNormal];
            [arrPlayersGender replaceObjectAtIndex:btn.tag withObject:@"Female"];
           
            NSArray *arrGender = [NSArray arrayWithArray:arrPlayersGender];
            [[UserDefaultSettings sharedSetting] storeArray:arrGender withKey:@"Player Gender"];
            
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"malebtn.png"] forState:UIControlStateNormal];
            [arrPlayersGender replaceObjectAtIndex:btn.tag withObject:@"Male"];
            
            NSArray *arrGender = [NSArray arrayWithArray:arrPlayersGender];
            [[UserDefaultSettings sharedSetting] storeArray:arrGender withKey:@"Player Gender"];
        }
       
}

-(void)removePlayer:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [arrPlayers removeObjectAtIndex:btn.tag];
    [arrPlayersGender removeObjectAtIndex:btn.tag];
    
    NSArray *arrName = [NSArray arrayWithArray:arrPlayers];
    [[UserDefaultSettings sharedSetting] storeArray:arrName withKey:@"Player Name"];
    NSArray *arrGender = [NSArray arrayWithArray:arrPlayersGender];
    [[UserDefaultSettings sharedSetting] storeArray:arrGender withKey:@"Player Gender"];
    
    [tblPlayer reloadData];
    
}


#pragma mark database methods
-(void)getTruthList
{
    
    database = appDelegate.database;
    
   
    NSAutoreleasePool *autoreleasepool = [[NSAutoreleasePool alloc] init];
    if(!getStmt)
	{
		NSString *queryStr = [NSString stringWithFormat:@"select ln_EN from tblTruth"];
		const char *sql = (char *) [queryStr UTF8String];
		if(sqlite3_prepare_v2(database, sql, -1, &getStmt, NULL) != SQLITE_OK)
		{
			getStmt = nil;
		}
	}
	if(!getStmt)
	{
		NSAssert1(0, @"Cant read data from db [%s]", sqlite3_errmsg(database));
	}
	
	int ret;
    NSString *strTruth;
   /* NSString *primaryKey;
    NSString *dirty;
    NSString *minplayers;
    NSString *gender;*/
	while((ret = sqlite3_step(getStmt)) == SQLITE_ROW)
	{
		
		
        //int primaryKey = sqlite3_column_int(getStmt, 0);
        //[arrTruthId addObject:[NSString stringWithFormat:@"%d", primaryKey]];
        /*
        char *pk = (char *) sqlite3_column_text(getStmt, 0);
		if(pk != NULL)
        {
            primaryKey = [NSString stringWithUTF8String:(char *)pk];
            [arrTruthId addObject:primaryKey];
        }
		*/
		char *truth = (char *) sqlite3_column_text(getStmt, 0);
		if(truth != NULL)
        {
            strTruth = [NSString stringWithUTF8String:(char *)truth];
            [appDelegate.arrDelegateTruth addObject:strTruth];	
        }
        /*
        char *dirtiness = (char *) sqlite3_column_text(getStmt, 2);
		if(dirtiness != NULL)
        {
            dirty = [NSString stringWithUTF8String:(char *)dirtiness];
            [arrTruthDirty addObject:dirty];
        }
        
        char *players = (char *) sqlite3_column_text(getStmt, 3);
		if(players != NULL)
        {
            minplayers = [NSString stringWithUTF8String:(char *)players];
            [arrTruthPlayer addObject:minplayers];
        }
        
        char *gen = (char *) sqlite3_column_text(getStmt, 4);
		if(gen != NULL)
        {
            gender = [NSString stringWithUTF8String:(char *)gen];
            [arrTruthGender addObject:gender];
        }
        */
        
        
        
	}
	
	sqlite3_reset(getStmt);
	getStmt = nil;
    
    
    
      
    [autoreleasepool release];
    
    
    [self performSelectorInBackground:@selector(getDareList) withObject:nil];
    
    
}


-(void)getDareList
{
    if(database== nil)
    {
        database = appDelegate.database;
    }
     
    
    NSAutoreleasePool *autoreleasepool = [[NSAutoreleasePool alloc] init];
    
    if(!getStmtDare)
	{
		NSString *queryStr = [NSString stringWithFormat:@"select ln_EN from tblDare"];
		const char *sql = (char *) [queryStr UTF8String];
		if(sqlite3_prepare_v2(database, sql, -1, &getStmtDare, NULL) != SQLITE_OK)
		{
			getStmtDare = nil;
		}
	}
	if(!getStmtDare)
	{
		NSAssert1(0, @"Cant read data from db [%s]", sqlite3_errmsg(database));
	}
	
	int ret;
    NSString *strDare;
   /* NSString *primaryKey;
    NSString *dirty;
    NSString *minplayers;
    NSString *gender;*/
	while((ret = sqlite3_step(getStmtDare)) == SQLITE_ROW)
	{
        /*
		char *pk = (char *) sqlite3_column_text(getStmt, 0);
		if(pk != NULL)
        {
            primaryKey = [NSString stringWithUTF8String:(char *)pk];
            [arrDareId addObject:primaryKey];
        }
        */
		char *dare = (char *) sqlite3_column_text(getStmtDare, 0);
		if(dare != NULL)
        {
            strDare = [NSString stringWithUTF8String:(char *)dare];
			[appDelegate.arrDelegateDare addObject:strDare];		
        }
        /*
        char *dirtiness = (char *) sqlite3_column_text(getStmt, 2);
		if(dirtiness != NULL)
        {
            dirty = [NSString stringWithUTF8String:(char *)dirtiness];
            [arrDareDirty addObject:dirty];
        }
        
        char *players = (char *) sqlite3_column_text(getStmt, 3);
		if(players != NULL)
        {
            minplayers = [NSString stringWithUTF8String:(char *)players];
            [arrDarePlayer addObject:minplayers];
        }
        
        char *gen = (char *) sqlite3_column_text(getStmt, 4);
		if(gen != NULL)
        {
            gender = [NSString stringWithUTF8String:(char *)gen];
            [arrDareGender addObject:gender];
        }
        
        */
	}
	
	sqlite3_reset(getStmtDare);
	getStmtDare = nil;
    
    [autoreleasepool release];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
