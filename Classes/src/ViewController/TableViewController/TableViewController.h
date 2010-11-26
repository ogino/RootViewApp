//
//  TableViewController.h
//  RootViewApp
//
//  Created by miyabichan on 10/09/17.
//  Copyright 2010 Miyabi Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TableViewController : UITableViewController {
@private
	UIView* modalView_;
	UITableViewCell* cell_;
	NSDictionary* sections_;
}

@property (nonatomic, retain) UIView* modalView;
@property (nonatomic, retain) UITableViewCell* cell;
@property (nonatomic, retain) NSDictionary* sections;

@end
