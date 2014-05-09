//
//  BMFBarButtonItem.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 21/02/14.
//  Copyright (c) 2014 José Manuel Sánchez. All rights reserved.
//

#import "BMFBarButtonItem.h"

@implementation BMFBarButtonItem

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self performInit];
//    }
//    return self;
//}

- (instancetype)initWithCustomView:(UIView *)customView
{
    self = [super initWithCustomView:customView];
    if (self) {
		[self performInit];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    self = [super initWithImage:image landscapeImagePhone:landscapeImagePhone style:style target:target action:action];
    if (self) {
        [self performInit];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    self = [super initWithImage:image style:style target:target action:action];
    if (self) {
        [self performInit];
    }
    return self;
}

- (void) performInit {
	
}

@end
