//
//  FilterViewController.h
//  TruthOrDare
//
//  Created by Administrator on 30/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterViewController : UIViewController
{
    IBOutlet UIButton *btnBack;
    IBOutlet UILabel *lblTitle;
    
    IBOutlet UILabel *lblDirtiness;
    IBOutlet UILabel *lblMin;
    IBOutlet UILabel *lblMax;
    IBOutlet UILabel *lblSource;
    IBOutlet UILabel *lblActive;
    IBOutlet UILabel *lblGender;
    
    NSString *strMin;
    NSString *strMax;
    NSString *strSource;
    NSString *strActive;
    NSString *strGender;
    
    NSDictionary *dictFilter;
    
    IBOutlet UIButton *btnMax1;
    IBOutlet UIButton *btnMax2;
    IBOutlet UIButton *btnMax3;
    IBOutlet UIButton *btnMax4;
    IBOutlet UIButton *btnMax5;
    IBOutlet UIButton *btnMax6;
    
    IBOutlet UIButton *btnMin1;
    IBOutlet UIButton *btnMin2;
    IBOutlet UIButton *btnMin3;
    IBOutlet UIButton *btnMin4;
    IBOutlet UIButton *btnMin5;
    IBOutlet UIButton *btnMin6;
    
    int minCount;
    int maxCount;
}

-(IBAction)back;

-(IBAction)setMax:(id)sender;
-(IBAction)setMin:(id)sender;
-(void)checkMin;
-(void)checkMax;

@end
