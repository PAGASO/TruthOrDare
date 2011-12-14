//
//  SelectionViewController.h
//  TruthOrDare
//
//  Created by Administrator on 06/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//



@interface SelectionViewController : UIViewController
{
    IBOutlet UILabel *lblPlayerName;
    IBOutlet UIButton *btnTruth;
    IBOutlet UIButton *btnDare;
    
    NSString *strPlayerName;
}

@property (nonatomic, retain) NSString *strPlayerName;

-(IBAction)back:(id)sender;
-(IBAction)displayTruthOrDare:(id)sender;

@end
