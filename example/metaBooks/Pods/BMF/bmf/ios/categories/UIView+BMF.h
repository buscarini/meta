//
//  UIView+BMF.h
//  Bonacasa
//
//  Created by Jose Manuel Sánchez Peñarroja on 14/01/14.
//  Copyright (c) 2014 treenovum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BMF)

- (void) BMF_removeAllSubviews;
- (void) BMF_removeAllExcept:(NSArray *) views;

// Removes all constraints stored here and in the parent that affect this view
- (void) BMF_removeAllConstraints;

/// Removes all the constraints that make a reference to any view in the subviews array
- (void) BMF_RemoveConstraintsWithViews:(NSArray *) subviews;

@end
