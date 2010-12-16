//
//  ImageViewController.m
//  RootViewApp
//
//  Created by Tadashi Ogino on 10/09/16.
//  Copyright 2010 Tadashi Ogino Co.,Ltd. All rights reserved.
//

#import "ImageViewController.h"


@implementation ImageViewController

@synthesize scrollView = scrollView_;
@synthesize imageView = imageView_;
@synthesize modalView = modalView_;
@synthesize image = image_;

- (void)showIndicator:(NSNumber*)number {
	BOOL enable = [number boolValue];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = enable;
}

- (void)createImage {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	self.image = [UIImage imageNamed:@"sun"];
	[NSThread sleepForTimeInterval:5u];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"IMAGE LOAD" object:nil];
	[pool release];
}

- (void)drawImageView {
	self.imageView.image = self.image;
	self.imageView.contentMode = UIViewContentModeCenter;
}

- (void)fetchedImage:(NSNotification*) notification {
	[self performSelectorOnMainThread:@selector(drawImageView) withObject:nil waitUntilDone:YES];
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

- (id) init {
	if ((self = [super initWithNibName:nil bundle:nil])) {
        self.title = @"ImageView";
		self.tabBarItem.image = [UIImage imageNamed:@"image"];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchedImage:) name:@"IMAGE LOAD" object:nil];
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

	self.scrollView = [[[UIScrollView alloc] initWithFrame:self.view.bounds] autorelease];
    self.scrollView.delegate = self;
	self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.scrollView.contentMode = UIViewContentModeCenter;
	[self.view addSubview:self.scrollView];

	self.imageView = [[[UIImageView alloc] initWithFrame:self.scrollView.bounds] autorelease];
	self.imageView.backgroundColor = [UIColor brownColor];
	self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	[self.scrollView addSubview:self.imageView];

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
	[self performSelectorInBackground:@selector(createImage) withObject:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	self.imageView.image = nil;
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
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"IMAGE LOAD" object:nil];
	self.scrollView = nil;
	self.imageView = nil;
	self.modalView = nil;
	self.image = nil;

    [super dealloc];
}


@end
