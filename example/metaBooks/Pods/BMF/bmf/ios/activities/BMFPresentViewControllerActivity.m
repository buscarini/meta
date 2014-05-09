//
//  BMFPresentViewControllerActivity.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 18/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFPresentViewControllerActivity.h"

@implementation BMFPresentViewControllerActivity

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mode = BMFPresentViewControllerActivityModePush;
		self.animated = YES;
    }
    return self;
}

- (void) run:(BMFCompletionBlock)completionBlock {
	
	BMFAssertReturn(self.viewController);
	
	if (self.mode==BMFPresentViewControllerActivityModeSegue) {
		NSString *segueId = [NSString BMF_cast:self.value];
		
		BMFAssertReturn(segueId);
		
		[self.viewController performSegueWithIdentifier:segueId sender:self];
		if (completionBlock) completionBlock(self.viewController,nil);
	}
	else if (self.mode==BMFPresentViewControllerActivityModePush) {
		BMFAssertReturn(self.viewController.navigationController);
		
		UIViewController *vc = [UIViewController BMF_cast:self.value];
		BMFAssertReturn(vc);
		
		[self.viewController.navigationController pushViewController:vc animated:self.animated];
		if (completionBlock) completionBlock(nil,nil);
	}
	else if (self.mode==BMFPresentViewControllerActivityModeModal) {
		UIViewController *vc = [UIViewController BMF_cast:self.value];
		BMFAssertReturn(vc);
		
		[self.viewController presentViewController:vc animated:self.animated completion:^{
			if (completionBlock) completionBlock(nil,nil);
		}];
	}
	else {
		[NSException raise:@"Unknown present mode" format:@"%lu",(long)self.mode];
	}
}

@end
