//
//  PlayViewController.h
//  TruthOrDare
//
//  Created by Administrator on 06/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TruthOrDareAppDelegate.h"

@interface PlayViewController : UIViewController
{
    IBOutlet UIView *viewPlayerName;
    IBOutlet UILabel *lblName;
    IBOutlet UILabel *lblPlayText;
    
    NSMutableArray *arrPlayerName;
    NSMutableArray *arrPlayerGender;
    
    TruthOrDareAppDelegate *appDelegate;
    
    NSDictionary *dictTruthOrder;
    NSString *strOrder;
    
}

@property (nonatomic, retain) IBOutlet UIView *viewPlayerName;
@property (nonatomic, retain) IBOutlet UILabel *lblName;
@property (nonatomic, retain) IBOutlet UILabel *lblPlayText;
@property (nonatomic, retain) NSMutableArray *arrPlayerName;
@property (nonatomic, retain) NSMutableArray *arrPlayerGender;

-(IBAction)back:(id)sender;
-(IBAction)selection:(id)sender;
-(void) showPlayerName;

@end
