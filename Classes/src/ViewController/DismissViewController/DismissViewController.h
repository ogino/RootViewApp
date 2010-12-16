//
//  DismissViewController.h
//  RootViewApp
//
//  Created by Tadashi Ogino on 10/12/16.
//  Copyright 2010 Tadashi Ogino Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DismissViewController : UIViewController {
@private
	UIView* logoutView_;
	UIButton* button_;
}

@property (nonatomic, retain) UIView* logoutView;
@property (nonatomic, retain) UIButton* button;

@end
