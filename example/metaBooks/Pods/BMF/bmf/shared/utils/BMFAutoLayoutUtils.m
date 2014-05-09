//
//  TRNAutoLayoutUtils.m
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 17/12/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFAutoLayoutUtils.h"

#import "BMFTypes.h"

@implementation BMFAutoLayoutUtils

+ (BMFLayoutPriority) defaultLayoutPriority {
	return BMFLayoutPriorityRequired;
}

+ (NSArray *) fill:(BMFIXView *)view parent:(BMFIXView *) parent margin:(CGFloat) margin {
	return [self fill:view parent:parent margin:margin priority:BMFLayoutPriorityRequired];
}

+ (NSArray *) fill:(BMFIXView *)view parent:(BMFIXView *) parent margin:(CGFloat) margin priority:(BMFLayoutPriority) priority {
	return @[
			 [self fillHorizontally:@[view] parent:parent margin:margin priority:priority],
			 [self fillVertically:@[view] parent:parent margin:margin priority:priority]
			 ];
}

+ (NSArray *) fillHorizontally:(NSArray *)views parent:(BMFIXView *) parent margin:(CGFloat) margin {
	return [self fillHorizontally:views parent:parent margin:margin priority:[self defaultLayoutPriority]];
}

+ (NSArray *) fillVertically:(NSArray *)views parent:(BMFIXView *) parent margin:(CGFloat) margin {
	return [self fillVertically:views parent:parent margin:margin priority:[self defaultLayoutPriority]];
}

#pragma mark Canonical
+ (NSArray *) fillHorizontally:(NSArray *)views parent:(BMFIXView *) parent margin:(CGFloat) margin priority:(BMFLayoutPriority) priority {
	BMFAssertReturnNil(views.count>0);
	
	NSMutableArray *results = [NSMutableArray array];
	for (BMFIXView *view in views) {
		view.translatesAutoresizingMaskIntoConstraints = NO;
		
		NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:parent attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:-margin];
		constraint.priority = priority;
		[parent addConstraint:constraint];
		constraint = [NSLayoutConstraint constraintWithItem:parent attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:margin];
		constraint.priority = priority;
		[parent addConstraint:constraint];

		[results addObject:constraint];
	}
	
	return results;
}

#pragma mark Canonical
+ (NSArray *) fillVertically:(NSArray *)views parent:(BMFIXView *) parent margin:(CGFloat) margin priority:(BMFLayoutPriority) priority {
	BMFAssertReturnNil(views.count>0);
	
	NSMutableArray *results = [NSMutableArray array];
	
	for (BMFIXView *view in views) {
		view.translatesAutoresizingMaskIntoConstraints = NO;
		NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:parent attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:-margin];
		constraint.priority = priority;
		[parent addConstraint:constraint];
		constraint = [NSLayoutConstraint constraintWithItem:parent attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:margin];
		constraint.priority = priority;
		[parent addConstraint:constraint];
		
		[results addObject:constraint];
	}
	
	return results;
}

#pragma mark Constraint

+ (NSArray *) constraint:(NSArray *) views toParent:(BMFIXView *) parent margin:(CGFloat) margin {
	return @[
			 [self constraintHorizontally:views toParent:parent margin:margin priority:[self defaultLayoutPriority]],
			 [self constraintVertically:views toParent:parent margin:margin priority:[self defaultLayoutPriority]]
			  ];
}

#pragma mark Canonical
+ (NSArray *) constraintHorizontally:(NSArray *) views toParent:(BMFIXView *) parent margin:(CGFloat) margin priority:(BMFLayoutPriority) priority {
	BMFAssertReturnNil(views.count>0);
	
	NSMutableArray *results = [NSMutableArray array];
	
	for (BMFIXView *view in views) {
		view.translatesAutoresizingMaskIntoConstraints = NO;
		NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:parent attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationLessThanOrEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:-margin];
		constraint.priority = priority;
		[parent addConstraint:constraint];
		constraint = [NSLayoutConstraint constraintWithItem:parent attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:margin];
		constraint.priority = priority;
		[parent addConstraint:constraint];
		
		[results addObject:constraint];
	}
	
	return results;
}

#pragma mark Canonical
+ (NSArray *) constraintVertically:(NSArray *) views toParent:(BMFIXView *) parent margin:(CGFloat) margin priority:(BMFLayoutPriority) priority {
	BMFAssertReturnNil(views.count>0);
	
	NSMutableArray *results = [NSMutableArray array];
	
	for (BMFIXView *view in views) {
		view.translatesAutoresizingMaskIntoConstraints = NO;
		NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:parent attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationLessThanOrEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:-margin];
		constraint.priority = priority;
		[parent addConstraint:constraint];
		constraint = [NSLayoutConstraint constraintWithItem:parent attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:margin];
		constraint.priority = priority;
		[parent addConstraint:constraint];
		
		[results addObject:constraint];
	}
	
	return results;
}

#pragma mark center

+ (NSArray *) centerView:(BMFIXView *) view inParent:(BMFIXView *)parent {
	return @[
			 [BMFAutoLayoutUtils centerVertically:@[view] inParent:parent margin:0],
			 [BMFAutoLayoutUtils centerHorizontally:@[view] inParent:parent margin:0]
			 ];
}

#pragma mark Canonical
+ (NSArray *) centerVertically:(NSArray *) views inParent:(BMFIXView *)parent margin:(CGFloat) margin {
	BMFAssertReturnNil(views.count>0);
	
	NSMutableArray *results = [NSMutableArray array];
	
	for (BMFIXView *view in views) {
		view.translatesAutoresizingMaskIntoConstraints = NO;
		NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:parent attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:margin];

		[results addObject:constraint];
	}
	
	[parent addConstraints:results];
	
	return results;
}

#pragma mark Canonical
+ (NSArray *) centerHorizontally:(NSArray *) views inParent:(BMFIXView *)parent margin:(CGFloat) margin {
	BMFAssertReturnNil(views.count>0);
	
	NSMutableArray *results = [NSMutableArray array];
	
	for (BMFIXView *view in views) {
		view.translatesAutoresizingMaskIntoConstraints = NO;
		NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:parent attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:margin];
		[results addObject:constraint];
	}

	[parent addConstraints:results];
	
	return results;
}

#pragma mark Canonical
+ (NSArray *) distributeHorizontally: (NSArray *)views inParent:(BMFIXView *)parent margin:(CGFloat) margin {
	BMFAssertReturnNil(views.count>0);
	
	NSMutableArray *results = [NSMutableArray array];

	[views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		BMFIXView *view = obj;
		
		view.translatesAutoresizingMaskIntoConstraints = NO;
		
		if (idx==0) {
			[results addObject:[NSLayoutConstraint constraintWithItem:parent attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:-margin]];
		}
		else {
			BMFIXView *previous = views[idx-1];
			
			[results addObject:[NSLayoutConstraint constraintWithItem:previous attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:-margin]];
		}
		
		if (idx==views.count-1) {
			[results addObject:[NSLayoutConstraint constraintWithItem:parent attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:margin]];
			
		}
	}];
	
	[parent addConstraints:results];
	
	return results;
}

#pragma mark Canonical
+ (NSArray *) distributeVertically: (NSArray *)views inParent:(BMFIXView *)parent margin:(CGFloat) margin {
	BMFAssertReturnNil(views.count>0);
	
	NSMutableArray *results = [NSMutableArray array];
	
	[views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		BMFIXView *view = obj;
		
		view.translatesAutoresizingMaskIntoConstraints = NO;
		
		if (idx==0) {
			[results addObject:[NSLayoutConstraint constraintWithItem:parent attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:-margin]];
		}
		else {
			BMFIXView *previous = views[idx-1];
			
			[results addObject:[NSLayoutConstraint constraintWithItem:previous attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:-margin]];
		}
		
		if (idx==views.count-1) {
			[results addObject:[NSLayoutConstraint constraintWithItem:parent attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:margin]];
			
		}
	}];
	
	[parent addConstraints:results];
	
	return results;
}

#pragma mark Content size (hugging and compression resistance)

+ (void) sizeEqualContent: (BMFIXView *) view {
	[self sizeGreaterEqualContent:view];
	[self sizeSmallerEqualContent:view];
}

+ (void) sizeGreaterEqualContent: (BMFIXView *) view {
	[self setContentCompressionResistance:view priority:BMFLayoutPriorityRequired axis:BMFLayoutConstraintAxisHorizontal];
	[self setContentCompressionResistance:view priority:BMFLayoutPriorityRequired axis:BMFLayoutConstraintAxisVertical];
}

+ (void) sizeSmallerEqualContent: (BMFIXView *) view {
	[self setContentHugging:view priority:BMFLayoutPriorityRequired axis:BMFLayoutConstraintAxisHorizontal];
	[self setContentHugging:view priority:BMFLayoutPriorityRequired axis:BMFLayoutConstraintAxisVertical];
}

#pragma Size with constants

#pragma Equal size
+ (NSArray *) sizeEqual: (BMFIXView *) view constant:(CGSize) size {
	return [self sizeEqual:view constant:size priority:[self defaultLayoutPriority]];
}

+ (NSArray *) sizeEqual: (BMFIXView *) view constant:(CGSize) size priority:(BMFLayoutPriority) priority {
	return @[ 
			[self widthEqual:view constant:size.width priority:priority],
		 	[self heightEqual:view constant:size.height priority:priority]
			];
}

+ (NSLayoutConstraint *) widthEqual: (BMFIXView *) view constant:(CGFloat) constant {
	return [self widthEqual:view constant:constant priority:[self defaultLayoutPriority]];
}

#pragma mark Canonical
+ (NSLayoutConstraint *) widthEqual: (BMFIXView *) view constant:(CGFloat) constant priority:(BMFLayoutPriority) priority {
	BMFAssertReturnNil(view);
	NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
	[view addConstraint:constraint];
	return constraint;
}

+ (NSLayoutConstraint *) heightEqual: (BMFIXView *) view constant:(CGFloat) constant {
	return [self heightEqual:view constant:constant priority:[self defaultLayoutPriority]];
}

#pragma mark Canonical
+ (NSLayoutConstraint *) heightEqual: (BMFIXView *) view constant:(CGFloat) constant priority:(BMFLayoutPriority) priority {
	BMFAssertReturnNil(view);
	NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
	[view addConstraint:constraint];
	return constraint;
}

#pragma Less or equal

+ (NSArray *) sizeLessOrEqual: (BMFIXView *) view constant:(CGSize) size {
	return [self sizeLessOrEqual:view constant:size priority:[self defaultLayoutPriority]];
}

+ (NSArray *) sizeLessOrEqual: (BMFIXView *) view constant:(CGSize) size priority:(BMFLayoutPriority) priority {
	return @[
			[self widthLessOrEqual:view constant:size.width priority:priority],
			[self heightLessOrEqual:view constant:size.height priority:priority]
			];
}

+ (NSArray *) widthLessOrEqual: (BMFIXView *) view constant:(CGFloat) constant {
	return [self widthLessOrEqual:view constant:constant priority:[self defaultLayoutPriority]];
}

#pragma mark Canonical
+ (NSLayoutConstraint *) widthLessOrEqual: (BMFIXView *) view constant:(CGFloat) constant priority:(BMFLayoutPriority) priority {
	BMFAssertReturnNil(view);
	NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];

	[view addConstraint:constraint];

	return constraint;
}

+ (NSArray *) heightLessOrEqual: (BMFIXView *) view constant:(CGFloat) constant {
	return [self heightLessOrEqual:view constant:constant priority:[self defaultLayoutPriority]];
}

#pragma mark Canonical
+ (NSLayoutConstraint *) heightLessOrEqual: (BMFIXView *) view constant:(CGFloat) constant priority:(BMFLayoutPriority) priority {
	BMFAssertReturnNil(view);
	NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
	
	[view addConstraint:constraint];
	
	return constraint;
}

#pragma Greater or equal

+ (NSArray *) sizeGreaterOrEqual: (BMFIXView *) view constant:(CGSize) size {
	return [self sizeGreaterOrEqual:view constant:size priority:[self defaultLayoutPriority]];
}

+ (NSArray *) sizeGreaterOrEqual: (BMFIXView *) view constant:(CGSize) size priority:(BMFLayoutPriority) priority {
	return @[
			[self widthGreaterOrEqual:view constant:size.width priority:priority],
			[self heightGreaterOrEqual:view constant:size.height priority:priority]
			];
}

+ (NSLayoutConstraint *) widthGreaterOrEqual: (BMFIXView *) view constant:(CGFloat) constant {
	return [self widthGreaterOrEqual:view constant:constant priority:[self defaultLayoutPriority]];
}

#pragma mark Canonical
+ (NSLayoutConstraint *) widthGreaterOrEqual: (BMFIXView *) view constant:(CGFloat) constant priority:(BMFLayoutPriority) priority {
	BMFAssertReturnNil(view);
	NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
	[view addConstraint:constraint];
	return constraint;	
}

+ (NSLayoutConstraint *) heightGreaterOrEqual: (BMFIXView *) view constant:(CGFloat) constant {
	return [self heightGreaterOrEqual:view constant:constant priority:[self defaultLayoutPriority]];
}

#pragma mark Canonical
+ (NSLayoutConstraint *) heightGreaterOrEqual: (BMFIXView *) view constant:(CGFloat) constant priority:(BMFLayoutPriority) priority {
	BMFAssertReturnNil(view);
	NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
	[view addConstraint:constraint];
	return constraint;
}

#pragma mark Equal sizes

+ (NSArray *) equalWidths: (NSArray *)views {
	BMFIXView *firstView = views.firstObject;
	return [self equalWidths:views inParent:firstView.superview];
}

+ (NSArray *) equalHeights: (NSArray *)views {
	BMFIXView *firstView = views.firstObject;
	return [self equalHeights:views inParent:firstView.superview];
}

+ (NSArray *) equalWidths: (NSArray *)views inParent:(BMFIXView *)parent {
	return [self equalWidths:views inParent:parent priority:[self defaultLayoutPriority]];
}

+ (NSArray *) equalHeights: (NSArray *)views inParent:(BMFIXView *)parent {
	return [self equalHeights:views inParent:parent priority:[self defaultLayoutPriority]];

}

+ (NSArray *) equalWidths: (NSArray *)views inParent:(BMFIXView *)parent priority:(BMFLayoutPriority)priority {
	return [self equalAttributes:views parent:parent attribute:NSLayoutAttributeWidth margin:0 priority:priority];
}

+ (NSArray *) equalHeights: (NSArray *)views inParent:(BMFIXView *)parent priority:(BMFLayoutPriority)priority {
	return [self equalAttributes:views parent:parent attribute:NSLayoutAttributeHeight margin:0 priority:priority];
}

+ (NSArray *) equalTops: (NSArray *)views {
	BMFIXView *firstView = views.firstObject;
	return [self equalTops:views inParent:firstView.superview];
}
	
+ (NSArray *) equalTops: (NSArray *)views inParent:(BMFIXView *)parent {
	return [self equalAttributes:views parent:parent attribute:NSLayoutAttributeTop margin:0 priority:[self defaultLayoutPriority]];
}

+ (NSArray *) equalBottoms: (NSArray *)views {
	BMFIXView *firstView = views.firstObject;
	return [self equalBottoms:views inParent:firstView.superview];
}
	
+ (NSArray *) equalBottoms: (NSArray *)views inParent:(BMFIXView *)parent {
	return [self equalAttributes:views parent:parent attribute:NSLayoutAttributeBottom margin:0 priority:[self defaultLayoutPriority]];
}

+ (NSArray *) equalLefts: (NSArray *)views {
	BMFIXView *firstView = views.firstObject;
	return [self equalLefts:views inParent:firstView.superview];
}
	
+ (NSArray *) equalLefts: (NSArray *)views inParent:(BMFIXView *)parent {
	return [self equalAttributes:views parent:parent attribute:NSLayoutAttributeLeft margin:0 priority:[self defaultLayoutPriority]];
}

+ (NSArray *) equalRights: (NSArray *)views {
	BMFIXView *firstView = views.firstObject;
	return [self equalRights:views inParent:firstView.superview];
}
	
+ (NSArray *) equalRights: (NSArray *)views inParent:(BMFIXView *)parent {
	return [self equalAttributes:views parent:parent attribute:NSLayoutAttributeRight margin:0 priority:[self defaultLayoutPriority]];
}

+ (NSArray *) equalCenters: (NSArray *)views {
	BMFIXView *firstView = views.firstObject;
	return [self equalCenters:views inParent:firstView.superview];
}
	
+ (NSArray *) equalCenters: (NSArray *)views inParent:(BMFIXView *)parent {
	return @[
			[self equalAttributes:views parent:parent attribute:NSLayoutAttributeCenterX margin:0 priority:[self defaultLayoutPriority]],
			[self equalAttributes:views parent:parent attribute:NSLayoutAttributeCenterY margin:0 priority:[self defaultLayoutPriority]]
			];
}

#pragma mark Canonical
+ (NSArray *) equalAttributes: (NSArray *)views parent:(BMFIXView *)parent attribute:(NSLayoutAttribute)attribute margin:(CGFloat)margin priority:(BMFLayoutPriority) priority {
	BMFAssertReturnNil(views.count>0);
	BMFIXView *previous = nil;
	
	NSMutableArray *results = [NSMutableArray array];
	
	for (BMFIXView *view in views) {
		view.translatesAutoresizingMaskIntoConstraints = NO;
		if (previous) {
			NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:previous attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view attribute:attribute multiplier:1 constant:margin];
			constraint.priority = priority;
			[parent addConstraint:constraint];
			
			[results addObject:constraint];
		}
		previous = view;
	}
	
	return results;
}

+ (NSLayoutConstraint *) copyConstraint:(NSLayoutConstraint *) constraint {
	NSLayoutConstraint *newConstraint = [NSLayoutConstraint constraintWithItem:constraint.firstItem attribute:constraint.firstAttribute relatedBy:constraint.relation toItem:constraint.secondItem attribute:constraint.secondAttribute multiplier:constraint.multiplier constant:constraint.constant];
	newConstraint.priority = constraint.priority;
	return newConstraint;
}

+ (NSLayoutConstraint *) changeConstraint:(NSLayoutConstraint *) constraint parent:(BMFIXView *) parent priority:(BMFLayoutPriority) priority {
	[parent removeConstraint:constraint];
	
	NSLayoutConstraint *newConstraint = [self copyConstraint:constraint];

	newConstraint.priority = priority;
	
	[parent addConstraint:newConstraint];
	
	return newConstraint;
}

#pragma mark Canonical
+ (void) setContentCompressionResistance:(BMFIXView *) view priority:(BMFLayoutPriority) priority axis:(BMFLayoutConstraintAxis) axis {
	BMFAssertReturn(view);
	
	view.translatesAutoresizingMaskIntoConstraints = NO;
	
	#if TARGET_OS_IPHONE
	[view setContentCompressionResistancePriority:priority forAxis:(UILayoutConstraintAxis)axis];
#else
	[view setContentCompressionResistancePriority:priority forOrientation:axis];
#endif
}

#pragma mark Canonical
+ (void) setContentHugging:(BMFIXView *) view priority:(BMFLayoutPriority) priority axis:(BMFLayoutConstraintAxis) axis {
	BMFAssertReturn(view);
	
	view.translatesAutoresizingMaskIntoConstraints = NO;
	
#if TARGET_OS_IPHONE
	[view setContentHuggingPriority:priority forAxis:(UILayoutConstraintAxis)axis];
#else
	[view setContentHuggingPriority:priority forOrientation:axis];
#endif

}


@end
