//
//  EditTruthOrDareViewController.m
//  TruthOrDare
//
//  Created by Administrator on 30/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EditTruthOrDareViewController.h"
#import "Popup.h"


static sqlite3_stmt *updateStmt = nil;
static sqlite3_stmt *addStmt = nil;

@implementation EditTruthOrDareViewController
@synthesize strTitle;
@synthesize strValue;
@synthesize strPrimaryKey, strGender, strDirtiness, strPlayers;
@synthesize strOrigin;
@synthesize strActive;
@synthesize strLastId;

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
    //txtEdit.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"textbox1.png"]];
    txtEdit.backgroundColor = [UIColor clearColor];
    txtEdit.font = [UIFont fontWithName:@"Segoe Print" size:15.0];
    txtEdit.textColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    
    appDelegate = (TruthOrDareAppDelegate *) [[UIApplication sharedApplication]delegate];
}

-(void)viewWillAppear:(BOOL)animated
{
    [lblTitle setText:strTitle];
    [lblTitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:20.0]];
    [lblTitle setTextColor:[UIColor whiteColor]];
    
    [tblEdit setBackgroundColor:[UIColor clearColor]];
    tblEdit.scrollEnabled = NO;
    
    if([self.strOrigin isEqualToString:@"Edit"])
    {
        [txtEdit setText:strValue]; 
        [btnSave setImage:[UIImage imageNamed:@"savebtn.png"] forState:UIControlStateNormal];
        
        NSLog(@"dirty :- %@", self.strDirtiness);
        NSLog(@"gender :- %@", self.strGender);
    }
    else
    {
        [btnSave setImage:[UIImage imageNamed:@"addbtn.png"] forState:UIControlStateNormal];
        
        self.strDirtiness = @"3";
        self.strGender = @"0";
        self.strPlayers = @"2";
        
    }
    
    
}

#pragma mark textview methods
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    
    
	return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [txtEdit resignFirstResponder];
    }
    return YES;
}


#pragma mark custom methods
-(IBAction)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)save:(id)sender
{
    [txtEdit resignFirstResponder];
    strValue = txtEdit.text;
    
    if([strValue isEqualToString:@""])
    {
        strAlertMessage = [NSString stringWithFormat:@"Enter %@", self.strTitle];
        dictAlertMessage = [[NSMutableDictionary alloc] init];
        [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
        [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
        [dictAlertMessage release];
    }
    else
    {
        
        [self updateDatabase];
    }
}

-(void)updateDatabase
{
    database = appDelegate.database;
    
    if([strOrigin isEqualToString:@"Edit"])
    {
        
        if(updateStmt == nil) {
            if([self.strTitle isEqualToString:@"Truth"])
            {
                const char *sqlTruth = "update tblTruth Set ln_EN = ?, dirty = ?, minplayers = ?, Gender = ? Where pkTruthChallengeID = ?";
                if(sqlite3_prepare_v2(database, sqlTruth, -1, &updateStmt, NULL) != SQLITE_OK)
                    NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
            }
            else
            {
                const char *sqlDare = "update tblDare Set ln_EN = ?, dirty = ?, minplayers = ?, gender = ? Where pkDaresChallengeID = ?";
                if(sqlite3_prepare_v2(database, sqlDare, -1, &updateStmt, NULL) != SQLITE_OK)
                    NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
            }
        }
        
        sqlite3_bind_text(updateStmt, 1, [strValue UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt, 2, [strDirtiness UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt, 3, [strPlayers UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt, 4, [strGender UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt, 5, [strPrimaryKey UTF8String], -1, SQLITE_TRANSIENT);
        
        
        //sqlite3_bind_double(updateStmt, 2, [price doubleValue]);
        //sqlite3_bind_int(updateStmt, 3, coffeeID);
        
        if(SQLITE_DONE != sqlite3_step(updateStmt))
            NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
        else
        {
            appDelegate.flgUpdate = TRUE;
            /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:[NSString stringWithFormat:@"Updated %@", self.strTitle] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
             [alert release];*/
            strAlertMessage = [NSString stringWithFormat:@"Updated %@", self.strTitle];
            dictAlertMessage = [[NSMutableDictionary alloc] init];
            [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
            [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
            [dictAlertMessage release];
        }
        sqlite3_reset(updateStmt);
        updateStmt = nil;
    }
    else
    {
        if(addStmt == nil) 
        {
            if([self.strTitle isEqualToString:@"Truth"])
            {
                const char *sqlTruth = "insert into tblTruth (pkTruthChallengeID,ln_EN, dirty, minplayers, Gender) values(?,?,?,?,?)";
                if(sqlite3_prepare_v2(database, sqlTruth, -1, &addStmt, NULL) != SQLITE_OK) 
                {
                    NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
                }
            }
            else
            {
                const char *sqlDare = "insert into tblDare (pkDaresChallengeID,ln_EN, dirty, minplayers, gender) values(?,?,?,?,?)";
                if(sqlite3_prepare_v2(database, sqlDare, -1, &addStmt, NULL) != SQLITE_OK) 
                {
                    NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
                }
            }
        }
        
        int rowId = self.strLastId.integerValue;
        rowId = rowId + 1;
        NSString *strId = [NSString stringWithFormat:@"%d", rowId];
        sqlite3_bind_text(addStmt, 1, [strId UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(addStmt, 2, [self.strValue UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(addStmt, 3, [self.strDirtiness UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(addStmt, 4, [self.strPlayers UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(addStmt, 5, [self.strGender UTF8String], -1, SQLITE_TRANSIENT);
        
        if(SQLITE_DONE != sqlite3_step(addStmt)) 
        {
            NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
        }
        else 
        {
            appDelegate.flgUpdate = TRUE;
            /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:[NSString stringWithFormat:@"%@ Added", self.strTitle] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
             [alert release];*/
            
            strAlertMessage = [NSString stringWithFormat:@"%@ Added", self.strTitle];
            dictAlertMessage = [[NSMutableDictionary alloc] init];
            [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
            [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
            [dictAlertMessage release];
        }
        
        //Reset the add statement.
        sqlite3_reset(addStmt);
        // "Finalize" the statement - releases the resources associated with the statement.
        sqlite3_finalize(addStmt);
        addStmt = nil;
        
    }
    
}
#pragma mark table delegate methods

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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d",indexPath.row];
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = nil;
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if(indexPath.row == 0)
    {
        cell.textLabel.text = @"Preview"; 
        cell.accessoryView = [[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"arrow.png"]];
        
        
    }
    else if(indexPath.row == 1)
    {
        cell.textLabel.text = @"Add Person Code";
        cell.accessoryView = [[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    }
    else if(indexPath.row == 2)
    {
        cell.textLabel.text = @"Active";
        UISegmentedControl *segmentedControlActive = [[UISegmentedControl alloc] initWithItems:
                                                      [NSArray arrayWithObjects:
                                                       @"Active",
                                                       @"Inactive",
                                                       nil]];
        [segmentedControlActive addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        segmentedControlActive.frame = CGRectMake(155, 8, 153, 30);
        segmentedControlActive.segmentedControlStyle = UISegmentedControlStylePlain;
        segmentedControlActive.tag = indexPath.row;
        if([self.strOrigin isEqualToString:@"Edit"])
        {
            segmentedControlActive.selectedSegmentIndex = 0;
        }
        else
        {
            segmentedControlActive.selectedSegmentIndex = 0;
        }
        NSString *str = [[UIDevice currentDevice] systemVersion];
        float version = str.floatValue;
        if(version == 5.0)
        {
            UIFont *font = [UIFont fontWithName:@"SegoePrint-Bold" size:10.0];
            NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
            [segmentedControlActive setTitleTextAttributes:attributes forState:UIControlStateNormal];
        }
        
        [cell addSubview:segmentedControlActive];
        [segmentedControlActive release];    
        
    }
    else if(indexPath.row == 3)
    {
        cell.textLabel.text = @"This is For";
        UISegmentedControl *segmentedControlGender = [[UISegmentedControl alloc] initWithItems:
                                                      [NSArray arrayWithObjects:
                                                       @"Male",
                                                       @"Female",
                                                       @"Both",
                                                       nil]];
        [segmentedControlGender addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        segmentedControlGender.frame = CGRectMake(96, 8, 215, 30);
        segmentedControlGender.segmentedControlStyle = UISegmentedControlStylePlain;
        segmentedControlGender.tag = indexPath.row;
        if([self.strOrigin isEqualToString:@"Edit"])
        {
            if([strGender isEqualToString:@"1"])
                segmentedControlGender.selectedSegmentIndex = 0;
            else if([strGender isEqualToString:@"2"])
                segmentedControlGender.selectedSegmentIndex = 1;
            else
                segmentedControlGender.selectedSegmentIndex = 2;
        }
        else
        {
            segmentedControlGender.selectedSegmentIndex = 2;
        }
        
        NSString *str = [[UIDevice currentDevice] systemVersion];
        float version = str.floatValue;
        if(version == 5.0)
        {
            UIFont *font = [UIFont fontWithName:@"SegoePrint-Bold" size:10.0];
            NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
            [segmentedControlGender setTitleTextAttributes:attributes forState:UIControlStateNormal];
        }
        
        [cell addSubview:segmentedControlGender];
        [segmentedControlGender release];  
    }
    else if(indexPath.row == 4)
    {
        cell.textLabel.text = @"Number of player needed";
        cell.accessoryView = [[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    }
    else if(indexPath.row == 5)
    {
        cell.textLabel.text = @"Dirtiness";
        /* UISegmentedControl *segmentedControlDirtiness = [[UISegmentedControl alloc] initWithItems:
         [NSArray arrayWithObjects:
         @"Clean",
         @"Dirty",
         @"Super Dirty",
         nil]];
         [segmentedControlDirtiness addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
         segmentedControlDirtiness.frame = CGRectMake(80, 8, 230, 30);
         segmentedControlDirtiness.segmentedControlStyle = UISegmentedControlStylePlain;
         segmentedControlDirtiness.tag = indexPath.row;
         int value = strDirtiness.integerValue;
         if([self.strOrigin isEqualToString:@"Edit"])
         {
         if(value <= 3)
         {
         segmentedControlDirtiness.selectedSegmentIndex = 0;
         }
         else if(value ==4 || value == 5)
         {
         segmentedControlDirtiness.selectedSegmentIndex = 1;
         }
         else
         {
         segmentedControlDirtiness.selectedSegmentIndex = 2;
         }
         }
         else
         {
         segmentedControlDirtiness.selectedSegmentIndex = 0;
         }
         
         NSString *str = [[UIDevice currentDevice] systemVersion];
         float version = str.floatValue;
         if(version == 5.0)
         {
         UIFont *font = [UIFont fontWithName:@"SegoePrint-Bold" size:10.0];
         NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
         [segmentedControlDirtiness setTitleTextAttributes:attributes forState:UIControlStateNormal];
         }
         
         [cell addSubview:segmentedControlDirtiness];
         [segmentedControlDirtiness release];  */
        int value = strDirtiness.integerValue;
        
        UIButton *btnStar1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btnStar1.frame = CGRectMake(165, 12, 18, 18); 
        if([self.strOrigin isEqualToString:@"Edit"])
        {
            if(value >= 1)
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            }
        }
        else
        {
            [btnStar1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        }
        btnStar1.tag = 1;
        [btnStar1 addTarget:self action:@selector(dirtiness:) forControlEvents:UIControlEventTouchUpInside];
        [btnStar1 setUserInteractionEnabled:YES];
        btn1 = btnStar1;
        [cell addSubview:btnStar1];
        
        UIButton *btnStar2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btnStar2.frame = CGRectMake(190, 12, 18, 18); 
        if([self.strOrigin isEqualToString:@"Edit"])
        {
            if(value >= 2)
            {
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnStar2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            }
        }
        else
        {
            [btnStar2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        }
        btnStar2.tag = 2;
        [btnStar2 addTarget:self action:@selector(dirtiness:) forControlEvents:UIControlEventTouchUpInside];
        [btnStar2 setUserInteractionEnabled:YES];
        btn2 = btnStar2;
        [cell addSubview:btnStar2];
        
        UIButton *btnStar3 = [UIButton buttonWithType:UIButtonTypeCustom];
        btnStar3.frame = CGRectMake(215, 12, 18, 18); 
        if([self.strOrigin isEqualToString:@"Edit"])
        {
            if(value >= 3)
            {
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            }
        }
        else
        {
            [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        }
        btnStar3.tag = 3;
        [btnStar3 addTarget:self action:@selector(dirtiness:) forControlEvents:UIControlEventTouchUpInside];
        [btnStar3 setUserInteractionEnabled:YES];
        btn3 = btnStar3;
        [cell addSubview:btnStar3];
        
        UIButton *btnheart1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btnheart1.frame = CGRectMake(240, 12, 18, 18); 
        if([self.strOrigin isEqualToString:@"Edit"])
        {
            if(value >= 4)
            {
                [btnheart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnheart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            }
        }
        else
        {
            [btnheart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
        }
        btnheart1.tag = 4;
        [btnheart1 addTarget:self action:@selector(dirtiness:) forControlEvents:UIControlEventTouchUpInside];
        [btnheart1 setUserInteractionEnabled:YES];
        btn4 = btnheart1;
        [cell addSubview:btnheart1];
        
        UIButton *btnheart2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btnheart2.frame = CGRectMake(265, 12, 18, 18); 
        if([self.strOrigin isEqualToString:@"Edit"])
        {
            if(value >= 5)
            {
                [btnheart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnheart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            }
        }
        else
        {
            [btnheart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        }
        
        btnheart2.tag = 5;
        [btnheart2 addTarget:self action:@selector(dirtiness:) forControlEvents:UIControlEventTouchUpInside];
        [btnheart2 setUserInteractionEnabled:YES];
        btn5 = btnheart2;
        [cell addSubview:btnheart2];
        
        UIButton *btnLips = [UIButton buttonWithType:UIButtonTypeCustom];
        btnLips.frame = CGRectMake(290, 12, 18, 18); 
        if([self.strOrigin isEqualToString:@"Edit"])
        {
            if(value == 6)
            {
                [btnLips setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            }
        }
        else
        {
            [btnLips setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
        }
        
        btnLips.tag = 6;
        [btnLips addTarget:self action:@selector(dirtiness:) forControlEvents:UIControlEventTouchUpInside];
        [btnLips setUserInteractionEnabled:YES];
        btn6 = btnLips;
        [cell addSubview:btnLips];
        
    }
    else if(indexPath.row == 6)
    {
        cell.textLabel.text = @"Share";
        cell.accessoryView = [[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    }
    
    
    
    
    
    [cell.textLabel setFont: [UIFont fontWithName:@"Segoe Print" size:15.0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0, 45, 320, 3)];
    [seprator setImage:[UIImage imageNamed:@"divider.png"]];
    [cell addSubview:seprator];
    [seprator release];
    
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


-(void)segmentAction:(id)sender
{
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    
    switch (seg.tag) 
    {
        case 2:switch(seg.selectedSegmentIndex)
        {
            case 0:self.strActive = @"1";
                break;
            case 1:self.strActive = @"0";
                break;
            default:break;
        }
            break;
        case 3:switch(seg.selectedSegmentIndex)
        {
            case 0:self.strGender = @"1";
                break;
            case 1:self.strGender = @"2";
                break;
            case 2:self.strGender = @"0";
                break;
            default:break;
        }
            break;
        case 5:switch(seg.selectedSegmentIndex)
        {
            case 0:self.strDirtiness = @"3";
                break;
            case 1:self.strDirtiness = @"5";
                break;
            case 2:self.strDirtiness = @"6";
                break;
            default:break;
        }
            break;
            
        default:break;
    }
}

-(void)dirtiness:(id)sender
{
    UIButton *btn = (UIButton *) sender;
    
    if(btn.tag == 1)
    {
        if([self.strOrigin isEqualToString:@"Edit"])
        {
            if([btn.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
            {
                [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                
                strDirtiness = @"1";
                
            }
        }
        else
        {
            if([btn1.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
            {
                [btn1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                strDirtiness = @"1";
            } 
        }
    }
    if(btn.tag == 2)
    {
        if([btn2.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
        {
            [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            strDirtiness = @"1";
        }
        else
        {
            [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            strDirtiness = @"2";
            
            
        }
        
    }
    if(btn.tag == 3)
    {
        if([btn3.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
        {
            [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            strDirtiness = @"2";
        }
        else
        {
            [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            strDirtiness = @"3";
        }
        
    }
    if(btn.tag == 4)
    {
        if([btn4.currentImage isEqual:[UIImage imageNamed:@"heart1.png"]])
        {
            [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            strDirtiness = @"3";
        }
        else
        {
            [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            strDirtiness = @"4";
        }
        
    }
    if(btn.tag == 5)
    {
        if([btn5.currentImage isEqual:[UIImage imageNamed:@"heart1.png"]])
        {
            [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            strDirtiness = @"4";
        }
        else
        {
            [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            strDirtiness = @"5";
        }
        
    }
    if(btn.tag == 6)
    {
        if([btn6.currentImage isEqual:[UIImage imageNamed:@"lips1.png"]])
        {
            [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            strDirtiness = @"5";
        }
        else
        {
            [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btn4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btn5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btn6 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
            strDirtiness = @"6";
        }
        
    }
    
    
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
