//
//  RootViewController.m
//  RootViewApp
//
//  Created by miyabichan on 10/09/16.
//  Copyright 2010 Miyabi Co.,Ltd. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController

@synthesize loginView = loginView_;
@synthesize button = button_;
@synthesize modalView = modalView_;
@synthesize tabBarController = tabBarController_;
@synthesize logined = logined_;

- (void) showIndicator:(NSNumber*) number {
	NSAutoreleasePool* pool =[[NSAutoreleasePool alloc] init];
	BOOL enable = [number boolValue];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = enable;
	[pool release];
}

- (void) createLoginView {
	self.loginView = [[[UIView alloc] initWithFrame:self.view.bounds] autorelease];
	self.loginView.backgroundColor = [[UIColor magentaColor] colorWithAlphaComponent:0.5];
	self.loginView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

	self.button = [UIButton buttonWithType:UIButtonTypeInfoLight];
	self.button.frame = CGRectMake(0, 0, 100, 100);
	self.button.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.button.contentMode = UIViewContentModeCenter;
	self.button.center = self.loginView.center;
	[self.button addTarget:self action:@selector(prepareLogin) forControlEvents:UIControlEventTouchUpInside];

	[self.loginView addSubview:self.button];
}

- (void) createViews {
	CGRect rectFrame = [UIScreen mainScreen].applicationFrame;
	self.view = [[[UIView alloc] initWithFrame:rectFrame] autorelease];
	self.view.backgroundColor = [UIColor whiteColor];
	self.view.autoresizesSubviews = YES;
	self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.view.clipsToBounds = YES;

	[self createLoginView];

	self.modalView = [[[UIView alloc] initWithFrame:self.view.bounds] autorelease];
	self.modalView.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.5];
	self.modalView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.modalView.autoresizesSubviews = YES;

	UIActivityIndicatorView* indicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	[self.modalView addSubview:indicator];
	indicator.frame = self.modalView.bounds;
	indicator.contentMode = UIViewContentModeCenter;
	indicator.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	[indicator startAnimating];
}

- (void) createTabBarController {
	self.tabBarController = [[[TabBarController alloc] init] autorelease];
}

- (void)beginIndicate {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	[self performSelectorInBackground:@selector(showIndicator:) withObject:[NSNumber numberWithBool:YES]];
	[self.modalView setHidden:NO];
	[pool release];
}

- (void) prepareLogin {
	[self performSelectorInBackground:@selector(beginIndicate) withObject:nil];
	self.logined = YES;
	[self viewWillAppear:YES];
	[self viewDidAppear:YES];
}

- (void) proceedLogin {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	[NSThread sleepForTimeInterval:5u];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ROOT VIEW" object:nil];
	[pool release];
}

- (void)changeViewController {
	UIWindow* window = [(AppDelegate*)[[UIApplication sharedApplication] delegate] window];
	[window addSubview:self.tabBarController.view];
	[window bringSubviewToFront:self.tabBarController.view];
	[window makeKeyAndVisible];
}

- (void)prepareDone:(NSNotification*) notification {
	[self.modalView setHidden:YES];
	[self showIndicator:[NSNumber numberWithBool:NO]];
	[self changeViewController];
}


#pragma mark -
#pragma mark Initialization

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}

- (id) init {
	if ((self = [super initWithNibName:nil bundle:nil])) {
		self.title = @"RootView";
	}
    return self;
}


#pragma mark -
#pragma mark View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[self createViews];
	[self createLoginView];
	[self createTabBarController];

	if (self.logined) {
		[self.loginView setHidden:YES];
		[self.view addSubview:self.modalView];
	} else {
		[self.view addSubview:self.loginView];
		[self.loginView addSubview:self.modalView];
	}

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prepareDone:) name:@"ROOT VIEW" object:nil];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	if (self.logined) {
		[self.modalView setHidden:NO];
		[self performSelectorInBackground:@selector(showIndicator:) withObject:[NSNumber numberWithBool:YES]];
	} else {
		[self.modalView setHidden:YES];
		[self performSelectorInBackground:@selector(showIndicator:) withObject:[NSNumber numberWithBool:NO]];
	}
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	if (self.logined)
		[self performSelectorInBackground:@selector(proceedLogin) withObject:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	self.loginView = nil;
	self.button = nil;
	self.modalView = nil;
	self.tabBarController = nil;

	[super dealloc];
}


@end
