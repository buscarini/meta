//
//  BMFCellConfigurator.m
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 01/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFSingleViewConfigurator.h"

#import "BMFTypes.h"

@implementation BMFSingleViewConfigurator

+ (Class) viewClass {
	[NSException raise:@"Your subclass must implement viewClass" format:@""];
	return nil;
}

+ (Class) itemClass {
	[NSException raise:@"Your subclass must implement itemClass" format:@""];
	return nil;
}


+ (BOOL) canConfigure:(id) view kind:(BMFViewKind)kind withItem:(id) item inView:(id)containerView {
	if ([view isKindOfClass:[self viewClass]] && [item isKindOfClass:[self itemClass]]) return YES;
	return NO;
}

+ (void) configure:(id) view kind:(BMFViewKind)kind withItem:(id) item inView:(UIView *)containerView atIndexPath:(NSIndexPath *)indexPath controller:(id)controller {
	[NSException raise:@"Your subclass must implement configure:with:inView:atIndexPath:" format:@""];
}


@end
