//
//  TableViewController.m
//  RootViewApp
//
//  Created by miyabichan on 10/09/17.
//  Copyright 2010 Miyabi Co.,Ltd. All rights reserved.
//

#import "TableViewController.h"


@implementation TableViewController

@synthesize modalView = modalView_;
@synthesize cell = cell_;
@synthesize sections = sections_;

- (void) showIndicator:(NSNumber*) number {
	BOOL enable = [number boolValue];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = enable;
}

- (void) createSections {
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	NSMutableDictionary* sections = [NSMutableDictionary dictionary];
	for (NSUInteger i = 0; i < 10; i++) {
		NSMutableArray* labels = [NSMutableArray array];
		for (NSUInteger j = 0; j < 10; j++) {
			[labels addObject:[NSString stringWithFormat:@"Value is %d", rand() % 10]];
		}
		[sections setObject:labels forKey:[NSString stringWithFormat:@"%d", i]];
	}
	self.sections = sections;
	[NSThread sleepForTimeInterval:5u];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"TABLE LOAD" object:nil];
	[pool release];
}


- (void)fetchedSections:(NSNotification*) notification {
	[self.modalView setHidden:YES];
	[self showIndicator:[NSNumber numberWithBool:NO]];
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}


- (id) init {
	if ((self = [super initWithStyle:UITableViewStylePlain])) {
        self.title = @"TableView";
		self.tabBarItem.image = [UIImage imageNamed:@"table"];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchedSections:) name:@"TABLE LOAD" object:nil];
	}
    return self;
}


#pragma mark -
#pragma mark View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {

	self.sections = [NSDictionary dictionary];

	CGRect rectFrame = [UIScreen mainScreen].applicationFrame;
	self.view = [[[UIView alloc] initWithFrame:rectFrame] autorelease];
	self.view.backgroundColor = [UIColor grayColor];
	self.view.autoresizesSubviews = YES;
	self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.view.clipsToBounds = YES;

	self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds] autorelease];
	self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

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

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.sections = [NSDictionary dictionary];
	[self.modalView setHidden:NO];
	[self performSelectorInBackground:@selector(showIndicator:) withObject:[NSNumber numberWithBool:YES]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	[self.tableView reloadData];
	[self performSelectorInBackground:@selector(createSections) withObject:nil];
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
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [[self.sections allKeys] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [NSString stringWithFormat:@"No.%d", section];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	NSArray* lables = [self.sections objectForKey:[NSString stringWithFormat:@"%d", section]];
    return [lables count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell...
	cell.imageView.image = [UIImage imageNamed:@"cell"];
	NSArray* lables = [self.sections objectForKey:[NSString stringWithFormat:@"%d", indexPath.section]];
	cell.textLabel.text = [lables objectAtIndex:indexPath.row];
	cell.textLabel.textColor = [UIColor blueColor];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"Cool! %@", [lables objectAtIndex:indexPath.row]];
	cell.detailTextLabel.textColor = [UIColor redColor];

	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	self.modalView = nil;
	self.cell = nil;
	self.sections = nil;

    [super dealloc];
}


@end

