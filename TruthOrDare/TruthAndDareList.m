//
//  TruthAndDareList.m
//  TruthOrDare
//
//  Created by Administrator on 25/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TruthAndDareList.h"
#import "EditTruthOrDareViewController.h"
#import "FilterViewController.h"

#define CELL_CONTENT_WIDTH 270.0f
#define CELL_CONTENT_MARGIN 5.0

static sqlite3_stmt *getStmt = nil;

@implementation TruthAndDareList


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
    // Do any additional setup after loading the view from its nib.
    appDelegate = (TruthOrDareAppDelegate *) [[UIApplication sharedApplication] delegate];
    //initialize the arrays
    arrTruth = [[NSMutableArray alloc] init];
    arrTruthId = [[NSMutableArray alloc] init];
    arrTruthDirty = [[NSMutableArray alloc] init];
    arrTruthPlayer = [[NSMutableArray alloc] init];
    arrTruthGender = [[NSMutableArray alloc] init];
    
    arrDare = [[NSMutableArray alloc] init];
    arrDareId = [[NSMutableArray alloc] init];
    arrDareDirty = [[NSMutableArray alloc] init];
    arrDarePlayer = [[NSMutableArray alloc] init];
    arrDareGender = [[NSMutableArray alloc] init];
    
    flgTruth = YES;
    flgDare = NO;
    
    tblTruth.backgroundColor = [UIColor clearColor];
    spinner = (Spinner *) [Spinner sharedSpiner];
    [spinner showProgress:self message:@"Please Wait..."];
}

-(void)viewWillAppear:(BOOL)animated
{
         
   

}

-(void)viewDidAppear:(BOOL)animated
{
    if([arrTruth count] == 0 && [arrDare count] == 0 )
    {
        [self getTruthList];
        [self getDareList];
        [tblTruth reloadData];
        [spinner hideProgress:self];
        NSLog(@"LAST DATA :- %@", [arrTruth lastObject]);
        NSLog(@"LAST DATA ID :- %@", [arrTruthId lastObject]);
        NSLog(@"LAST DATA Gender :- %@", [arrTruthGender lastObject]);
        NSLog(@"LAST DATA Dirtiness :- %@", [arrTruthDirty lastObject]);
        
    }
    if(appDelegate.flgUpdate == TRUE)
    {
        [spinner showProgress:self message:@"Please Wait..."];
        if(flgTruth)
        {
            [arrTruth removeAllObjects];
            [arrTruthId removeAllObjects];
            [arrTruthDirty removeAllObjects];
            [arrTruthPlayer removeAllObjects];
            [arrTruthGender removeAllObjects];
            [self getTruthList];
        }
        else
        {
            [arrDare removeAllObjects];
            [arrDareId removeAllObjects];
            [arrDareDirty removeAllObjects];
            [arrDarePlayer removeAllObjects];
            [arrDareGender removeAllObjects];
            [self getDareList];
        }
        [tblTruth reloadData];
        appDelegate.flgUpdate = FALSE;
        [spinner hideProgress:self];
    }
}

-(IBAction)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)filter
{
    FilterViewController *filterObj = [[FilterViewController alloc] initWithNibName:@"FilterViewController" bundle:nil];
    [self.navigationController pushViewController:filterObj animated:YES];
}

-(IBAction)truthList
{
    
    NSLog(@"truth IIINNSide");
    flgTruth = YES;
    flgDare = NO;
    
    [btnTruth setImage:[UIImage imageNamed:@"truthselected.png"] forState:UIControlStateNormal];
    [btnDare setImage:[UIImage imageNamed:@"darenormal.png"] forState:UIControlStateNormal];
    
    [tblTruth reloadData];
}

-(IBAction)dareList
{
    NSLog(@"IIINNSide");
    flgDare = YES;
    flgTruth = NO;
    
    [btnDare setImage:[UIImage imageNamed:@"dareselected.png"] forState:UIControlStateNormal];
    [btnTruth setImage:[UIImage imageNamed:@"truthnormal.png"] forState:UIControlStateNormal];
       
    [tblTruth reloadData];
    
}

#pragma mark table data source methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(flgTruth)
        return [arrTruth count];
    else
        return [arrDare count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
       
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d",indexPath.row];
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = nil;
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
       
    }
    
    if (flgTruth) // data for truth2
    {
        UILabel *lbl = [ [UILabel alloc ] initWithFrame:CGRectZero];
        
        lbl.textAlignment =  UITextAlignmentLeft;
        lbl.textColor = [UIColor whiteColor];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.lineBreakMode = UILineBreakModeWordWrap;
        lbl.numberOfLines = 0;
        lbl.font = [UIFont fontWithName:@"SegoePrint" size:15.0];
        //lbl.text = [arrTruth objectAtIndex:indexPath.row];
        //[cell addSubview:lbl];
        
        [[cell contentView] addSubview:lbl];
        //[lbl release];
        
        
        NSString *text = [arrTruth objectAtIndex:[indexPath row]];
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        if (!lbl)
            lbl = (UILabel*)[cell viewWithTag:1];
        
        [lbl setText:text];
        [lbl setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 82.0f))];
        [lbl release];
        
        
        
    }
    else //data for dare
    {
        UILabel *lblDare = [ [UILabel alloc ] initWithFrame:CGRectZero];
        
        lblDare.textAlignment =  UITextAlignmentLeft;
        lblDare.textColor = [UIColor whiteColor];
        lblDare.backgroundColor = [UIColor clearColor];
        lblDare.lineBreakMode = UILineBreakModeWordWrap;
        lblDare.numberOfLines = 0;
        lblDare.font = [UIFont fontWithName:@"SegoePrint" size:15.0];
        //lbl.text = [arrTruth objectAtIndex:indexPath.row];
        //[cell addSubview:lbl];
        [[cell contentView] addSubview:lblDare];
        //[lbl release];
        
        NSString *text = [arrDare objectAtIndex:[indexPath row]];
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        if (!lblDare)
            lblDare = (UILabel*)[cell viewWithTag:1];
        
        [lblDare setText:text];
        [lblDare setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 82.0f))];
        [lblDare release];
        
    }
    
    UIButton *btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEdit.frame = CGRectMake(275, 20, 39, 39); 
    [btnEdit setImage:[UIImage imageNamed:@"editbtn.png"] forState:UIControlStateNormal];
    btnEdit.tag = indexPath.row;
    [btnEdit addTarget:self action:@selector(editPlayer:) forControlEvents:UIControlEventTouchUpInside];
    [btnEdit setUserInteractionEnabled:YES];
    [cell addSubview:btnEdit];
    
    UIImageView *seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0, 82, 320, 3)];
    [seprator setImage:[UIImage imageNamed:@"divider.png"]];
    [cell addSubview:seprator];
    [seprator release];

       
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
            
    return cell; 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = nil;
    if(flgTruth)
    {        
        text = [NSString stringWithFormat:@"%@",[arrTruth objectAtIndex:[indexPath row]]];
    }
    else
    {
        text = [arrDare objectAtIndex:[indexPath row]];
    }
       
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    CGFloat height = MAX(size.height, 82.0f);
    NSLog(@"Content height :- %f", size.height);
    NSLog(@"ROW HEIGHT :-- %f", height );
    return height + (CELL_CONTENT_MARGIN * 2);
            
    
    
}


#pragma mark custom methods
-(void)editPlayer:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    EditTruthOrDareViewController *editObj = [[EditTruthOrDareViewController alloc] initWithNibName:@"EditTruthOrDareViewController" bundle:nil];
    
    if(flgTruth)
    {
        editObj.strTitle = @"Truth";
        editObj.strValue = [arrTruth objectAtIndex:btn.tag];
        editObj.strPrimaryKey = [arrTruthId objectAtIndex:btn.tag];
        editObj.strGender = [arrTruthGender objectAtIndex:btn.tag];
        editObj.strPlayers = [arrTruthPlayer objectAtIndex:btn.tag];
        editObj.strDirtiness = [arrTruthDirty objectAtIndex:btn.tag];
        
        editObj.strLastId = [arrTruthId lastObject];
       
    }
    else
    {
        editObj.strTitle = @"Dare";
        editObj.strValue = [arrDare objectAtIndex:btn.tag];
        editObj.strPrimaryKey = [arrDareId objectAtIndex:btn.tag];
        editObj.strGender = [arrDareGender objectAtIndex:btn.tag];
        editObj.strPlayers = [arrDarePlayer objectAtIndex:btn.tag];
        editObj.strDirtiness = [arrDareDirty objectAtIndex:btn.tag];
        
        editObj.strLastId = [arrDareId lastObject];
    }
    
         editObj.strOrigin = @"Edit";
        
    [self.navigationController pushViewController:editObj animated:YES];
    [editObj release];
    
}

-(IBAction)add
{
    EditTruthOrDareViewController *editObj = [[EditTruthOrDareViewController alloc] initWithNibName:@"EditTruthOrDareViewController" bundle:nil];
    if(flgTruth)
    {    
        editObj.strTitle = @"Truth";
        editObj.strLastId = [arrTruthId lastObject];
    }
    else
    {
        editObj.strTitle = @"Dare";
        editObj.strLastId = [arrDareId lastObject];
    }
    editObj.strOrigin = @"Add";
    [self.navigationController pushViewController:editObj animated:YES];
    [editObj release];
}

-(void)getTruthList
{
    
    database = appDelegate.database;
    if(!getStmt)
	{
		NSString *queryStr = [NSString stringWithFormat:@"select pkTruthChallengeID, ln_EN, dirty, minplayers, Gender from tblTruth"];
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
    NSString *primaryKey;
    NSString *dirty;
    NSString *minplayers;
    NSString *gender;
	while((ret = sqlite3_step(getStmt)) == SQLITE_ROW)
	{
		
		
        //int primaryKey = sqlite3_column_int(getStmt, 0);
        //[arrTruthId addObject:[NSString stringWithFormat:@"%d", primaryKey]];
        char *pk = (char *) sqlite3_column_text(getStmt, 0);
		if(pk != NULL)
        {
            primaryKey = [NSString stringWithUTF8String:(char *)pk];
            [arrTruthId addObject:primaryKey];
        }
		
		char *truth = (char *) sqlite3_column_text(getStmt, 1);
		if(truth != NULL)
        {
            strTruth = [NSString stringWithUTF8String:(char *)truth];
            [arrTruth addObject:strTruth];	
        }
        
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
                
        
        
				
	}
	
	sqlite3_reset(getStmt);
	getStmt = nil;

    
   
}

-(void)getDareList
{
    if(database== nil)
    {
        database = appDelegate.database;
    }
    
    if(!getStmt)
	{
		NSString *queryStr = [NSString stringWithFormat:@"select pkDaresChallengeID, ln_EN, dirty, minplayers, gender from tblDare"];
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
    NSString *strDare;
    NSString *primaryKey;
    NSString *dirty;
    NSString *minplayers;
    NSString *gender;
	while((ret = sqlite3_step(getStmt)) == SQLITE_ROW)
	{
				
		char *pk = (char *) sqlite3_column_text(getStmt, 0);
		if(pk != NULL)
        {
            primaryKey = [NSString stringWithUTF8String:(char *)pk];
            [arrDareId addObject:primaryKey];
        }

		char *dare = (char *) sqlite3_column_text(getStmt, 1);
		if(dare != NULL)
        {
            strDare = [NSString stringWithUTF8String:(char *)dare];
			[arrDare addObject:strDare];		
        }
        
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

        
	}
	
	sqlite3_reset(getStmt);
	getStmt = nil;

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
