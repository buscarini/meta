//
//  TNViewController.h
//  DataSources
//
//  Created by José Manuel Sánchez on 28/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMFLoaderViewProtocol.h"

#import "BMFViewControllerBehaviorProtocol.h"
#import "BMFArrayProxy.h"

enum BMFViewControllerNavigationDirection {
	BMFViewControllerNavigationDirectionForward = 1,
	BMFViewControllerNavigationDirectionBackward = 2
};

@interface BMFViewController : UIViewController

/// Reference for when it's used inside a popoverViewController
@property (nonatomic, weak) UIPopoverController *BMF_popoverController;

@property (copy, nonatomic) BMFActionBlock didLoadBlock;
@property (copy, nonatomic) BMFActionBlock didAppearBlock;
@property (nonatomic, strong) IBOutlet id<BMFLoaderViewProtocol> loaderView;


@property (nonatomic, readonly) BOOL isVisible;

/// List of id<BMFViewControllerBehaviorProtocol> behaviours
//@property (nonatomic, readonly) NSArray *behaviors;

/// This proxy should be the delegate of all the views
//@property (nonatomic, readonly) BMFArrayProxy *proxy;

- (void) addBehavior: (id<BMFViewControllerBehaviorProtocol>) behavior;
- (void) removeBehavior: (id<BMFViewControllerBehaviorProtocol>) behavior;

/// Allows to know the navigation direction when appearing.
@property (nonatomic, assign) enum BMFViewControllerNavigationDirection navigationDirection;

/// Teplate method
- (void) performInit __attribute((objc_requires_super));

@end
