//
//  LabelViewController.m
//  RootViewApp
//
//  Created by Tadashi Ogino on 10/09/16.
//  Copyright 2010 Tadashi Ogino Co.,Ltd. All rights reserved.
//

#import "LabelViewController.h"


@implementation LabelViewController


@synthesize label = label_;
@synthesize modalView = modalView_;
@synthesize text = text_;

- (void)showIndicator:(NSNumber*)number {
	BOOL enable = [number boolValue];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = enable;
}

- (void)createText {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.new-akiba.com/"]];
	NSHTTPURLResponse* response = nil;
	NSError* error = nil;
	NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

	if (!data) @throw [NSError errorWithDomain:@"AAAAA" code:9999 userInfo:nil];
	self.text = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"LABEL LOAD" object:nil];
	[pool release];
}

- (void)drawLabelView {
	self.label.text = self.text;
}

- (void)fetchedText:(NSNotification*)notification {
	[self performSelectorOnMainThread:@selector(drawLabelView) withObject:nil waitUntilDone:YES];
	[self.modalView setHidden:YES];
	[self showIndicator:[NSNumber numberWithBool:NO]];
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
        self.title = @"LabelView";
		self.tabBarItem.image = [UIImage imageNamed:@"label"];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchedText:) name:@"LABEL LOAD" object:nil];
	}
    return self;
}


#pragma mark -
#pragma mark View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	CGRect rectFrame = [UIScreen mainScreen].applicationFrame;
	self.view = [[[UIView alloc] initWithFrame:rectFrame] autorelease];
	self.view.backgroundColor = [UIColor yellowColor];
	self.view.autoresizesSubviews = YES;
	self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.view.clipsToBounds = YES;

	self.label = [[[UILabel alloc] initWithFrame:self.view.bounds] autorelease];
	self.label.backgroundColor = [UIColor greenColor];
	self.label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	[self.view addSubview:self.label];

	self.modalView = [[[UIView alloc] initWithFrame:self.view.bounds] autorelease];
	self.modalView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
	self.modalView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.modalView.autoresizesSubviews = YES;
	[self.view addSubview:self.modalView];

	UIActivityIndicatorView* indicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	[self.modalView addSubview:indicator];
	indicator.frame = self.modalView.bounds;
	indicator.contentMode = UIViewContentModeCenter;
	indicator.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	[indicator startAnimating];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.modalView setHidden:NO];
	[self performSelectorInBackground:@selector(showIndicator:) withObject:[NSNumber numberWithBool:YES]];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self performSelectorInBackground:@selector(createText) withObject:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	self.label.text = @"";
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
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
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"LABEL LOAD" object:nil];
	self.label = nil;
	self.modalView = nil;

    [super dealloc];
}


@end
