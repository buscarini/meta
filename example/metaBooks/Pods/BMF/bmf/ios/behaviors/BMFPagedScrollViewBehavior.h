//
//  BMFPagedScrollViewBehavior.h
//  Example
//
//  Created by Jose Manuel Sánchez Peñarroja on 25/03/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFScrollViewViewControllerBehavior.h"

@interface BMFPagedScrollViewBehavior : BMFScrollViewViewControllerBehavior

@property (nonatomic, weak) UIPageControl *pageControl;

- (instancetype) initWithView:(UIScrollView *) scrollView pageControl:(UIPageControl *) pageControl;


@end
