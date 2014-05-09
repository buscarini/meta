//
//  BMFView.m
//  BMF
//
//  Created by Jose Manuel Sánchez Peñarroja on 13/12/13.
//  Copyright (c) 2013 Jose Manuel Sánchez. All rights reserved.
//

#import "BMFView.h"

@implementation BMFView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self performInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self performInit];
    }
    return self;
}


/// Template method
- (void) performInit {
	
}

@end
