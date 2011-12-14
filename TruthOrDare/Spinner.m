//
//  Spinner.m
//  TruthOrDare
//
//  Created by Administrator on 30/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Spinner.h"


#define SPINNER_CREATION_IN_PROGRESS 1
#define SPINNER_CREATION_COMPLETED   2
#define SPINNER_CREATION_NO			 3

static Spinner *sharedSpiner = nil;


@implementation Spinner

@synthesize spinner,progressBar;
@synthesize parent;
@synthesize message;
@synthesize altMessage;
@synthesize teamMessage;
@synthesize lblTeamMessage;
@synthesize lblPleaseWait;
@synthesize lblMessage;


+ (id)sharedSpiner{

    @synchronized(self) {
        if(sharedSpiner == nil)
            sharedSpiner = [[super alloc] init];
    }
    return sharedSpiner;


}
- (void)showProgress :(UIViewController*)viewController message:(NSString*)messageString
{
    if(isShowing)
    {
        
        return;
    }
    isShowing = YES;
    //[viewController.view setUserInteractionEnabled:NO];
    //[viewController.navigationController.navigationBar setUserInteractionEnabled:NO];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
	//[BT_debugger showIt:viewController:@"showProgress"];
    //[self Busy:@"" Notes:@""];
    
    [self setParent:viewController.view];
    [self setMessage:message];
    [self setAltMessage:messageString];
    
    lblPleaseWait.text = @"";
    
    
    if (messageString == @"" || messageString == nil) 
    {
    
        [self setAltMessage:@"Please Wait..."];
    }
    else 
    {
        [self setAltMessage:messageString];
    }
    
    [self performSelectorInBackground:@selector(show)
                           withObject:nil];
    
    [viewController.view setNeedsDisplay];
    
    //[self Busy:@"" Notes:massageString andViewController:viewController];
}

- (void)hideProgress :(UIViewController*)viewController
{
    if(!isShowing)
    {
        //return;
    }
    
    isShowing = NO;
    //[viewController.view setUserInteractionEnabled:YES];
    //[viewController.navigationController.navigationBar setUserInteractionEnabled:YES];
	//[BT_debugger showIt:self:@"hideProgress"];
    [self StopSpinner];
    if([[UIApplication sharedApplication] isIgnoringInteractionEvents])
    {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }
}







- (id)initWithParent:(UIView *)pParent Message:(NSString*)msg AdditionalMessage:(NSString*)AdlMsg
{
	//CGRect selfFrame = [[UIScreen mainScreen] applicationFrame];	
    CGRect selfFrame;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        selfFrame = CGRectMake(0, 0, 768, 1024);
    }
    else
    {
        selfFrame = CGRectMake(0, 0, 320, 480);
    }
    if ( (self = [super initWithFrame:selfFrame]) )
    {
		self.parent = pParent;
		self.message = msg;
		//self.altMessage = AdlMsg;
		
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        self.alpha           = .7;
		
		BusyStopCall = 0;
        spinner        = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        progressBar    = [[UIProgressView alloc] initWithFrame:CGRectMake(6.0, 20.0, self.frame.size.width-12, 20)];
        lblPleaseWait  = [[UILabel alloc] initWithFrame:CGRectMake(0, self.center.y-100, self.frame.size.width, 20)];
        lblMessage     = [[UILabel alloc] initWithFrame:CGRectMake(0, self.center.y+15, self.frame.size.width, 16)];
        lblTeamMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-52, self.frame.size.width, 15)];
        
        lblPleaseWait.font = [UIFont fontWithName:@"SegoePrint-Bold" size:20.0];
        lblMessage.font = [UIFont fontWithName:@"SegoePrint-Bold" size:20.0];
        lblTeamMessage.font = [UIFont fontWithName:@"SegoePrint-Bold" size:20.0];
        //lblMessage.font            = [UIFont fontWithName:@"Arial" size:14];
		lock = [[NSLock alloc] init];
    }
	//SpinnerWorking = SPINNER_CREATION_NO;
	
	
	return self;
}


- (void) show {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	//CGRect selfFrame = [[UIScreen mainScreen] applicationFrame];	
    CGRect selfFrame;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        selfFrame = CGRectMake(0, 0, 768, 1024);
    }
    else
    {
        selfFrame = CGRectMake(0, 0, 320, 480);
    }

    self.frame =selfFrame;
     self.backgroundColor = [UIColor blackColor];
    self.alpha           = .7;
    
    /*UILabel *lblTest = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 30)];
    lblTest.text = @"test text";
    [self.parent addSubview:lblTest];
    [self.parent bringSubviewToFront:lblTest]; 
    return;*/
    
    BusyStopCall = 0;
    spinner        = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    progressBar    = [[UIProgressView alloc] initWithFrame:CGRectMake(6.0, 20.0, self.frame.size.width-12, 20)];
    lblPleaseWait  = [[UILabel alloc] initWithFrame:CGRectMake(0, self.center.y-100, self.frame.size.width, 20)];
    lblMessage     = [[UILabel alloc] initWithFrame:CGRectMake(0, self.center.y+15, self.frame.size.width, 16)];
    lblTeamMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-52, self.frame.size.width, 15)];
    //lblMessage.font            = [UIFont fontWithName:@"Arial" size:14];
    lblPleaseWait.font = [UIFont fontWithName:@"SegoePrint-Bold" size:20.0];
    lblMessage.font = [UIFont fontWithName:@"SegoePrint-Bold" size:20.0];
    lblTeamMessage.font = [UIFont fontWithName:@"SegoePrint-Bold" size:20.0];
    
    lock = [[NSLock alloc] init];
    
    
	[lock lock];
	
	//spinner        = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	spinner.frame  = CGRectMake(0.0, 0.0, 40.0, 40.0);
	spinner.center = CGPointMake(self.center.x, self.center.y-30);
	[spinner startAnimating];
	[self addSubview:spinner];
	
	//progressBar                   = [[UIProgressView alloc] initWithFrame:CGRectMake(6.0, 20.0, self.frame.size.width-12, 20)];
    progressBar.frame               = CGRectMake(6.0, 20.0, self.frame.size.width-12, 20);
	progressBar.progressViewStyle = UIProgressViewStyleDefault;
	progressBar.progress          = 0;
	[self addSubview:progressBar];
	
	progressBar.hidden = YES;
	
	
	//UILabel *lblPleaseWait = [[UILabel alloc] initWithFrame:CGRectMake(0, self.center.y-100, self.frame.size.width, 15)];
    lblPleaseWait.frame           = CGRectMake(0, self.center.y-100, self.frame.size.width, 20);
	/*It will make sure the text is always in the centre*/
	lblPleaseWait.textAlignment   = UITextAlignmentCenter;
	lblPleaseWait.backgroundColor = [UIColor clearColor];
	lblPleaseWait.textColor       = [UIColor whiteColor];
    lblPleaseWait.text            = @"";
	lblPleaseWait.text            = altMessage;
    lblPleaseWait.tag             = 1188;
	[self addSubview:lblPleaseWait];
	[lblPleaseWait release];
	
	
	if ([self.message length] > 0)
	{
		//UILabel *lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, self.center.y+15, self.frame.size.width, 16)];
        lblMessage.frame = CGRectMake(0, self.center.y+15, self.frame.size.width, 16);
		/*set the text in the center of the view*/
		//lblMessage.font            = [UIFont fontWithName:@"Arial" size:14];
		lblMessage.textAlignment   = UITextAlignmentCenter;
		lblMessage.backgroundColor = [UIColor clearColor];
		lblMessage.textColor       = [UIColor whiteColor];
		lblMessage.text            = self.message;
        lblMessage.tag             = 1199;
		[self addSubview:lblMessage];
		[lblMessage release];
	}
	
	if (self.altMessage != nil)
	{
		UILabel *lblAdditionalMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-80, self.frame.size.width, 22)];
		lblAdditionalMessage.font            = [UIFont fontWithName:@"Arial" size:16];
		/*set the text in the center of the view*/
		lblAdditionalMessage.textAlignment   = UITextAlignmentCenter;
		lblAdditionalMessage.backgroundColor = [UIColor clearColor];
		lblAdditionalMessage.textColor       = [UIColor whiteColor];
		//lblAdditionalMessage.text            = self.altMessage;
		lblAdditionalMessage.tag			 = 999;
		[self addSubview:lblAdditionalMessage];
		[lblAdditionalMessage release];
	}
	
	
	//| Puts the lblTeamMessage that will shows team data load progress
	//lblTeamMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-52, self.frame.size.width, 15)];
    lblTeamMessage.frame = CGRectMake(0, self.frame.size.height-52, self.frame.size.width, 15);
	lblTeamMessage.textAlignment   = UITextAlignmentCenter;
	lblTeamMessage.backgroundColor = [UIColor clearColor];
	lblTeamMessage.textColor       = [UIColor whiteColor];
	[self addSubview:lblTeamMessage];
	
	
	
	//| Shows Pollack Spinner into main window instead of parent view
	//[[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
    [self.parent addSubview:self];
	
	if (BusyStopCall>0)
	{
		BusyStopCall--;
		[spinner stopAnimating];
		[self removeFromSuperview];
	}
	
    [self willRotateWithOrientation];
    [parent bringSubviewToFront:self];
	[lock unlock];
    
    [pool release];
    
}

-(void)willRotateWithOrientation
{
    
}

- (void) startAnimating {
	[spinner startAnimating];
}


- (void) setTeamMessage:(NSString *)text {
	lblTeamMessage.text = text;
}

- (void)StopSpinner
{
	[lock lock];
    BusyStopCall++;
    
    //NSLog(@"spinner removed");
    [spinner stopAnimating];
    [self removeFromSuperview];
    //[self.progressBar removeFromSuperview];
	[lock unlock];
}

- (void)updateProgress:(NSNumber*)number
{
	progressBar.hidden = NO;
    progressBar.progress = [number floatValue];
}

- (void)dealloc
{	[lblTeamMessage release];
    [spinner release];
    [super dealloc];
}

@end
