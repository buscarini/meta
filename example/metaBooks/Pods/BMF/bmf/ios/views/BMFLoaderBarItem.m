//
//  BMFLoaderBarItem.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 21/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFLoaderBarItem.h"

#import "BMF.h"

#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

#import <objc/message.h>

@interface BMFLoaderBarItem()

//@property (nonatomic, strong) UIToolbar *reloadBar;
//@property (nonatomic, strong) UIImageView *reloadImageView;
@property (nonatomic, strong) UIButton *reloadButton;
@property (nonatomic, strong) UIView *emptyView;


@end

@implementation BMFLoaderBarItem

#pragma mark Init methods

+ (BMFLoaderBarItem *) barItem {
	
	UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];

	return [[BMFLoaderBarItem alloc] initWithCustomView:activityIndicator];
}

- (void) performInit {
	
	[super performInit];
	
	self.loaderView = (UIActivityIndicatorView *)self.customView;

	[self.loaderView startAnimating];
	self.loaderView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
	self.loaderView.color = [UIColor blackColor];
	
	self.emptyView = [UIView new];

	self.progress = [BMFProgress new];
	
	UIImage *reloadImage = [[BMFBase sharedInstance] imageNamed:@"reload"];
	self.reloadButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[self.reloadButton setImage:reloadImage forState:UIControlStateNormal];
	RAC(self.reloadButton,rac_command) = RACObserve(self, rac_command);
	
//	self.reloadButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//		[self reload:input];
//		return [RACSignal empty];
//	}];
	
//	[[[self.reloadButton rac_command] executionSignals] subscribeNext:^(id x) {
//		[self reload:x];
//	}];
	self.reloadButton.frame = self.loaderView.frame;
	CGFloat inset = MAX(self.reloadButton.frame.size.width-reloadImage.size.width,0);
	inset /= 2;
	self.reloadButton.contentEdgeInsets = UIEdgeInsetsMake(0, inset, 0, inset);
	self.reloadButton.contentMode = UIViewContentModeCenter;
	
	@weakify(self)
	[RACObserve(self, progress.running) subscribeNext:^(NSNumber *loading) {
		@strongify(self);
		if (loading.boolValue) {
			self.customView = self.loaderView;
			[self.loaderView startAnimating];
		}
		else if (self.reloadActionBlock) {
			self.customView = self.reloadButton;
		}
		else {
			self.customView = self.emptyView;
		}
	}];
	
//
//	
//	[[RACObserve(self, loading) throttle:0.1] subscribeNext:^(NSNumber *loading) {
//		@strongify(self);
//		if (loading.boolValue) self.customView = self.loaderView;
//		else self.customView = self.reloadButton;
//	}];
	
}

- (void) reload: (id) sender {
	objc_msgSend(self.target, self.action);
//	[self.target performSelector:self.action];
	if (self.reloadActionBlock) self.reloadActionBlock(self);
}

- (void) addToViewController:(UIViewController *) vc {
	if (self.isRightButton) {
		vc.navigationItem.rightBarButtonItem = self;
	}
	else {
		vc.navigationItem.leftBarButtonItem = self;
	}
}


@end
