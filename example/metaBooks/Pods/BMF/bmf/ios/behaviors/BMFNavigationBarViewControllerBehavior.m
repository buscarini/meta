//
//  BMFNavigationBarViewControllerBehavior.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 18/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFNavigationBarViewControllerBehavior.h"

@implementation BMFNavigationBarViewControllerBehavior {
	BOOL _wasHidden;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _navigationBarHidden = YES;
		_restoreOnDisappear = YES;
		_animated = YES;
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
	_wasHidden = self.viewController.navigationController.navigationBarHidden;
	
	[self.viewController.navigationController setNavigationBarHidden:self.navigationBarHidden animated:self.animated];
}

- (void) viewWillDisappear:(BOOL)animated {
	if (self.restoreOnDisappear) [self.viewController.navigationController setNavigationBarHidden:_wasHidden animated:self.animated];
}

@end
