//
//  PlayViewController.m
//  TruthOrDare
//
//  Created by Administrator on 06/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayViewController.h"
#import "SelectionViewController.h"
#import "UserDefaultSettings.h"


@implementation PlayViewController

@synthesize viewPlayerName, lblName, lblPlayText;
@synthesize arrPlayerName, arrPlayerGender;

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
    appDelegate = (TruthOrDareAppDelegate *) [[UIApplication sharedApplication]delegate];
    
    dictTruthOrder = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Settings"];
    strOrder = [dictTruthOrder objectForKey:@"Takes True In Order"];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.viewPlayerName.frame = CGRectMake(-320, 60, 320, 200);
    self.viewPlayerName.hidden = YES;
    
    [lblName setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:25.0]];
    [lblName setTextColor:[UIColor whiteColor]]; 
    
    if(appDelegate.playerCount == [arrPlayerName count])
    {
        appDelegate.playerCount = 0;
    }
    
    if(appDelegate.playerCount < [arrPlayerName count])
    {
        lblName.text = [arrPlayerName objectAtIndex:appDelegate.playerCount];
    }
    
    
    [lblPlayText setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:30.0]];
    [lblPlayText setTextColor:[UIColor whiteColor]];
}

-(void)viewDidAppear:(BOOL)animated
{
    self.viewPlayerName.hidden = NO;
    [self showPlayerName];
}

#pragma mark custom methods

-(void) showPlayerName
{
    //self.frame = CGRectMake(0, 0, 320, 480);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    self.viewPlayerName.frame = CGRectMake(0,60,320,200);
    [UIView commitAnimations];

}

#pragma mark custom methods
-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)selection:(id)sender
{
    CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:self.viewPlayerName cache:NO];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:1.0];
	[UIView commitAnimations];
    
    self.viewPlayerName.hidden = YES;
    
    [self performSelector:@selector(pushSelectionView) withObject:nil afterDelay:0.5];
    
    
}

-(void)pushSelectionView
{
    
    SelectionViewController *selectObj = [[SelectionViewController alloc] initWithNibName:@"SelectionViewController" bundle:nil];
    selectObj.strPlayerName = [self.arrPlayerName objectAtIndex:appDelegate.playerCount];
    [self.navigationController pushViewController:selectObj animated:YES];
    [selectObj release];
    
    if([strOrder isEqualToString:@"ON"])
    {
        appDelegate.playerCount = appDelegate.playerCount + 1;
    }
    else
    {
        appDelegate.playerCount = arc4random() % [arrPlayerName count];
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
