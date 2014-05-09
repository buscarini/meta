//
//  TRNSimpleLoaderView.m
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 13/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import "BMFSimpleLoaderView.h"

#import "BMFAutoLayoutUtils.h"
#import "BMFCrossView.h"
#import <ReactiveCocoa/RACEXTScope.h>

#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation BMFSimpleLoaderView

- (void) performInit {
	[super performInit];
	
	self.loaderView = [[UIActivityIndicatorView alloc] init];
	self.loaderView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
	self.loaderView.color = [UIColor blackColor];
	self.loaderView.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self addSubview:self.loaderView];
	[BMFAutoLayoutUtils fill:self.loaderView parent:self margin:0];
	
	self.crossHideDelay = 2.0;
	self.translatesAutoresizingMaskIntoConstraints = NO;
	
	self.progress = [BMFProgress new];
	
	@weakify(self);
	[RACObserve(self, progress.running) subscribeNext:^(NSNumber *loading) {
		DDLogInfo(@"simple loader view running: %@",loading);
		@strongify(self);
		if (loading.boolValue) {
			[self.loaderView startAnimating];
			self.hidden = NO;
		}
		else {
			[self.loaderView stopAnimating];
			self.hidden = YES;
		}
	}];
	

	[RACObserve(self, progress.fractionCompleted) subscribeNext:^(NSNumber *completed) {
		@strongify(self);
		if (completed.floatValue>=self.progress.totalUnitCount && self.progress.failedError) {
#warning Show a cross and fade to a retry icon if we have a retryBlock
			BMFCrossView *crossView = [BMFCrossView new];
			[self addSubview:crossView];
			
			
			crossView.translatesAutoresizingMaskIntoConstraints = NO;
			[BMFAutoLayoutUtils fill:crossView parent:self margin:0];
			
			crossView.alpha = 0;
			[UIView animateWithDuration:0.1 animations:^{
				crossView.alpha = 1;
			} completion:^(BOOL finished) {
				double delayInSeconds = self.crossHideDelay;
				dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
				dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
					[UIView animateWithDuration:0.1 animations:^{
						crossView.alpha = 0;
					} completion:^(BOOL finished) {
						[crossView removeFromSuperview];
					}];
				});
			}];
		}
	}];
}


- (void) addToViewController:(UIViewController *) vc {
	[vc.view addSubview:self];
	[vc.view bringSubviewToFront:self];
	
	[BMFAutoLayoutUtils centerView:self inParent:vc.view];
}

@end
