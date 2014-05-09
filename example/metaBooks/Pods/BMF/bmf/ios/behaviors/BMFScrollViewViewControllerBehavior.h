//
//  BMFScrollViewViewControllerBehavior.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 25/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFViewControllerBehavior.h"

@interface BMFScrollViewViewControllerBehavior : BMFViewControllerBehavior <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

- (instancetype) initWithView:(UIScrollView *) scrollView;

@end
