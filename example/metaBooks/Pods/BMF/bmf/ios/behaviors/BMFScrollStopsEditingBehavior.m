//
//  BMFScrollStopsEditingBehavior.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 10/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFScrollStopsEditingBehavior.h"

#import "BMFKeyboardManager.h"

#import "BMF.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface BMFScrollStopsEditingBehavior()

@property (nonatomic, assign) CGPoint offset;
@property (nonatomic, assign) CGFloat inc;

@end

@implementation BMFScrollStopsEditingBehavior

- (instancetype) initWithView:(UIScrollView *)scrollView {
	
    self = [super initWithView:scrollView];
    if (self) {
		self.offsetToStopEditing = 60;
		self.forceStopEditing = YES;
		
		@weakify(self);
		RAC(self,offset) =	[RACObserve([BMFBase sharedInstance].keyboardManager, keyboardVisible) map:^id(NSNumber *visible) {
			@strongify(self);
			return [NSValue valueWithCGPoint:self.scrollView.contentOffset];
		}];
	}
    return self;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	self.offset = self.scrollView.contentOffset;
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	self.offset = self.scrollView.contentOffset;
}

#pragma mark UIScrollViewDelegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
	self.inc = fabsf(scrollView.contentOffset.y-self.offset.y);
	if (self.inc>self.offsetToStopEditing) {
		[self.object.view endEditing:self.forceStopEditing];
	}
}

@end
