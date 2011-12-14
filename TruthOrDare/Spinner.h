//
//  Spinner.h
//  TruthOrDare
//
//  Created by Administrator on 30/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Spinner : UIView {
	/*Activity Indicator to be used as spinner*/
	UIActivityIndicatorView *spinner;
	UIProgressView *progressBar;
	UIView *parent;
	NSString * message;
	NSString * altMessage;
	NSString * teamMessage;
	
	NSLock *lock;
	
	int BusyStopCall;
    
    UILabel *lblPleaseWait;
    UILabel *lblMessage;
	Boolean isShowing;
    Spinner *spin;
    
    
@private
	UILabel * lblTeamMessage;
}
@property (nonatomic, retain) UILabel *lblMessage;
@property (nonatomic, retain) UILabel *lblPleaseWait;
@property (nonatomic, retain) UIActivityIndicatorView *spinner;
@property (nonatomic, retain) UIProgressView *progressBar;
@property (nonatomic, retain) UIView *parent;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * altMessage;
@property (nonatomic, retain) NSString * teamMessage;

@property (nonatomic, retain) UILabel * lblTeamMessage;


+ (id)sharedSpiner;
- (id)initWithParent:(UIView *)pParent Message:(NSString*)msg AdditionalMessage:(NSString*)AdlMsg;
- (void)StopSpinner;
- (void)updateProgress:(NSNumber*) number;
- (void) show;

//| Updates a text of teamMesaage label
- (void) setTeamMessage:(NSString *)text;
-(void)willRotateWithOrientation;


- (void)showProgress :(UIViewController*)viewController message:(NSString*)massageString;
- (void)hideProgress :(UIViewController*)viewController;



@end
