//
//  AppDelegate.h
//  RootViewApp
//
//  Created by Tadashi Ogino on 10/09/16.
//  Copyright 2010 Tadashi Ogino Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "WebViewController.h"
#import "ImageViewController.h"
#import "TextViewController.h"
#import "LabelViewController.h"
#import "TableViewController.h"

@interface AppDelegate : NSObject <UIApplicationDelegate> {
@private
    UIWindow* window_;
	RootViewController* rootViewController_;
}

@property (nonatomic, retain) IBOutlet UIWindow* window;
@property (nonatomic, retain) RootViewController* rootViewController;

@end

