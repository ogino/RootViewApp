    //
//  TabBarController.m
//  RootViewApp
//
//  Created by miyabichan on 10/11/25.
//  Copyright 2010 Miyabi Co.,Ltd. All rights reserved.
//

#import "TabBarController.h"


@implementation TabBarController


#pragma mark -
#pragma mark Private Methods

- (NSArray*)createViewControllers {
	WebViewController* webViewController = [[[WebViewController alloc] init] autorelease];
    UINavigationController* webViewNavigation = [[[UINavigationController alloc] initWithRootViewController:webViewController] autorelease];
	webViewNavigation.navigationBar.barStyle = UIBarStyleBlack;

	ImageViewController* imageViewController = [[[ImageViewController alloc] init] autorelease];
	UINavigationController* imageViewNavigation = [[[UINavigationController alloc] initWithRootViewController:imageViewController] autorelease];
	imageViewNavigation.navigationBar.barStyle = UIBarStyleBlack;

	TextViewController* textViewController = [[[TextViewController alloc] init] autorelease];
	UINavigationController* textViewNavigation = [[[UINavigationController alloc] initWithRootViewController:textViewController] autorelease];
	textViewNavigation.navigationBar.barStyle = UIBarStyleBlack;

	LabelViewController* labelViewController = [[[LabelViewController alloc] init] autorelease];
	UINavigationController* labelViewNavigation = [[[UINavigationController alloc] initWithRootViewController:labelViewController] autorelease];
	labelViewNavigation.navigationBar.barStyle = UIBarStyleBlack;

	TableViewController* tableViewController = [[[TableViewController alloc] init] autorelease];
	UINavigationController* tableViewNavigation = [[[UINavigationController alloc] initWithRootViewController:tableViewController] autorelease];
	tableViewNavigation.navigationBar.barStyle = UIBarStyleBlack;

	WrapViewController* wrapViewControllet = [[[WrapViewController alloc] init] autorelease];
	UINavigationController* wrapViewNavigation = [[[UINavigationController alloc] initWithRootViewController:wrapViewControllet] autorelease];
	wrapViewNavigation.navigationBar.barStyle = UIBarStyleBlack;

	NSMutableArray* viewControllers = [NSMutableArray array];
	[viewControllers addObject:tableViewNavigation];
	[viewControllers addObject:labelViewNavigation];
	[viewControllers addObject:textViewNavigation];
	[viewControllers addObject:imageViewNavigation];
	[viewControllers addObject:webViewNavigation];
	[viewControllers addObject:wrapViewNavigation];
	return viewControllers;
}


#pragma mark -
#pragma mark Inherit Methods


- (id) init {
	if (self = [super init]) {
		self.delegate = self;
		self.moreNavigationController.navigationBar.barStyle = UIBarStyleBlack;
		self.viewControllers = [self createViewControllers];
	}
	return self;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//	return [super tabBarController:tabBarController shouldSelectViewController:viewController];
	return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//	[super tabBarController:tabBarController didSelectViewController:viewController];
}

- (void)tabBarController:(UITabBarController*)tabBarController willBeginCustomizingViewControllers:(NSArray*)viewControllers {
	UIView* subviews = [tabBarController.view.subviews objectAtIndex:1];
	UINavigationBar* navigationBar = [[subviews subviews] objectAtIndex:0];
	navigationBar.barStyle = UIBarStyleBlack;
}

- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
//	[super tabBarController:tabBarController willEndCustomizingViewControllers:viewControllers changed:changed];
}
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
//	[super tabBarController:tabBarController didEndCustomizingViewControllers:viewControllers changed:changed];
}


- (void)dealloc {
    [super dealloc];
}


@end
