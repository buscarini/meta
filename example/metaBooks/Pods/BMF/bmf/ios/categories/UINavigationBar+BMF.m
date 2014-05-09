//
//  UINavigationBar+BMF.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 18/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "UINavigationBar+BMF.h"

@implementation UINavigationBar (BMF)

- (void) BMF_showWithTransition:(UIViewAnimationTransition) transition {
	[self BMF_changeWithTransition:transition hide:NO];
}

- (void) BMF_hideWithTransition:(UIViewAnimationTransition) transition {
	[self BMF_changeWithTransition:transition hide:YES];
}

- (void) BMF_changeWithTransition:(UIViewAnimationTransition) transition hide:(BOOL) hide {
	[UINavigationBar beginAnimations:@"NavBarFadeOut" context:nil];
	if (hide) self.alpha = 1;
	else self.alpha = 0;
    [UINavigationBar setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UINavigationBar setAnimationDuration:0.5];
    [UINavigationBar setAnimationTransition:UIViewAnimationTransitionCurlUp
                                    forView:self
                                      cache:YES];
	if (hide) self.alpha = 0;
	else self.alpha = 1;
	
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [UINavigationBar commitAnimations];
}


@end
