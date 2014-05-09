//
//  UINavigationBar+BMF.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 18/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (BMF)

- (void) BMF_showWithTransition:(UIViewAnimationTransition) transition;
- (void) BMF_hideWithTransition:(UIViewAnimationTransition) transition;

@end
