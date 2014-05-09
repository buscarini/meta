//
//  UIScrollView+BMF.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 26/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMFTypes.h"

@interface UIScrollView (BMF)

/// Adds views of the same size than the scroll view distributed along the axis specified. This is useful for having a scrollview with paging.
- (NSArray *) BMF_addPagedContainerViews:(NSUInteger) numPages axis:(BMFLayoutConstraintAxis) axis class:(id) containerViewClass;

@end
