//
//  BMFKeyboardAdjustContentInsetBehavior.m
//  Pods
//
//  Created by Jose Manuel Sánchez Peñarroja on 23/04/14.
//
//

#import "BMFKeyboardAdjustContentInsetBehavior.h"

#import "BMF.h"
#import "BMFKeyboardManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@implementation BMFKeyboardAdjustContentInsetBehavior {
	RACDisposable *subscriber;
}

- (void) viewWillAppear:(BOOL)animated {
	BMFKeyboardManager *keyboardManager = [BMFBase sharedInstance].keyboardManager;
	@weakify(self);
	subscriber = [RACObserve(keyboardManager, keyboardHeight) subscribeNext:^(NSNumber *height) {
		@strongify(self);
		
		CGRect windowRect = [self.scrollView.window convertRect:self.scrollView.frame fromView:self.scrollView.superview];
		
		CGFloat inset = 0;
		
		CGFloat windowHeight = self.scrollView.window.frame.size.height;
		CGFloat textViewMaxY = CGRectGetMaxY(windowRect);
		inset = textViewMaxY-(windowHeight-height.floatValue);
		
		self.scrollView.contentInset = UIEdgeInsetsMake(self.scrollView.contentInset.top, self.scrollView.contentInset.left, inset, self.scrollView.contentInset.right);
		self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset;
	}];
}

- (void) viewWillDisappear:(BOOL)animated {
	[subscriber dispose], subscriber = nil;
}

@end
