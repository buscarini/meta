//
//  UITableView+BMF.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 29/01/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "UITableView+BMF.h"

@implementation UITableView (BMF)

- (void) BMF_hideSeparatorsForEmptyCells {
	UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
	self.tableFooterView = footer;
}

- (void) BMF_updateDelegate:(id)delegate {
	self.delegate = nil;
	self.delegate = delegate;
}

@end
