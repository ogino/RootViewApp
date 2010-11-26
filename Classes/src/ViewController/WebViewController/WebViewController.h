//
//  WebViewController.h
//  RootViewApp
//
//  Created by miyabichan on 10/09/16.
//  Copyright 2010 Miyabi Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController<UIWebViewDelegate> {
@private
	UIWebView* webView_;
}

@property (nonatomic, retain) UIWebView* webView;


@end
