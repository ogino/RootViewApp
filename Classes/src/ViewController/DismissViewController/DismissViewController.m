//
//  DismissViewController.m
//  RootViewApp
//
//  Created by Tadashi Ogino on 10/12/16.
//  Copyright 2010 Tadashi Ogino Co.,Ltd. All rights reserved.
//

#import "DismissViewController.h"
#import "AppDelegate.h"


@implementation DismissViewController

@synthesize logoutView = logoutView_;
@synthesize button = button_;


- (void) resetTabViewController {
	[self.parentViewController.tabBarController setSelectedIndex:0u];
	[self.view removeFromSuperview];
	[self.parentViewController.view removeFromSuperview];
	[self.parentViewController.tabBarController.view removeFromSuperview];
}

- (void)logout {
	[self resetTabViewController];
	AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
	[delegate.window addSubview:delegate.rootViewController.view];
}

#pragma mark -
#pragma mark Initialization

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}

- (id)init {
	if ((self = [super initWithNibName:nil bundle:nil])) {
        self.title = @"DissmissView";
		self.tabBarItem.image = [UIImage imageNamed:@"dissmiss"];
	}
    return self;
}


#pragma mark -
#pragma mark View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	CGRect rectFrame = [UIScreen mainScreen].applicationFrame;
	self.view = [[[UIView alloc] initWithFrame:rectFrame] autorelease];
	self.view.backgroundColor = [UIColor whiteColor];
	self.view.autoresizesSubviews = YES;
	self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.view.clipsToBounds = YES;

	self.logoutView = [[[UIView alloc] initWithFrame:self.view.bounds] autorelease];
	self.logoutView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
	self.logoutView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	[self.view addSubview:self.logoutView];

	self.button = [UIButton buttonWithType:UIButtonTypeInfoDark];
	self.button.frame = CGRectMake(0, 0, 200, 200);
	self.button.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.button.contentMode = UIViewContentModeCenter;
	self.button.center = self.logoutView.center;
	[self.button addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
	[self.logoutView addSubview:self.button];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc. that aren't in use.
}

- (void)dealloc {
	self.logoutView = nil;
	self.button = nil;
    [super dealloc];
}


@end
