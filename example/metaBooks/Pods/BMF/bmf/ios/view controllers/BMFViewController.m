//
//  TNViewController.m
//  DataSources
//
//  Created by José Manuel Sánchez on 28/10/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFViewController.h"

@interface BMFViewController ()
	@property (nonatomic, assign) BOOL isVisible;
@end

@implementation BMFViewController

- (id)init
{
    self = [super init];
    if (self) {
        [self performInit];
    }
    return self;
}

- (id)initWithParameters:(NSDictionary*) parameters nibName:(NSString *)nibNameOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nil];
	if (self) {
		[self performInit];
	}
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		[self performInit];
	}
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self performInit];
    }
    return self;
}

/// Teplate method
- (void) performInit {
	self.navigationDirection = BMFViewControllerNavigationDirectionForward;

	self.BMF_proxy = [BMFArrayProxy new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	DDLogInfo(@"view controller did receive memory warning");
	
	if ([self.BMF_proxy respondsToSelector:@selector(didReceiveMemoryWarning)]) [self.BMF_proxy didReceiveMemoryWarning];
}

#pragma mark Accessors

- (void) setLoaderView:(id<BMFLoaderViewProtocol>)loaderView {
	UIView *view = [UIView BMF_cast:loaderView];

	[view removeFromSuperview];
	
	_loaderView = loaderView;
	view.translatesAutoresizingMaskIntoConstraints = NO;
	
	if ([self isViewLoaded])  {
		[self addLoaderView];
	}
}

- (void) addLoaderView {
	if (!_loaderView) return;
	
	if ([_loaderView conformsToProtocol:@protocol(BMFLoaderViewProtocol) ]) [_loaderView addToViewController:self];
}

- (NSArray *) behaviors {
	return [NSArray arrayWithArray:self.BMF_proxy.destinationObjects];
}

- (void) addBehavior: (id<BMFViewControllerBehaviorProtocol>) behavior {

	[self BMF_addAspect:behavior];
	
	if (self.isViewLoaded) {
		if ([behavior respondsToSelector:@selector(viewDidLoad)]) {
			[behavior viewDidLoad];
		}
	}
}

- (void) removeBehavior: (id<BMFViewControllerBehaviorProtocol>) behavior {
	[self BMF_removeAspect:behavior];
}

#pragma mark View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	if (self.didLoadBlock) self.didLoadBlock(self);
	UIView *view = [UIView BMF_cast:self.loaderView];
	if (!view.superview) [self addLoaderView];
	
	if ([self.BMF_proxy respondsToSelector:@selector(viewDidLoad)]) [self.BMF_proxy viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.isVisible = YES;
	
	UIView *view = [UIView BMF_cast:self.loaderView];
	if (view) [view.superview bringSubviewToFront:view];
	
	if ([self.BMF_proxy respondsToSelector:@selector(viewWillAppear:)]) [self.BMF_proxy viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	if (self.didAppearBlock) self.didAppearBlock(self);
	
	if ([self.BMF_proxy respondsToSelector:@selector(viewDidAppear:)]) [self.BMF_proxy viewDidAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	self.isVisible = NO;
	
	if ([self isMovingToParentViewController] || [self isBeingDismissed]) {
		self.navigationDirection = BMFViewControllerNavigationDirectionForward;
	}
	else {
		self.navigationDirection = BMFViewControllerNavigationDirectionBackward;
	}
	
	if ([self.BMF_proxy respondsToSelector:@selector(viewWillDisappear:)]) [self.BMF_proxy viewWillDisappear:animated];
}




#pragma mark View events
	
- (void) viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
		
	if ([self.BMF_proxy respondsToSelector:@selector(viewWillLayoutSubviews)]) [self.BMF_proxy viewWillLayoutSubviews];
}
	
- (void) viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	
	if ([self.BMF_proxy respondsToSelector:@selector(viewDidLayoutSubviews)]) [self.BMF_proxy viewDidLayoutSubviews];
}
	

#pragma mark View rotation
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	if ([self.BMF_proxy respondsToSelector:@selector(willRotateToInterfaceOrientation:duration:)]) [self.BMF_proxy willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}
	
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
	[super willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
	
	if ([self.BMF_proxy respondsToSelector:@selector(willAnimateRotationToInterfaceOrientation:duration:)]) [self.BMF_proxy willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
}
	
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];

	if ([self.BMF_proxy respondsToSelector:@selector(didRotateFromInterfaceOrientation:)]) [self.BMF_proxy didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}
	

#pragma mark Containment events
- (void)willMoveToParentViewController:(UIViewController *)parent {
	[super willMoveToParentViewController:parent];

	if ([self.BMF_proxy respondsToSelector:@selector(willMoveToParentViewController:)]) [self.BMF_proxy willMoveToParentViewController:parent];
}
	
- (void)didMoveToParentViewController:(UIViewController *)parent {
	[super didMoveToParentViewController:parent];

	if ([self.BMF_proxy respondsToSelector:@selector(didMoveToParentViewController:)]) [self.BMF_proxy didMoveToParentViewController:parent];
}
	

#pragma mark Edit mode
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];

	if ([self.BMF_proxy respondsToSelector:@selector(setEditing:animated:)]) [self.BMF_proxy setEditing:editing animated:animated];
}
	

#pragma mark Restoration
- (void)applicationFinishedRestoringState {
	[super applicationFinishedRestoringState];

	if ([self.BMF_proxy respondsToSelector:@selector(applicationFinishedRestoringState)]) [self.BMF_proxy applicationFinishedRestoringState];
}
	


#pragma mark Child view controllers
- (void)addChildViewController:(UIViewController *)childController {
	[super addChildViewController:childController];

	if ([self.BMF_proxy respondsToSelector:@selector(addChildViewController:)]) [self.BMF_proxy addChildViewController:childController];
}
	
- (void)removeFromParentViewController {
	[super removeFromParentViewController];

	if ([self.BMF_proxy respondsToSelector:@selector(removeFromParentViewController)]) [self.BMF_proxy removeFromParentViewController];
}
	
- (void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion {
	[super transitionFromViewController:fromViewController toViewController:toViewController duration:duration
										options:options animations:animations completion:completion];

	if ([self.BMF_proxy respondsToSelector:@selector(transitionFromViewController:toViewController:duration:options:animations:completion:)]) [self.BMF_proxy transitionFromViewController:fromViewController toViewController:toViewController duration:duration options:options animations:animations completion:completion];
}

- (void)beginAppearanceTransition:(BOOL)isAppearing animated:(BOOL)animated {
	[super beginAppearanceTransition:isAppearing animated:animated];

	if ([self.BMF_proxy respondsToSelector:@selector(beginAppearanceTransition:animated:)]) [self.BMF_proxy beginAppearanceTransition:isAppearing animated:animated];
}
	
- (void)endAppearanceTransition {
	[super endAppearanceTransition];

	if ([self.BMF_proxy respondsToSelector:@selector(endAppearanceTransition)]) [self.BMF_proxy endAppearanceTransition];
}

@end
