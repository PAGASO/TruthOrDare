//
//  SettingsViewController.h
//  TruthOrDare
//
//  Created by Administrator on 29/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UIButton *btnBack;
    IBOutlet UIButton *btnAddDare;
    IBOutlet UITableView *tblSettings;
    IBOutlet UILabel *lblTitle;
    
    NSString *strSound;
    NSString *strTakesTrueInOrder;
    NSString *strMyDaresOnly;
    NSString *strAllowChangingDares;
    
    
    NSDictionary *dictSettings;
}



-(IBAction)back;
-(IBAction)addDare;


@end
