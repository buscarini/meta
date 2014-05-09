//
//  BMFHUDLoaderView.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 11/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFHUDLoaderView.h"

#import "BMFAutoLayoutUtils.h"
#import "BMFCrossView.h"
#import <ReactiveCocoa/RACEXTScope.h>

#import <ReactiveCocoa/ReactiveCocoa.h>

#import <QuartzCore/QuartzCore.h>

@implementation BMFHUDLoaderView

- (void) performInit {
	[super performInit];
	
	self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
	
	RAC(self.layer,cornerRadius) = RACObserve(self, cornerRadius);
	
	self.cornerRadius = 10;
	
	self.loaderView = [[UIActivityIndicatorView alloc] init];
	self.loaderView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
	self.loaderView.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self addSubview:self.loaderView];
	
	self.messageLabel = [UILabel new];
	self.messageLabel.textAlignment = NSTextAlignmentCenter;
	self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self.messageLabel setContentCompressionResistancePriority:UILayoutPriorityRequired-1 forAxis:UILayoutConstraintAxisHorizontal];
	self.messageLabel.textColor = [UIColor whiteColor];
	[self addSubview:self.messageLabel];
	
	RAC(self.messageLabel,font) = RACObserve(self, font);
	self.font = [UIFont boldSystemFontOfSize:14];
	
	[BMFAutoLayoutUtils fillHorizontally:@[ self.loaderView, self.messageLabel ] parent:self margin:10];
	[BMFAutoLayoutUtils distributeVertically:@[ self.loaderView, self.messageLabel ] inParent:self margin:10];
	
	self.crossHideDelay = 2.0;
	self.translatesAutoresizingMaskIntoConstraints = NO;
	
	self.progress = [BMFProgress new];
	
	@weakify(self);
	[[RACObserve(self, progress.running) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSNumber *loading) {
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
	
	RAC(self.messageLabel,text) = [RACObserve(self, progress.progressMessage) deliverOn:[RACScheduler mainThreadScheduler]];
	
	[[RACObserve(self, progress.fractionCompleted) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSNumber *completed) {
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
