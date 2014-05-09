//
//  BMFAdjustContentInsetsBehavior.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFAdjustContentInsetsBehavior.h"

#import "BMFTypes.h"

@implementation BMFAdjustContentInsetsBehavior

- (instancetype) initWithView:(UIScrollView *)scrollView {
	BMFAssertReturnNil(scrollView);
	
    self = [super init];
    if (self) {
		self.scrollView = scrollView;
	}
    return self;
}

- (instancetype)init {
	[NSException raise:@"Needs a scroll view." format:@"Use initWithView instead"];
    return nil;
}

- (void) viewDidAppear:(BOOL)animated {
	self.scrollView.contentInset = UIEdgeInsetsMake(self.object.topLayoutGuide.length, self.scrollView.contentInset.left, self.object.bottomLayoutGuide.length, self.scrollView.contentInset.right);
	self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset;
	
	self.scrollView.contentOffset = CGPointMake(0,-self.scrollView.contentInset.top);
}

@end
