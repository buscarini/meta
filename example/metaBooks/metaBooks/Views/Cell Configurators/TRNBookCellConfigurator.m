//
//  TRNBookCellConfigurator.m
//  metaBooks
//
//  Created by Jose Manuel Sánchez Peñarroja on 08/05/14.
//  Copyright (c) 2014 Treenovum. All rights reserved.
//

#import "TRNBookCellConfigurator.h"

#import "TRNBook.h"

@implementation TRNBookCellConfigurator

+ (void) load {
	[self register];
}

+ (Class) itemClass {
	return [TRNBook class];
}

+ (Class) viewClass {
	return [UITableViewCell class];
}

+ (void) configure:(id)view kind:(BMFViewKind)kind withItem:(id)item inView:(UIView *)containerView atIndexPath:(NSIndexPath *)indexPath controller:(id)controller {
	
	UITableViewCell *cell = view;
	TRNBook *book = item;
	
	cell.textLabel.text = book.title;
	cell.detailTextLabel.text = book.author;
}

@end
