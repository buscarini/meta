//
//  BMFCellConfiguratorProtocol.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 01/04/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BMFViewRegisterProtocol.h"

@protocol BMFViewConfiguratorProtocol <NSObject>

+ (BOOL) canConfigure:(id) view kind:(BMFViewKind)kind withItem:(id) item inView:(id)view;
+ (void) configure:(id) view kind:(BMFViewKind)kind withItem:(id)item inView:(UIView *) containerView atIndexPath:(NSIndexPath *) indexPath controller:(id) controller;

@optional

+ (CGFloat) heightOf:(id) view kind:(BMFViewKind)kind withItem:(id) item inView:(UIView *) containerView atIndexPath:(NSIndexPath *) indexPath;

@end
