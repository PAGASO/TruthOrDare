//
//  DirtyViewController.h
//  TruthOrDare
//
//  Created by Administrator on 09/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DirtyViewController : UIViewController
{
    IBOutlet UIButton *btnStar1;
    IBOutlet UIButton *btnStar2;
    IBOutlet UIButton *btnStar3;
    IBOutlet UIButton *btnHeart1;
    IBOutlet UIButton *btnHeart2;
    IBOutlet UIButton *btnLips;
}

@property (nonatomic, retain) IBOutlet UIButton *btnStar1;
@property (nonatomic, retain) IBOutlet UIButton *btnStar2;
@property (nonatomic, retain) IBOutlet UIButton *btnStar3;
@property (nonatomic, retain) IBOutlet UIButton *btnHeart1;
@property (nonatomic, retain) IBOutlet UIButton *btnHeart2;
@property (nonatomic, retain) IBOutlet UIButton *btnLips;

-(IBAction)changeDirtiness:(id)sender;

@end
