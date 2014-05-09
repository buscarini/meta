//
//  BMFWebViewController.h
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import "BMFViewController.h"

#import "BMFDetailViewControllerProtocol.h"
#import "BMFLoaderViewProtocol.h"

#import "BMFWebViewDelegate.h"

@interface BMFWebViewController : BMFViewController <BMFDetailViewControllerProtocol>

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@property (nonatomic, strong) id<BMFWebViewDelegate> webDelegate;

@property (nonatomic, strong) id detailItem;

/// Extra space when it's presented in a popover. By default 20x20
@property (nonatomic, assign) CGSize contentSizeMargin;

@end
