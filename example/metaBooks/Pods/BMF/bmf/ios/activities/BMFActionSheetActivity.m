//
//  BMFActionSheetActivity.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFActionSheetActivity.h"

#import "BMF.h"
#import "BMFActionSheet.h"

@implementation BMFActionSheetActivity

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.showsCancelButton = YES;
		self.showMode = BMFActionSheetActivityShowInView;
		self.showAnimated = YES;
    }
    return self;
}

- (void) run:(BMFCompletionBlock)completionBlock {
	
	BMFAssertReturn(self.viewController);

	BMFAssertReturn(self.children.count>0);
		
	BMFActionSheet *actionSheet = [[BMFActionSheet alloc] initWithTitle:self.name];

	for (id<BMFActivityProtocol> activity in self.children) {
		[actionSheet BMF_addButtonWithTitle:activity.name actionBlock:^(id sender) {
			activity.viewController = self.viewController;
			[activity run:completionBlock];
		}];
	}

	if (self.showsCancelButton) {
		[actionSheet BMF_addCancelButtonWithTitle:BMFLocalized(@"Cancel", nil) actionBlock:^(id sender) {
			if (completionBlock) completionBlock(nil,nil);
		}];
	}

	if (self.showMode==BMFActionSheetActivityShowInView) {
		[actionSheet showInView:self.viewController.view];
	}
	else if (self.showMode==BMFActionSheetActivityShowFromTabBar) {
		[actionSheet showFromTabBar:self.viewController.tabBarController.tabBar];
	}
	else if (self.showMode==BMFActionSheetActivityShowFromBarButtonItem) {
		[actionSheet showFromBarButtonItem:self.barButtonItem animated:self.showAnimated];
	}
	else if (self.showMode==BMFActionSheetActivityShowFromToolbar) {
		[actionSheet showFromToolbar:self.toolbar];
	}
	else if (self.showMode==BMFActionSheetActivityShowFromRect) {
		[actionSheet showFromRect:self.rect inView:self.viewController.view animated:self.showAnimated];
	}
	else {
		[NSException raise:@"Unknown showMode" format:@"%lu",(unsigned long)self.showMode];
	}
}

@end
