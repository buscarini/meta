//
//  BMFHomeScreenItemCell.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 06/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFHomeScreenItemCell.h"

#import "BMFAutoLayoutUtils.h"

@implementation BMFHomeScreenItemCell

@synthesize tapBlock = _tapBlock;

- (void) performInit {
	[super performInit];
	
	self.item = [BMFHomeScreenItem new];
}

- (void) setTapBlock:(BMFActionBlock)tapBlock {
	_tapBlock = [tapBlock copy];
	self.item.actionBlock = tapBlock;
}

- (BMFActionBlock) tapBlock {
	return self.item.actionBlock;
}

- (void) setItem:(BMFHomeScreenItem *)item {
	[self.item removeFromSuperview];
	
	_item = item;
	_item.actionBlock = self.tapBlock;
	
	[self addSubview:item];
	
	[self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
	[self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
	
	[BMFAutoLayoutUtils centerView:item inParent:self];
	[BMFAutoLayoutUtils constraint:@[ item ] toParent:self margin:0];
}

@end
