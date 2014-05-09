//
//  TRNHomeScreenItem.m
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 13/12/13.
//  Copyright (c) 2013 treenovum. All rights reserved.
//

#import "BMFHomeScreenItem.h"

#import "BMFAutoLayoutUtils.h"

#import "BMFBadgeView.h"

@implementation BMFHomeScreenItem {
	UITapGestureRecognizer *tapRecognizer;
	BMFBadgeView *badgeView;
}

- (void) performInit {
	
	self.translatesAutoresizingMaskIntoConstraints = NO;
	
	self.badgeColor = [UIColor redColor];
	self.badgeTextColor = [UIColor whiteColor];
	
	BMFView *iconContainerView = [BMFView new];
	[self addSubview:iconContainerView];
	
	UIImageView *iconView = [UIImageView new];

	iconView.translatesAutoresizingMaskIntoConstraints = NO;
	iconView.contentMode = UIViewContentModeCenter;
	self.imageView = iconView;
	
	[BMFAutoLayoutUtils sizeEqualContent:iconView];
	
	[iconContainerView addSubview:iconView];
	[self addSubview:iconContainerView];
	
	[BMFAutoLayoutUtils centerView:iconView inParent:iconContainerView];
	[BMFAutoLayoutUtils constraint:@[ iconView ] toParent:iconContainerView margin:0];
	
	BMFActionLabel *label = [BMFActionLabel new];
	[self addSubview:label];
	label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
	label.textAlignment = NSTextAlignmentCenter;
	label.translatesAutoresizingMaskIntoConstraints = NO;
	label.numberOfLines = 0;
	label.lineBreakMode = NSLineBreakByWordWrapping;
	label.minimumScaleFactor = 0.5;
	label.adjustsFontSizeToFitWidth = YES;
	self.textLabel = label;
	
	[BMFAutoLayoutUtils sizeGreaterEqualContent:label];
	
	[self updateBadge];
	
	[BMFAutoLayoutUtils fillHorizontally:@[ iconContainerView, label ] parent:self margin:0];
	[BMFAutoLayoutUtils distributeVertically:@[ iconContainerView, label ] inParent:self margin:0];
	
	NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:iconContainerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeHeight multiplier:1 constant:10];
	constraint.priority = UILayoutPriorityRequired-1;
	[self addConstraint:constraint];
	
//	tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//	[self addGestureRecognizer:tapRecognizer];
}

- (void) dealloc {
	[self removeGestureRecognizer:tapRecognizer];
}

- (void) setBadgeColor:(UIColor *)badgeColor {
	_badgeColor = badgeColor;
	[self updateBadge];
}

- (void) setBadgeString:(NSString *)badgeString {
	_badgeString = [badgeString copy];
	[self updateBadge];
}

- (void) setActionBlock:(BMFActionBlock)actionBlock {
	_actionBlock = [actionBlock copy];
	if (_actionBlock) {
		tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
		[self addGestureRecognizer:tapRecognizer];
	}
	else {
		[self removeGestureRecognizer:tapRecognizer];
		tapRecognizer = nil;
	}
}

- (void) updateBadge {
	
	[badgeView removeFromSuperview];
	if (self.badgeString.length==0) return;
	
	badgeView = [BMFBadgeView new];
	badgeView.badgeColor = self.badgeColor;
	badgeView.badgeString = self.badgeString;
	badgeView.badgeTextColor = self.badgeTextColor;
		
	[self addSubview:badgeView];
	
	badgeView.translatesAutoresizingMaskIntoConstraints = NO;
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:badgeView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:badgeView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
	
//	[BMFAutoLayoutUtils equalTops:@[ badgeView, self.imageView ] inParent:self];
//	[BMFAutoLayoutUtils equalRights:@[ badgeView, self.imageView ] inParent:self];
}

- (void) tap: (UIGestureRecognizer *) recognizer {
	if (self.actionBlock) self.actionBlock(self);
}

@end
