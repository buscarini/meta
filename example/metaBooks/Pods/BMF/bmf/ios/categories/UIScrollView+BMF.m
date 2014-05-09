//
//  UIScrollView+BMF.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 26/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "UIScrollView+BMF.h"

#import "BMFAutoLayoutUtils.h"

@implementation UIScrollView (BMF)

- (NSArray *) BMF_addPagedContainerViews:(NSUInteger) numPages axis:(BMFLayoutConstraintAxis) axis class:(id) containerViewClass {
	
	NSMutableArray *containerArray = [NSMutableArray array];
	for (int i=0;i<numPages;i++) {
		id containerView = [containerViewClass new];
		[self addSubview:containerView];
		[containerArray addObject:containerView];
	}
	
	if (axis==BMFLayoutConstraintAxisHorizontal) {
		[BMFAutoLayoutUtils fillVertically:containerArray parent:self margin:0];
		[BMFAutoLayoutUtils distributeHorizontally:containerArray inParent:self margin:0];
	}
	else {
		[BMFAutoLayoutUtils fillHorizontally:containerArray parent:self margin:0];
		[BMFAutoLayoutUtils distributeVertically:containerArray inParent:self margin:0];
	}
	
	[BMFAutoLayoutUtils equalWidths:containerArray];
	[BMFAutoLayoutUtils equalWidths:@[ containerArray.firstObject, self ]];
	
	[BMFAutoLayoutUtils equalHeights:containerArray];
	[BMFAutoLayoutUtils equalHeights:@[ containerArray.firstObject, self ]];


	return containerArray;
}

@end
