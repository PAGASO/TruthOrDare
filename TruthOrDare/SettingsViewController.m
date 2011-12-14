//
//  SettingsViewController.m
//  TruthOrDare
//
//  Created by Administrator on 29/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "TruthAndDareList.h"
#import "UserDefaultSettings.h"

@implementation SettingsViewController


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
   
    
    
    
    dictSettings = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Settings"];
    if([dictSettings count] == 0)
    {
        strSound = @"ON";
        strTakesTrueInOrder = @"ON";
        strMyDaresOnly = @"ON";
        strAllowChangingDares = @"ON";
       
    }
    else
    {
        strSound = [dictSettings valueForKey:@"Sound"];
        strTakesTrueInOrder = [dictSettings valueForKey:@"Takes True In Order"];
        strMyDaresOnly = [dictSettings valueForKey:@"My Dares Only"];
        strAllowChangingDares = [dictSettings valueForKey:@"Allow Changing Dares"];
    }
    
     [lblTitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:20.0]];
}

-(void)viewWillAppear:(BOOL)animated
{
    tblSettings.backgroundColor = [UIColor clearColor];
    tblSettings.scrollEnabled = NO;
        
}

#pragma mark custom methods
-(IBAction)back
{
    
   
    NSArray *objects = [NSArray arrayWithObjects:
                        strSound, 
                        strTakesTrueInOrder, 
                        strMyDaresOnly, 
                        strAllowChangingDares, 
                        nil];
    NSArray *keys = [NSArray arrayWithObjects:@"Sound", @"Takes True In Order", @"My Dares Only", @"Allow Changing Dares", nil];
    
    if (dictSettings != nil)
    {
        dictSettings = nil;
    }
    dictSettings = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    [[UserDefaultSettings sharedSetting] storeDictionary:dictSettings withKey:@"Settings"];    
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)addDare
{
    
    TruthAndDareList *truthObj = [[TruthAndDareList alloc] initWithNibName:@"TruthAndDareList" bundle:nil];
    [self.navigationController pushViewController:truthObj animated:YES];
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
    return 4;
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
       cell.textLabel.text = @"Sound"; 
        
    }
    else if(indexPath.row == 1)
    {
        cell.textLabel.text = @"Take Trues in order";
    }
    else if(indexPath.row == 2)
    {
        cell.textLabel.text = @"My Dare Only";
    }
    else if(indexPath.row == 3)
    {
        cell.textLabel.text = @"Allow Changing Dares";
    }
    
    
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
                                            [NSArray arrayWithObjects:
                                             @"On",
                                             @"Off",
                                             nil]];
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.frame = CGRectMake(210, 13, 100, 30);
    segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
    segmentedControl.tag = indexPath.row;
    
    NSString *str = [[UIDevice currentDevice] systemVersion];
    float version = str.floatValue;
    if(version == 5.0)
    {
        UIFont *font = [UIFont fontWithName:@"SegoePrint-Bold" size:10.0];
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
        [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
   
    
    if(indexPath.row == 0)
    {
        if([strSound isEqualToString:@"ON"])
            segmentedControl.selectedSegmentIndex = 0;
        else
            segmentedControl.selectedSegmentIndex = 1;
    }
    else if(indexPath.row == 1)
    {
        if([strTakesTrueInOrder isEqualToString:@"ON"])
            segmentedControl.selectedSegmentIndex = 0;
        else
            segmentedControl.selectedSegmentIndex = 1;
    }
    else if(indexPath.row == 2)
    {
        if([strMyDaresOnly isEqualToString:@"ON"])
            segmentedControl.selectedSegmentIndex = 0;
        else
            segmentedControl.selectedSegmentIndex = 1;
    }
    else if(indexPath.row == 3)
    {
        if([strAllowChangingDares isEqualToString:@"ON"])
            segmentedControl.selectedSegmentIndex = 0;
        else
            segmentedControl.selectedSegmentIndex = 1;
    }
    
    [cell addSubview:segmentedControl];
        
    [segmentedControl release];    
    
    [cell.textLabel setFont:[UIFont fontWithName:@"Segoe Print" size:15.0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    UIImageView *seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 320, 3)];
    [seprator setImage:[UIImage imageNamed:@"divider.png"]];
    [cell addSubview:seprator];
    [seprator release];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)segmentAction:(id)sender
{
    UISegmentedControl *seg = (UISegmentedControl *)sender;
   
    
    switch (seg.tag) 
	{
        
		case 0:switch(seg.selectedSegmentIndex)
                {
                    case 0:strSound = @"ON";
                        break;
                    case 1:strSound = @"OFF";
                        break;
                    default:break;
                }
                break;
		case 1:switch(seg.selectedSegmentIndex)
                {
                    case 0:strTakesTrueInOrder = @"ON";
                        break;
                    case 1:strTakesTrueInOrder = @"OFF";
                        break;
                    default:break;
                }
                break;
        case 2:switch(seg.selectedSegmentIndex)
                {
                    case 0:strMyDaresOnly = @"ON";
                        break;
                    case 1:strMyDaresOnly = @"OFF";
                        break;
                    default:break;
                }
                break;
        case 3:switch(seg.selectedSegmentIndex)
                {
                    case 0:strAllowChangingDares = @"ON";
                        break;
                    case 1:strAllowChangingDares = @"OFF";
                        break;
                    default:break;
                }
                break;   
		
		default:break;
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
