//
//  WebViewController.m
//  RootViewApp
//
//  Created by Tadashi Ogino on 10/09/16.
//  Copyright 2010 Tadashi Ogino Co.,Ltd. All rights reserved.
//

#import "WebViewController.h"


@implementation WebViewController

@synthesize webView = webView_;

- (void)showIndicator:(NSNumber*)number {
	BOOL enable = [number boolValue];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = enable;
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

- (id)init {
	if ((self = [super initWithNibName:nil bundle:nil])) {
        self.title = @"WebView";
		self.tabBarItem.image = [UIImage imageNamed:@"web"];
	}
    return self;
}


#pragma mark -
#pragma mark View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	CGRect rectFrame = [UIScreen mainScreen].applicationFrame;
	self.view = [[[UIView alloc] initWithFrame:rectFrame] autorelease];
	self.view.backgroundColor = [UIColor grayColor];
	self.view.autoresizesSubviews = YES;
	self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.view.clipsToBounds = YES;

	self.webView = [[[UIWebView alloc] initWithFrame:self.view.bounds] autorelease];
	self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.webView.clipsToBounds = YES;
	self.webView.scalesPageToFit = YES;
	self.webView.backgroundColor = [UIColor yellowColor];
	self.webView.delegate = self;

	[self.view addSubview:self.webView];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self performSelectorInBackground:@selector(showIndicator:) withObject:[NSNumber numberWithBool:YES]];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ipn.yahoo.co.jp"]]];
	[self performSelectorInBackground:@selector(showIndicator:) withObject:[NSNumber numberWithBool:NO]];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}


- (void)webViewDidStartLoad:(UIWebView *) view {
	[self performSelectorInBackground:@selector(showIndicator:) withObject:[NSNumber numberWithBool:YES]];
}

- (void) webViewDidFinishLoad:(UIWebView *) view {
	[self performSelectorInBackground:@selector(showIndicator:) withObject:[NSNumber numberWithBool:NO]];
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
	self.webView = nil;

    [super dealloc];
}


@end
