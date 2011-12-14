//
//  TruthOrDareDisplayView.h
//  TruthOrDare
//
//  Created by Administrator on 07/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TruthOrDareAppDelegate.h"

@interface TruthOrDareDisplayView : UIViewController
{
    IBOutlet UILabel *lblPlayerName;
    IBOutlet UILabel *lblDisplayText;
    
    NSString *strPlayerName;
    NSString *strMode;
    
    int randomNumber;
    
    TruthOrDareAppDelegate *appDelegate;
    
    NSDictionary *dictChangeDare;
    
    IBOutlet UIButton *btnFacebook;
    IBOutlet UIButton *btnCamera;
    IBOutlet UIButton *btnChangeDare;
    IBOutlet UIButton *btnTimer;
    
    IBOutlet UIButton *btnOk;
}

@property (nonatomic, retain) NSString *strPlayerName;
@property (nonatomic, retain) NSString *strMode;

-(IBAction)back:(id)sender;
-(IBAction)confirm:(id)sender;
-(IBAction)changeTruthOrDare:(id)sender;

@end
