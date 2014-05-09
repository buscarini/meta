//
//  BMFBadgeView.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 28/01/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFBadgeView.h"

#import "BMFAutoLayoutUtils.h"

#import <QuartzCore/QuartzCore.h>

@implementation BMFBadgeView {
	UILabel *badgeLabel;
}

- (void) performInit {
	
	self.badgeColor = [UIColor colorWithRed:0.980 green:0.000 blue:0.008 alpha:1.000];
	
	badgeLabel = [UILabel new];
	badgeLabel.text = self.badgeString;
	
	badgeLabel.textColor = self.badgeTextColor;
	badgeLabel.font = [UIFont systemFontOfSize:12];
	
	self.backgroundColor = self.badgeColor;
	self.layer.cornerRadius = MIN(self.bounds.size.height/2,self.bounds.size.width/2);
	self.layer.masksToBounds = YES;
	
	[self addSubview:badgeLabel];
	
	[badgeLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
	[badgeLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
	[badgeLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
	[badgeLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
	
	[BMFAutoLayoutUtils fillHorizontally:@[ badgeLabel ] parent:self margin:5];
	[BMFAutoLayoutUtils fillVertically:@[ badgeLabel ] parent:self margin:1];
	
	[self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

- (void) setBadgeString:(NSString *)badgeString {
	badgeLabel.text = badgeString;
	if (badgeString.length==0 || [badgeString isEqualToString:@"0"]) self.hidden = YES;
	else self.hidden = NO;
}

- (void) setBadgeColor:(UIColor *)badgeColor {
	self.backgroundColor = badgeColor;
}

- (void) setBadgeTextColor:(UIColor *)badgeTextColor {
	badgeLabel.textColor = badgeTextColor;
}

- (void) layoutSubviews {
	[super layoutSubviews];
	self.layer.cornerRadius = MIN(self.bounds.size.height/2,self.bounds.size.width/2);
}

@end
