//
//  BMFScrollHidesNavigationBarBehavior.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 18/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFScrollHidesNavigationBarBehavior.h"

#import "BMF.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface BMFScrollHidesNavigationBarBehavior()

@property (nonatomic, assign) CGRect defaultFrame;
@property (nonatomic, strong) UIFont *defaultTitleFont;
@property (nonatomic, strong) UIColor *defaultTitleColor;
@property (nonatomic, assign) BOOL isActive;

@end

@implementation BMFScrollHidesNavigationBarBehavior {
	RACDisposable *didBecomeActiveSubscription;
}

- (instancetype) initWithView:(UIScrollView *)scrollView {
    self = [super initWithView:scrollView];
    if (self) {
		self.minimumBarHeight = 20;
	}
    return self;
}


- (void) viewDidAppear:(BOOL)animated {
	self.defaultFrame = self.object.navigationController.navigationBar.frame;

	UIColor *titleColor = self.object.navigationController.navigationBar.titleTextAttributes[NSForegroundColorAttributeName];
	if (!titleColor) titleColor = [UIColor blackColor];
	self.defaultTitleColor = titleColor;
	
	self.defaultTitleFont = self.object.navigationController.navigationBar.titleTextAttributes[NSFontAttributeName];
	if (!self.defaultTitleFont) self.defaultTitleFont = [UIFont boldSystemFontOfSize:16];
	
	self.isActive = YES;
	
	@weakify(self);
	[[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidBecomeActiveNotification object:nil] takeUntilBlock:^BOOL(id x) {
		@strongify(self);
		return self.isActive;
	}] subscribeNext:^(id x) {
		@strongify(self);
		[self resetToDefaultPosition:NO];
	}];
}

- (void) viewWillDisappear:(BOOL)animated {
	[self resetToDefaultPosition:NO];
}

- (void) viewDidDisappear:(BOOL)animated {
	self.isActive = NO;
}

- (void) dealloc {
	self.isActive = NO;
}

/*- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {

//	[self resetToDefaultPosition:NO];
}*/

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[self resetToDefaultPosition:NO];
}

#pragma mark UIScrollViewDelegate

//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
//	[self.scrollView setContentOffset:CGPointZero animated:YES];
//	
//	return NO;
//}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
	if (!self.isActive) return;
	
#warning TODO Improve this (Flickering while the navigation bar grows)
	
//	CGFloat posY = scrollView.contentInset.top-scrollView.contentOffset.y;
	CGFloat posY = scrollView.contentOffset.y;
	
	CGFloat navBarHeight = self.defaultFrame.size.height;
	
	if (posY+scrollView.contentInset.top>0) {
		
		//	posY += scrollView.contentInset.top;
		posY += CGRectGetMaxY(self.defaultFrame);
		
		/*if (self.scrollView.frame.size.height + (self.viewController.navigationController.navigationBar.bounds.size.height * 2) >= self.scrollView.contentSize.height) {
		 return;
		 }*/
		

		
		navBarHeight = [self navigationBarHeightForOffset:posY];
	}

	
	[self setBarHeight:navBarHeight animated:YES];
}

- (CGFloat) navigationBarHeightForOffset:(CGFloat) offsetY {
//	
//	CGFloat maxY = CGRectGetMaxY(self.defaultFrame);
//	
//	CGFloat result = offsetY-maxY;
//	if (result>=maxY) return self.defaultFrame.size.height;
//	if (result<self.minimumBarHeight+self.defaultFrame.origin.y) return self.minimumBarHeight;
//	
//	return (result-self.defaultFrame.origin.y);
		
//	if (result>self.minimumBarHeight+self.defaultFrame.origin.y) result = self.minimumBarHeight;
	
	CGFloat result = self.defaultFrame.size.height-offsetY;

	if (result<self.minimumBarHeight) result = self.minimumBarHeight;
	if (result>=self.defaultFrame.size.height) result = self.defaultFrame.size.height;
//	if (result>=CGRectGetMaxY(self.viewController.navigationController.navigationBar.frame)) result = self.defaultFrame.size.height;
	return result;
}

- (void) resetToDefaultPosition: (BOOL) animated {
	
	if (UIInterfaceOrientationIsLandscape(self.object.interfaceOrientation)) {
		_defaultFrame.size.width = self.object.view.window.frame.size.height;
	}
	else {
		_defaultFrame.size.width = self.object.view.window.frame.size.width;
	}

	
	void(^block)() = ^() {
		self.object.navigationController.navigationBar.frame = self.defaultFrame;
	};
	
	if (animated) [UIView animateWithDuration:0.5 animations:block];
	else block();
}

- (void) setBarHeight:(CGFloat) height animated:(BOOL) animated {
	if (!self.isActive) return;
	
//	DDLogInfo(@"Setting bar height: %f",height);
	
	CGRect frame = self.defaultFrame;
	frame.size.height = height;
	
	UIEdgeInsets contentInset = self.scrollView.contentInset;
	contentInset.top = CGRectGetMaxY(frame);
	self.scrollView.contentInset = contentInset;
	self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset;
	
	void(^block)() = ^() {
		self.object.navigationController.navigationBar.frame = frame;
		
		CGFloat fontSize = [self fontSizeForHeight:height];
		if (fontSize>0) {
			UIFont *font = [self.defaultTitleFont fontWithSize:fontSize];
			[self.object.navigationController.navigationBar setTitleTextAttributes:@{ NSFontAttributeName : font, NSForegroundColorAttributeName : self.defaultTitleColor }];
		}
		else {
			[self.object.navigationController.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor clearColor] }];
		}
		
	};
	
	if (animated) [UIView animateWithDuration:0.1 animations:block];
	else block();
}



- (CGFloat) fontSizeForHeight:(CGFloat) height {
	CGFloat result = self.defaultTitleFont.pointSize*height/self.defaultFrame.size.height;
	
//	height-(self.defaultFrame.size.height-self.defaultTitleFont.pointSize);
//	DDLogInfo(@"font size: %f",result);
	if (result>self.defaultTitleFont.pointSize) result = self.defaultTitleFont.pointSize;
	if (result<8) result = 0;
	return result;
}

@end
