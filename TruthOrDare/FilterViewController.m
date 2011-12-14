//
//  FilterViewController.m
//  TruthOrDare
//
//  Created by Administrator on 30/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FilterViewController.h"
#import "UserDefaultSettings.h"

@implementation FilterViewController

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
    [lblTitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:20.0]];
    [lblTitle setTextColor:[UIColor whiteColor]];
    
    dictFilter = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Filter"];
    if([dictFilter count] == 0)
    {
        strMin = @"1";
        strMax = @"6";
        strSource = @"Built in";
        strActive = @"Active";
        strGender = @"Both";
    }
    else
    {
        strMin = [dictFilter valueForKey:@"Min"];
        strMax = [dictFilter valueForKey:@"Max"];
        strSource = [dictFilter valueForKey:@"Source"];
        strActive = [dictFilter valueForKey:@"Active"];
        strGender = [dictFilter valueForKey:@"Gender"];
    }
    
    minCount = strMin.integerValue;
    maxCount = strMax.integerValue;
}


-(void)viewWillAppear:(BOOL)animated
{
    [lblDirtiness setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
    [lblMin setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
    [lblMax setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
    [lblSource setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
    [lblActive setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
    [lblGender setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
    
    NSString *str = [[UIDevice currentDevice] systemVersion];
    float version = str.floatValue;
    
    /*
    UISegmentedControl *segmentedControlMin = [[UISegmentedControl alloc] initWithItems:
                                            [NSArray arrayWithObjects:
                                             @"Clean",
                                             @"Dirty",
                                             @"Super Dirty",
                                             nil]];
    [segmentedControlMin addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segmentedControlMin.frame = CGRectMake(108, 85, 200, 30);
    if([strMin isEqualToString:@"Clean"])
    {
        segmentedControlMin.selectedSegmentIndex = 0;
    }
    else if([strMin isEqualToString:@"Dirty"])
    {
        segmentedControlMin.selectedSegmentIndex = 1;
    }
    else
    {
        segmentedControlMin.selectedSegmentIndex = 2;
    }

    segmentedControlMin.tag = 0;
    //UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
    
    
    if(version == 5.0)
    {
        UIFont *font = [UIFont fontWithName:@"SegoePrint-Bold" size:10.0];
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
        [segmentedControlMin setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
    [segmentedControlMin setMultipleTouchEnabled:YES];
    [self.view addSubview:segmentedControlMin];
    [segmentedControlMin release];
    
    UISegmentedControl *segmentedControlMax = [[UISegmentedControl alloc] initWithItems:
                                               [NSArray arrayWithObjects:
                                                @"Clean",
                                                @"Dirty",
                                                @"Super Dirty",
                                                nil]];
    [segmentedControlMax addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segmentedControlMax.frame = CGRectMake(108, 125, 200, 30);
    if([strMax isEqualToString:@"Clean"])
    {
        segmentedControlMax.selectedSegmentIndex = 0;
    }
    else if([strMax isEqualToString:@"Dirty"])
    {
        segmentedControlMax.selectedSegmentIndex = 1;
    }
    else
    {
        segmentedControlMax.selectedSegmentIndex = 2;
    }
   
    segmentedControlMax.tag = 1;
    if(version == 5.0)
    {
        UIFont *font = [UIFont fontWithName:@"SegoePrint-Bold" size:10.0];
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
        [segmentedControlMax setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
    [self.view addSubview:segmentedControlMax];
    [segmentedControlMax release];
    */
    
    if([strMax isEqualToString:@"1"])
    {
        [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
        [btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
    }
    if([strMax isEqualToString:@"2"])
    {
        [btnMax1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
        [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
    }
    if([strMax isEqualToString:@"3"])
    {
        [btnMax1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
        [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
    }
    if([strMax isEqualToString:@"4"])
    {
        [btnMax1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMax4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
        [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
    }
    if([strMax isEqualToString:@"5"])
    {
        [btnMax1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMax5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
        [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
    }
    if([strMax isEqualToString:@"6"])
    {
        [btnMax1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMax6 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
    }
    
    
    // for min
    if([strMin isEqualToString:@"1"])
    {
        [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
        [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
    }
    if([strMin isEqualToString:@"2"])
    {
        [btnMin1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
        [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
    }
    if([strMin isEqualToString:@"3"])
    {
        [btnMin1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMin3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
        [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
    }
    if([strMin isEqualToString:@"4"])
    {
        [btnMin1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMin4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
        [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
    }
    if([strMin isEqualToString:@"5"])
    {
        [btnMin1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMin4 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
        [btnMin5 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
        [btnMin6 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
    }
    if([strMin isEqualToString:@"6"])
    {
        [btnMin1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        [btnMin6 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
    }
    
     
    UISegmentedControl *segmentedControlSource = [[UISegmentedControl alloc] initWithItems:
                                               [NSArray arrayWithObjects:
                                                @"Built in",
                                                @"Mine",
                                                nil]];
    [segmentedControlSource addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segmentedControlSource.frame = CGRectMake(155, 165, 150, 30);
    if([strSource isEqualToString:@"Built in"])
    {
        segmentedControlSource.selectedSegmentIndex = 0;
    }
    else
    {
        segmentedControlSource.selectedSegmentIndex = 1;
    }
    segmentedControlSource.tag = 2;
    if(version == 5.0)
    {
        UIFont *font = [UIFont fontWithName:@"SegoePrint-Bold" size:10.0];
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
        [segmentedControlSource setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
    [self.view addSubview:segmentedControlSource];
    [segmentedControlSource release];

    UISegmentedControl *segmentedControlActive = [[UISegmentedControl alloc] initWithItems:
                                                  [NSArray arrayWithObjects:
                                                   @"Active",
                                                   @"Inactive",
                                                   nil]];
    [segmentedControlActive addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segmentedControlActive.frame = CGRectMake(155, 205, 150, 30);
    if([strActive isEqualToString:@"Active"])
    {
        segmentedControlActive.selectedSegmentIndex = 0;
    }
    else
    {
        segmentedControlActive.selectedSegmentIndex = 1;
    }
    segmentedControlActive.tag = 3;
    if(version == 5.0)
    {
        UIFont *font = [UIFont fontWithName:@"SegoePrint-Bold" size:10.0];
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
        [segmentedControlActive setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
    [self.view addSubview:segmentedControlActive];
    [segmentedControlActive release];
    
    UISegmentedControl *segmentedControlGender = [[UISegmentedControl alloc] initWithItems:
                                               [NSArray arrayWithObjects:
                                                @"Male",
                                                @"Female",
                                                @"Both",
                                                nil]];
    [segmentedControlGender addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segmentedControlGender.frame = CGRectMake(92, 245, 215, 30);
    if([strGender isEqualToString:@"Male"])
    {
        segmentedControlGender.selectedSegmentIndex = 0;
    }
    else if([strGender isEqualToString:@"Female"])
    {
        segmentedControlGender.selectedSegmentIndex = 1;
    }
    else
    {
        segmentedControlGender.selectedSegmentIndex = 2;
    }
    segmentedControlGender.tag = 4;
    if(version == 5.0)
    {
        UIFont *font = [UIFont fontWithName:@"SegoePrint-Bold" size:10.0];
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
        [segmentedControlGender setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
    [self.view addSubview:segmentedControlGender];
    [segmentedControlGender release];

}

#pragma mark custom methods

-(IBAction)back
{
    NSArray *objects = [NSArray arrayWithObjects:
                        strMin, 
                        strMax, 
                        strSource, 
                        strActive,
                        strGender,
                        nil];
    NSArray *keys = [NSArray arrayWithObjects:@"Min", @"Max", @"Source", @"Active", @"Gender",nil];
    
    if (dictFilter != nil)
    {
        dictFilter = nil;
    }
    dictFilter = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    [[UserDefaultSettings sharedSetting] storeDictionary:dictFilter withKey:@"Filter"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)segmentAction:(id)sender
{
    UISegmentedControl *seg = (UISegmentedControl *)sender;
   
    switch (seg.tag) 
	{
            
		case 0:switch(seg.selectedSegmentIndex)
                {
                    case 0:strMin = @"Clean";
                        break;
                    case 1:strMin = @"Dirty";
                        break;
                    case 2:strMin = @"Super Dirty";
                        break;
                    default:break;
                }
                break;
        case 1:switch(seg.selectedSegmentIndex)
                {
                    case 0:strMax = @"Clean";
                        break;
                    case 1:strMax = @"Dirty";
                        break;
                    case 2:strMax = @"Super Dirty";
                        break;
                    default:break;
                }
                break;
        case 2:switch(seg.selectedSegmentIndex)
                {
                    case 0:strSource = @"Built in";
                        break;
                    case 1:strSource = @"Mine";
                        break;
                    default:break;
                }
                break;
        case 3:switch(seg.selectedSegmentIndex)
                {
                    case 0:strActive = @"Active";
                        break;
                    case 1:strActive = @"InActive";
                        break;
                    default:break;
                }
               break;
        case 4:switch(seg.selectedSegmentIndex)
                {
                    case 0:strGender = @"Male";
                        break;
                    case 1:strGender = @"Female";
                        break;
                    case 2:strGender = @"Both";
                        break;
                    default:break;
                }
                break;
            
        default:break;
    }
}

-(IBAction)setMax:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if(btn.tag == 1)
    {
        if([btnMax1.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
        {
            //[btnMax1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            //[btnMax6 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            maxCount = 1;
            strMax = @"1";
            [self checkMin];
        }
    }
    if(btn.tag == 2)
    {
        if([btnMax2.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
        {
            //[btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            //[btnMax6 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            maxCount = 2;
            strMax = @"2";
            [self checkMin];
        }
        
    }
    if(btn.tag == 3)
    {
        if([btnMax3.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
        {
            //[btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            //[btnMax6 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            maxCount = 3;
            strMax = @"3";
            [self checkMin];
        }
        
    }
    if(btn.tag == 4)
    {
        if([btnMax4.currentImage isEqual:[UIImage imageNamed:@"lips1.png"]])
        {
            //[btnMax4 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            //[btnMax6 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            maxCount = 4;
            strMax = @"4";
            [self checkMin];
        }
        
    }
    if(btn.tag == 5)
    {
        if([btnMax5.currentImage isEqual:[UIImage imageNamed:@"lips1.png"]])
        {
            //[btnMax5 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            //[btnMax6 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            maxCount = 5;
            strMax = @"5";
            [self checkMin];
        }
        
    }
    if(btn.tag == 6)
    {
        if([btnMax6.currentImage isEqual:[UIImage imageNamed:@"heart1.png"]])
        {
            //[btnMax6 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
            maxCount = 6;
            strMax = @"6";
            [self checkMin];
        }
        
    }

}
-(IBAction)setMin:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if(btn.tag == 1)
    {
        if([btnMin1.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
        {
            //[btnMin1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            minCount = 1;
            strMin = @"1";
            [self checkMax];
            
        }
    }
    if(btn.tag == 2)
    {
        if([btnMin2.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
        {
            //[btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            //[btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal]; //default
        }
        else
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            minCount = 2;
            strMin = @"2";
            [self checkMax];
        }
        
    }
    if(btn.tag == 3)
    {
        if([btnMin3.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
        {
            //[btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            //[btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            minCount = 3;
            strMin = @"3";
            [self checkMax];
        }
        
    }
    if(btn.tag == 4)
    {
        if([btnMin4.currentImage isEqual:[UIImage imageNamed:@"lips1.png"]])
        {
            //[btnMin4 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            //[btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            minCount = 4;
            strMin = @"4";
            [self checkMax];
        }
        
    }
    if(btn.tag == 5)
    {
        if([btnMin5.currentImage isEqual:[UIImage imageNamed:@"lips1.png"]])
        {
            //[btnMin5 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            //[btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            minCount = 5;
            strMin = @"5";
            [self checkMax];
        }
        
    }
    if(btn.tag == 6)
    {
        if([btnMin6.currentImage isEqual:[UIImage imageNamed:@"heart1.png"]])
        {
            //[btnMin6 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            //[btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
            minCount = 6;
            strMin = @"6";
            [self checkMax];
        }
        
    }

}

-(void)checkMin
{
    if(minCount > maxCount)
    {
        if(maxCount == 2)
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            minCount = 1;
            strMin = @"1";
        }
        else if(maxCount == 3)
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            minCount = 2;
            strMin = @"2";
        }
        else if(maxCount == 4)
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            minCount = 3;
            strMin = @"3";
        }
        else if(maxCount == 5)
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            minCount = 4;
            strMin = @"4";
        }
        else if(maxCount == 6)
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            minCount = 5;
            strMin = @"5";
        }
        else // for maxcount = 1
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            minCount = 1;
            strMin = @"1";
        }
    }
    
}

-(void)checkMax
{
    if(minCount > maxCount)
    {
        if(minCount == 1)
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            maxCount = 2;
            strMax = @"2";
        }
        else if (minCount == 2)
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            maxCount = 3;
            strMax = @"3";
        }
        else if (minCount == 3)
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            maxCount = 4;
            strMax = @"4";
        }
        else if (minCount == 4)
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            maxCount = 5;
            strMax = @"5";
        }
        else if (minCount == 5)
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
            maxCount = 6;
            strMax = @"6";
        }
        else
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
            maxCount = 6;
            strMax = @"6";
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
