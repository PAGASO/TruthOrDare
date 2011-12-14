//
//  DirtyViewController.m
//  TruthOrDare
//
//  Created by Administrator on 09/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DirtyViewController.h"

@implementation DirtyViewController
@synthesize btnStar1, btnStar2, btnStar3, btnHeart1, btnHeart2, btnLips;

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


#pragma mark custom methods
-(IBAction)changeDirtiness:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if(btn.tag == 1)
    {
        if([btn.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
        {
            [btn setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
        }
    }
    if(btn.tag == 2)
    {
        if([btn.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
        {
            [btn setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
        }

    }
    if(btn.tag == 3)
    {
        if([btn.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
        {
            [btn setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
        }

    }
    if(btn.tag == 4)
    {
        if([btn.currentImage isEqual:[UIImage imageNamed:@"heart1.png"]])
        {
            [btn setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
        }

    }
    if(btn.tag == 5)
    {
        if([btn.currentImage isEqual:[UIImage imageNamed:@"heart1.png"]])
        {
            [btn setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
        }

    }
    if(btn.tag == 6)
    {
        if([btn.currentImage isEqual:[UIImage imageNamed:@"lips1.png"]])
        {
            [btn setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
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
