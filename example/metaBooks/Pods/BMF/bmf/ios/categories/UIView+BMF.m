//
//  UIView+BMF.m
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import "UIView+BMF.h"

@implementation UIView (BMF)

- (void) BMF_removeAllSubviews {
	for (UIView *view in self.subviews) {
		[view removeFromSuperview];
	}
}

- (void) BMF_removeAllExcept:(NSArray *) views {
	for (UIView *view in self.subviews) {
		if (![views containsObject:view]) [view removeFromSuperview];
	}
}

- (void) BMF_removeAllConstraints {
	[self removeConstraints:self.constraints];
	[self.superview BMF_RemoveConstraintsWithViews:@[ self ]];
}

- (void) BMF_RemoveConstraintsWithViews:(NSArray *) subviews {
	NSMutableArray *constraintsToRemove = [NSMutableArray array];
	for (NSLayoutConstraint *constraint in self.constraints) {
		if ([subviews containsObject:constraint.firstItem] || [subviews containsObject:constraint.secondItem]) {
			[constraintsToRemove addObject:constraint];
		}
	}
	
	[self removeConstraints:constraintsToRemove];
}

@end
