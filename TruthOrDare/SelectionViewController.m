//
//  SelectionViewController.m
//  TruthOrDare
//
//  Created by Administrator on 06/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectionViewController.h"
#import "TruthOrDareDisplayView.h"
#import "DirtyViewController.h"

@implementation SelectionViewController
@synthesize strPlayerName;

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
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [lblPlayerName setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:25.0]];
    [lblPlayerName setTextColor:[UIColor whiteColor]]; 
    
    lblPlayerName.text = strPlayerName;
    
    DirtyViewController *dirtyView = [[DirtyViewController alloc] initWithNibName:@"DirtyViewController" bundle:nil];
    dirtyView.view.frame = CGRectMake(36, 330, 248, 36);
    dirtyView.view.backgroundColor = [UIColor clearColor];

    [self.view addSubview:dirtyView.view];
    
}

#pragma mark custom methods
-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)displayTruthOrDare:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    TruthOrDareDisplayView *displayObj = [[TruthOrDareDisplayView alloc] initWithNibName:@"TruthOrDareDisplayView" bundle:nil];
    displayObj.strPlayerName = self.strPlayerName;
    if(btn.tag == 1)
        displayObj.strMode = @"Truth";
    else 
        displayObj.strMode = @"Dare";
    
    [self.navigationController pushViewController:displayObj animated:YES];
    [displayObj release];
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
