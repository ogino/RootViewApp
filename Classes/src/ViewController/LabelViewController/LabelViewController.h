//
//  LabelViewController.h
//  RootViewApp
//
//  Created by Tadashi Ogino on 10/09/16.
//  Copyright 2010 Tadashi Ogino Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LabelViewController : UIViewController {
@private
	UILabel* label_;
	UIView* modalView_;
	NSString* text_;
}

@property (nonatomic, retain) UILabel* label;
@property (nonatomic, retain) UIView* modalView;
@property (nonatomic, copy) NSString* text;

@end
