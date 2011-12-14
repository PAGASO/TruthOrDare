//
//  TruthOrDareDisplayView.m
//  TruthOrDare
//
//  Created by Administrator on 07/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TruthOrDareDisplayView.h"
#import "PlayViewController.h"
#import "UserDefaultSettings.h"

@implementation TruthOrDareDisplayView
@synthesize strPlayerName;
@synthesize strMode;

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
    appDelegate = (TruthOrDareAppDelegate *) [UIApplication sharedApplication].delegate;
    btnOk.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [lblPlayerName setFont:[UIFont fontWithName:@"SegoePrint" size:25.0]];
    [lblPlayerName setTextColor:[UIColor whiteColor]]; 
    
    lblPlayerName.text = self.strPlayerName;
    
    [lblDisplayText setFont:[UIFont fontWithName:@"SegoePrint" size:25.0]];
    if([strMode isEqualToString:@"Truth"])
    {
        [lblDisplayText setTextColor:[UIColor colorWithRed:170.0/255.0 green:213.0/255.0 blue:114.0/255.0 alpha:1.0]];
        randomNumber = arc4random() % [appDelegate.arrDelegateTruth count];
    }
    else
    {
        [lblDisplayText setTextColor:[UIColor colorWithRed:253.0/255.0 green:144.0/255.0 blue:144.0/255.0 alpha:1.0]];
        randomNumber = arc4random() % [appDelegate.arrDelegateDare count];
    }
   
    dictChangeDare = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Settings"];
    NSString *strChangeDare = [dictChangeDare objectForKey:@"Allow Changing Dares"];
    
    if([strChangeDare isEqualToString:@"ON"])
    {
        btnFacebook.frame = CGRectMake(32,417,39,39);
        btnCamera.frame = CGRectMake(103,417,39,39);
        btnTimer.frame = CGRectMake(174,417,39,39);
        btnChangeDare.hidden = NO;
        btnChangeDare.frame = CGRectMake(245,417,39,39);
        
    }
    else
    {
        btnFacebook.frame = CGRectMake(50,417,39,39);
        btnCamera.frame = CGRectMake(139,417,39,39);
        btnTimer.frame = CGRectMake(228,417,39,39);
        btnChangeDare.hidden = YES;
    }

}

-(void)viewDidAppear:(BOOL)animated
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView setAnimationDuration:1.0];
    [lblDisplayText setAlpha:0];
    [btnOk setAlpha:0];
    [UIView commitAnimations];
    
    
    
}

//This delegate is called after the completion of Animation.
-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    btnOk.hidden = NO;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    [lblDisplayText setAlpha:1];
    [btnOk setAlpha:1];
    [UIView commitAnimations];
    
    if([strMode isEqualToString:@"Truth"])
        lblDisplayText.text =  [appDelegate.arrDelegateTruth objectAtIndex:randomNumber];
    else
        lblDisplayText.text =  [appDelegate.arrDelegateDare objectAtIndex:randomNumber];
    
    //btnOk.hidden = NO;
    
}


#pragma mark custom methods
-(IBAction)back:(id)sender
{
    NSArray *array = [self.navigationController viewControllers];
    
    for(int i=0; i<[array count]; i++)
    {
            if([[array objectAtIndex:i] isKindOfClass:[PlayViewController class]])
            {
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
                break;
            }
            
    }
    
    
    
    
    
}

-(IBAction)confirm:(id)sender
{
    NSArray *array = [self.navigationController viewControllers];
    
    for(int i=0; i<[array count]; i++)
    {
        if([[array objectAtIndex:i] isKindOfClass:[PlayViewController class]])
        {
            [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            break;
        }
        
    }
}


-(IBAction)changeTruthOrDare:(id)sender
{
    
    
    if([strMode isEqualToString:@"Truth"])
    {
        [lblDisplayText setTextColor:[UIColor colorWithRed:170.0/255.0 green:213.0/255.0 blue:114.0/255.0 alpha:1.0]];
        randomNumber = arc4random() % [appDelegate.arrDelegateTruth count];
    }
    else
    {
        [lblDisplayText setTextColor:[UIColor colorWithRed:253.0/255.0 green:144.0/255.0 blue:144.0/255.0 alpha:1.0]];
        randomNumber = arc4random() % [appDelegate.arrDelegateDare count];
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView setAnimationDuration:1.0];
    [lblDisplayText setAlpha:0];
    [btnOk setAlpha:0];
    [UIView commitAnimations];

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
