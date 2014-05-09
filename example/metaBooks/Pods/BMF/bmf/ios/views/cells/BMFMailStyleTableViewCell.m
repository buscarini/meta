//
//  BMFMailStyleTableViewCell.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 13/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFMailStyleTableViewCell.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation BMFMailStyleTableViewCell

- (void) performInit {
	__weak BMFMailStyleTableViewCell *wself = self;
	self.photoView.clipsToBounds = YES;
	
	self.imageWidth = 50;
	
	self.imageViewContentMode = UIViewContentModeScaleAspectFill;
	[RACObserve(self, photoView.image) subscribeNext:^(id x) {
		self.photoView.contentMode = self.imageViewContentMode;
		if (x) {
			wself.imageLeftConstraint.constant = 5;
			wself.imageWidthConstraint.constant = wself.imageWidth;
		}
		else {
			wself.imageLeftConstraint.constant = 0;
			wself.imageWidthConstraint.constant = 0;
		}
		[wself layoutIfNeeded];
	}];
}

@end
