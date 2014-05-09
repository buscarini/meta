//
//  BMFAdjustContentInsetsBehavior.h
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 24/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFViewControllerBehavior.h"

@interface BMFAdjustContentInsetsBehavior : BMFViewControllerBehavior

@property (nonatomic, weak) UIScrollView *scrollView;

- (instancetype) initWithView:(UIScrollView *) scrollView;

@end
