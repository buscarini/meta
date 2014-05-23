//
//  TRNCategoryCellConfigurator.m
//  metaBooksCoreData
//
//  Created by Jose Manuel Sánchez Peñarroja on 23/05/14.
//  Copyright (c) 2014 Treenovum. All rights reserved.
//

#import "TRNCategoryCellConfigurator.h"

#import "TRNCategory.h"

@implementation TRNCategoryCellConfigurator

+ (void) load {
	[self register];
}

+ (Class) itemClass {
	return [TRNCategory class];
}

+ (Class) viewClass {
	return [UITableViewCell class];
}

+ (void) configure:(id)view kind:(BMFViewKind)kind withItem:(id)item inView:(UIView *)containerView atIndexPath:(NSIndexPath *)indexPath controller:(id)controller {
	
	UITableViewCell *cell = view;
	TRNCategory *category = item;
	
	cell.textLabel.text = category.title;
	cell.detailTextLabel.text = @"";
	
	DDLogInfo(@"%@",category);
}

@end
