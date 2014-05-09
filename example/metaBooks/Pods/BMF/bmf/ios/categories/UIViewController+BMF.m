//
//  UIViewController+BMFUtils.m
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import "UIViewController+BMF.h"

@implementation UIViewController (BMF)

- (void) BMF_addChild:(UIViewController *) detailVC addSubviewBlock:(BMFActionBlock) block {
	BMFAssertReturn(block);

//	if (!block) {
//		[NSException raise:@"You should provide a block where you add the vc view in your hierarchy" format:@"parent: %@ child: %@",self,detailVC];
//	}
//	
	[self addChildViewController:detailVC];
	
	if (block) block(self);
	
	[detailVC didMoveToParentViewController:self];
}

@end
